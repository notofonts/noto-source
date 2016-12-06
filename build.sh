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

# stop script execution if any command returns an error
set -e

source util.sh

# local folder containing the python virtual environment (default: ./venv)
VENV="${VENV:-venv}"

# Set the $PYTHON_EXE env variable to override the default "python"
# interpreter that is used to create the virtual environment
PYTHON_EXE="${PYTHON_EXE:-python}"

setup() {
    # create virtual environment if it does not exist yet
    if [ ! -d "$VENV" ]; then
        bootstrap_virtualenv $PYTHON_EXE $VENV
    fi

    # install/update fontmake and it dependencies inside the virtual env
    source ${VENV}/bin/activate
    pip install --upgrade -r Lib/fontmake/requirements.txt Lib/fontmake
    deactivate
}

build_all() {
    for target in src/*.glyphs src/*/*.plist src/*/*.ufo; do
        echo "==== building ${target} ===="
        build_one "${target}" "$1"
        echo
    done
}

build_one() {
    source ${VENV}/bin/activate
    case "$1" in
        *.plist)
            build_plist "$1" 'otf' 'ttf'
            ;;
        *.glyphs)
            build_glyphs "$1" 'otf' 'ttf'
            ;;
        *.ufo)
            build_ufo "$1"
            ;;
        *)
            echo "unrecognized file type $1"
            exit 1
            ;;
    esac
    if [[ "$?" -ne 0 && "$2" != 'force' ]]; then
        exit 1
    fi
    deactivate
}

main() {
    case "$1" in
        setup) setup ;;
        build_one) build_one "$2" ;;
        *) build_all "$1" ;;
    esac
}

main "$@"
