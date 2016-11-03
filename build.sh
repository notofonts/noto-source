# Copyright 2015 Google Inc. All rights reserved.
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

setup() {
    if [[ ! $(python -m pip) ]]; then
        if [[ ! $(sudo python -m ensurepip) ]]; then
            echo 'You need to manually install pip.'
            exit 1
        fi
    fi
    python -m pip install --user --upgrade -r Lib/fontmake/requirements.txt
    cd Lib/fontmake
    python setup.py install --user
}

build_all() {
    for target in src/*.glyphs src/*/*.plist src/*/*.ufo; do
        echo "==== building ${target} ===="
        build_one "${target}" "$1"
        echo
    done
}

build_one() {
    case "$1" in
        *.plist)
            g="${1/.plist/.glyphs}"
            case "$1" in
                */NotoSansDevanagariUI-MM.plist)
                    g="${g/UI/}"
                    f='Noto Sans Devanagari UI'
                    ;;
                *)
                    f=''
                    ;;
            esac
            if [[ -n "$f" ]]; then
                fontmake -g "$g" --mti-source "$1" --family-name "$f"\
                    --no-production-names
                fontmake -i -g "$g" --interpolate-binary-layout\
                    --family-name "$f" --no-production-names
            else
                fontmake -g "$g" --mti-source "$1" --no-production-names
                fontmake -i -g "$g" --interpolate-binary-layout\
                    --no-production-names
            fi
            ;;
        *.glyphs)
            fontmake -i -g "$1"
            ;;
        *.ufo)
            fontmake --keep-overlaps -u "$1" -o ttf
            ;;
        *)
            echo "unrecognized file type $1"
            exit 1
            ;;
    esac
    if [[ "$?" -ne 0 && "$2" != 'force' ]]; then
        exit 1
    fi
}

main() {
    case "$1" in
        setup) setup ;;
        build_one) build_one "$2" ;;
        *) build_all "$1" ;;
    esac
}

main "$@"
