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


def build_masters():
    os.system('fontmake -g src/NotoSans-MM.glyphs -o ttf-interpolatable')
    os.system('fontmake -g src/NotoSansArabic-MM.glyphs -o ttf-interpolatable')
    os.system('fontmake -g src/NotoSansDevanagari/NotoSansDevanagari-MM.glyphs'
              ' -o ttf-interpolatable'
              ' --mti-source src/NotoSansDevanagari/NotoSansDevanagari-MM.plist')
    os.system('fontmake -g src/NotoSansAdlam/NotoSansAdlam-MM.glyphs'
              ' -o ttf-interpolatable'
              ' --mti-source src/NotoSansAdlam/NotoSansAdlam-MM.plist')


def merge_masters():
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


def build_noto():
    build_masters()
    merge_masters()
    os.system('fonttools varLib master_merged/NotoSans.designspace')
    os.rename('master_merged/NotoSans-VF.ttf', 'NotoSans.ttf')

    
if __name__ == '__main__':
    build_noto()

