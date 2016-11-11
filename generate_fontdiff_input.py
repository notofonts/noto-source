# Copyright 2016 Google Inc. All Rights Reserved.
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


"""Generate fontdiff specimen HTML from UDHR text.

Finds UDHR text given a directory containing text files and a font path from
which a script is parsed.
"""


from __future__ import print_function

import glob
import os
import re
import sys

# maps script name in font family to script tags in sample text files
SCRIPT_TAGS = {
    '': ['Cyrl', 'Grek', 'Latn'],
    'Arabic': ['Arab'],
    'Armenian': ['Armn'],
    'Cherokee': ['Cher'],
    'Devanagari': ['Deva'],
    'Ethiopic': ['Ethi'],
    'Georgian': ['Geor'],
    'Hebrew': ['Hebr'],
    'Khmer': ['Khmr'],
    'Mono': ['Latn'],
    'Myanmar': ['Mymr'],
    'Sinhala': ['Sinh'],
    'Thai': ['Thai'],
    }


def main(font_path, sample_dir):
    font_path = os.path.basename(font_path)
    script = re.match(r'Noto(Sans|Serif)(\w*)-(\w+).ttf', font_path).group(2)
    tags = SCRIPT_TAGS.get(script.replace('Display', '').replace('UI', ''))
    if tags is None:
        print('None')
        return

    sample_paths = []
    for tag in tags:
        path_match = os.path.join(sample_dir, '*-%s*_udhr.txt' % tag)
        sample_paths.extend(glob.glob(path_match))

    specimen_lines = ['<html>']
    for sample_path in sample_paths:
        with open(sample_path) as sample_file:
            sample_text = sample_file.read()
        specimen_lines.append('<p>%s</p>' % sample_text)
    specimen_lines.append('</html>\n')

    specimen_text = '\n'.join(specimen_lines)
    specimen_path = script + '.html'
    with open(specimen_path, 'w') as specimen_file:
        specimen_file.write(specimen_text)
    print(specimen_path)


if __name__ == '__main__':
    main(*sys.argv[1:])
