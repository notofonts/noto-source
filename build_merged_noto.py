# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Terribly hacky script for building a merged variation font "NotoSans.ttf".
# TODO: Clean it up.


import os
import shutil
import xml.etree.ElementTree as etree


BLACKLIST = []


def build_family(family):
    for target, sources in sorted(find_sources(family).items()):
        for source in sources:
            if should_rebuild_master(source):
                build_master(source)
        interpolatable = find_interpolatable_masters(family, target)
        merged_masters = [merge_masters(family, style, masters)
                          for style, masters in sorted(interpolatable.items())]
        build_variable(target, family, merged_masters)
        # TODO: Merge non-interpolatable fonts into ${target}-VF.ttf
        # but fonttools cannot do this yet.
        # https://github.com/fonttools/fonttools/issues/1059


def find_sources(family):
    """'NotoSans' -> {'NotoSans.ttf': [src*], 'NotoSans-Italic.ttf': [src*]}"""
    main_shard = 'src/%s-MM.glyphs' % family
    shards = []
    for shard in os.listdir('src'):
        path = os.path.join('src', shard)
        if shard.startswith(family) and path != main_shard:
            if shard.split('-')[0] in BLACKLIST:
                continue
            if shard.find('Display') >= 0 or shard.find('UI') >= 0:
                continue
            if shard.startswith('NotoSansMono'):
                continue
            if shard.endswith('.glyphs'):
                shards.append(path)
            elif os.path.isdir(path):
                plists = [f for f in os.listdir(path)
                          if f.endswith('.plist') and f.find('UI') < 0]
                assert len(plists) == 1, shard
                shards.append(os.path.join(path, plists[0]))
    if family == 'NotoSerif':
        shards.append('src/NotoSansAdlam/NotoSansAdlam-MM.plist')
    def include(path):
        for bad in ('Display', 'Italic', 'UI', 'Unjoined'):
            if path.find(bad) >= 0:
                return False
        return True
    return {
        '%s.ttf' % family: [main_shard] + [
            s for s in sorted(shards) if include(s)],
        '%s-Italic.ttf' % family: ['src/%s-ItalicMM.glyphs' % family],
    }


def find_interpolatable_masters(family, target):
    sources = find_sources(family)[target]
    designspace_path = designspace(family, sources[0])
    styles = [s.attrib['filename'].split('-', 1)[1].replace('.ufo', '')
              for s in etree.parse(designspace_path).findall('sources/source')]
    result = {}
    for source in sources:
        curmasters = [find_master(source, style) for style in styles]
        can_interpolate = all(os.path.exists(m) for m in curmasters)
        if can_interpolate:
            for style in styles:
                result.setdefault(style, []).append(find_master(source, style))
    return result


def postscriptname(source):
    psname = source.split('/')[-1].split('.')[0]
    if psname.endswith('-MM'):
        psname = psname[:-2] + 'Regular'
    elif psname.endswith('MM'):
        psname = psname[:-2]
    else:
        assert False, psname
    return psname


def designspace(family, source):
    psname = postscriptname(source)
    if psname == '%s-Regular' % family:
        path = os.path.join('master_ufo', '%s.designspace' % family)
    elif psname == '%s-Italic' % family:
        path = os.path.join('master_ufo', '%s.designspace' % psname)
    else:
        assert False, (source, psname)
    assert os.path.exists(path), path
    return path


def should_rebuild_master(source):
    if not os.path.exists('master_ttf_interpolatable'):
        return True
    source_mtime = os.path.getmtime(source)
    path = 'master_ttf_interpolatable/%s.ttf' % postscriptname(source)
    if os.path.exists(path):
        return os.path.getmtime(source) > os.path.getmtime(path)
    else:
        return True


def build_master(source):
    if source.endswith('.glyphs'):
        command = 'fontmake -g %s -o ttf-interpolatable' % source
    elif source.endswith('.plist'):
        command = ('fontmake -g %s -o ttf-interpolatable --mti-source %s' %
                   (source.replace('.plist', '.glyphs'), source))
    print(command)
    status = os.system(command)
    assert status == 0, 'command failed: %s' % command


def merge_masters(family, style, masters):
    if not os.path.exists('master_merged'):
        os.mkdir('master_merged')
    merged = os.path.join('master_merged', '%s-%s.ttf' % (family, style))
    if len(masters) == 1:
        shutil.copyfile(masters[0], merged)
        shutil.copystat(masters[0], merged)
        return merged
    merged_mtime = os.path.getmtime(merged) if os.path.exists(merged) else 0
    masters_mtime = max(os.path.getmtime(m) for m in masters)
    if merged_mtime > masters_mtime:
        return merged
    command = 'fonttools merge ' + ' '.join(masters)
    print(command)
    assert os.system(command) == 0, 'command failed: %s' % command
    shutil.move('merged.ttf', merged)
    return merged


def build_variable(target, family, masters):
    merged = os.path.join('master_merged', target.replace('.ttf', '-VF.ttf'))
    merged_mtime = os.path.getmtime(merged) if os.path.exists(merged) else 0
    masters_mtime = max(os.path.getmtime(m) for m in masters)
    if merged_mtime > masters_mtime:
        return merged
    ufo_designspace = os.path.join('master_ufo',
                                   target.replace('.ttf', '.designspace'))
    merged_designspace = os.path.join('master_merged',
                                      target.replace('.ttf', '.designspace'))
    shutil.copyfile(ufo_designspace, merged_designspace)
    command = 'fonttools varLib ' + merged_designspace
    print(command)
    assert os.system(command) == 0, 'command failed: %s' % command


def find_master(source, style):
    return os.path.join(
        'master_ttf_interpolatable',
        '%s-%s.ttf' % (os.path.split(source)[-1].split('-')[0], style))


if __name__ == '__main__':
    build_family('NotoSerif')
    build_family('NotoSans')
