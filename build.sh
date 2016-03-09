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
            echo "You need to manually install pip."
            exit 1
        fi
    fi
    python -m pip install --user --upgrade -r requirements.txt
}

build_all() {
    for target in src/*.glyphs src/*/*.plist; do
        echo "==== building ${target} ===="
        build_one "${target}"
        echo
    done
}

build_one() {
    case "$1" in
        *.plist)
            glyphs="${1/.plist/.glyphs}"
            if [[ ! -e "${glyphs}" ]]; then
                glyphs="${glyphs/UI/}"
            fi
            python -m fontmake -i -g "${glyphs}" --mti-source "$1"
            ;;
        *)
            python -m fontmake -i -g "$1"
            ;;
    esac
    if [[ "$?" -ne 0 ]]; then
        exit 1
    fi
}

main() {
    case "$1" in
        setup) setup ;;
        build_one) build_one $2 ;;
        *) build_all ;;
    esac
}

main "$@"
