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


# Merge failures; https://github.com/fonttools/fonttools/issues/1057
BLACKLIST = [
    'NotoSansAnatolianHieroglyphs',
    'NotoSansBamum',
    'NotoSansCarian',
    'NotoSansCuneiform',
    'NotoSansCypriot',
    'NotoSansDeseret',
    'NotoSansDevanagari',
    'NotoSansEgyptianHieroglyphs',
    'NotoSansGlagolitic',
    'NotoSansImperialAramaic',
]


def build_family(family):
    for outfile, sources in sorted(find_sources(family).items()):
        for source in sources:
            if should_rebuild_master(source):
                build_master(source)
        merge_masters(family, sources)
    #os.system('fonttools varLib master_merged/NotoSans.designspace')
    #os.rename('master_merged/NotoSans-VF.ttf', 'NotoSans.ttf')



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
        '%s.ttf' % family: [main_shard] + filter(include, sorted(shards)),
        '%s-Italic.ttf' % family: ['src/%s-ItalicMM.glyphs' % family],
    }


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
    print command
    status = os.system(command)
    assert status == 0, "command failed: %s" % command


def merge_masters(family, sources):
    if not os.path.exists('master_merged'):
        os.mkdir('master_merged')
    filename = os.path.split(sources[0])[-1]
    if filename.endswith('-MM.glyphs'):
        designspace_filename = filename[:-len('-MM.glyphs')] + '.designspace'
    else:
        assert filename.endswith('MM.glyphs'), filename
        designspace_filename = filename[:-len('MM.glyphs')] + '.designspace'
    designspace_path = os.path.join('master_ufo', designspace_filename)
    styles = [s.attrib['filename'].split('-', 1)[1].replace('.ufo', '')
              for s in etree.parse(designspace_path).findall('sources/source')]
    masters = {s: [] for s in styles}
    for source in sources:
        curmasters = [find_master(source, style) for style in styles]
        can_interpolate = all(os.path.exists(m) for m in curmasters)
        regular_master = find_master(source, 'Regular')
        for i, style in enumerate(styles):
            if can_interpolate:
                masters.setdefault(style, []).append(curmasters[i])
            else:
                masters.setdefault(style, []).append(regular_master)
    for style, masters in sorted(masters.items()):
        merged = os.path.join('master_merged', '%s-%s.ttf' % (family, style))
        if len(masters) == 1:
            shutil.copyfile(masters[0], merged)
            shutil.copystat(masters[0], merged)
            continue
        merged_mtime = os.path.getmtime(merged) if os.path.exists(merged) else 0
        masters_mtime = min(os.path.getmtime(m) for m in masters)
        if merged_mtime > masters_mtime:
            continue

        bad = []
        for i in range(15, len(masters)):
            patched = [m  for m in masters[:i+1] if m not in bad]
            command = '../fonttools/fonttools merge ' + ' '.join(patched)
            print command, i
            status = os.system(command)
            if status != 0:
                bad.append(patched[-1])
                print('*** Cannot merge:' + ' '.join(bad))
        print('*** Cannot merge:' + ' '.join(bad))
        shutil.copyfile('merged.ttf', merged)


def find_master(source, style):
    return os.path.join(
        'master_ttf_interpolatable',
        '%s-%s.ttf' % (os.path.split(source)[-1].split('-')[0], style))


def obsolete_merge_masters():
    shutil.rmtree('master_merged', ignore_errors=True)
    os.mkdir('master_merged')
    styles = [s.split('-')[1][:-4]
              for s in os.listdir('master_ttf_interpolatable')
              if s.startswith('NotoSans-') and s.endswith('.ttf')]
    for style in styles:
        merge_masters_for_style(style)
    shutil.copyfile('master_ufo/NotoSans.designspace',
                    'master_merged/NotoSans.designspace')

    
def merge_masters_for_style(style):
    fonts = []
    pathpattern = 'master_ttf_interpolatable/NotoSans%s-%s.ttf'
    for script in ('', 'Arabic', 'Devanagari', 'Adlam'):
        path = pathpattern % (script, style)
        if os.path.exists(path):
            fonts.append(pathpattern % (script, style))
        else:
            fonts.append(pathpattern % (script, 'Regular'))
    os.system('fonttools merge %s' % ' '.join(fonts))
    os.rename('merged.ttf',
              'master_merged/NotoSans-%s.ttf' % style)


if __name__ == '__main__':
    build_family('NotoSans')
    build_family('NotoSerif')
