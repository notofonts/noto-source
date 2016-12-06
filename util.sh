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

################################################################################
# Temporarily download virtualenv package from PyPI and run with arguments.
# Arguments:
#     The Python interpreter to use to create the new virtual environment.
#     The destination folder for the new virtual environment.
#     Extra arguments to pass on to virtualenv script.
################################################################################
function bootstrap_virtualenv() {
    if [ $# -lt 2 ]; then
        echo "usage: bootstrap_virtualenv PYTHON_EXE DEST_DIR [OPTIONS]"
        exit 2
    fi

    venv_version="15.1.0"
    venv_package_dir="virtualenv-${venv_version}"
    venv_tarball="${venv_package_dir}.tar.gz"

    python_exe="$1"
    dest_dir="$2"
    shift 2
    options="$@"

    # print commands as they are executed
    set -x
    # download the virtualenv package from PyPI
    curl -LO "https://pypi.org/packages/source/v/virtualenv/${venv_tarball}"
    tar xzf $venv_tarball
    # create a new virtual environment
    "$python_exe" ${venv_package_dir}/virtualenv.py $options "$dest_dir"
    # clean up temporary files
    rm -rf $venv_package_dir $venv_tarball
    # turn off commands echoing
    { set +x; } 2> /dev/null
}

################################################################################
# Build from Glyphs source.
# Arguments:
#     Path to Glyphs source.
#     Output formats, as separate strings.
################################################################################
function build_glyphs() {
    fontmake -g "$1" -o "${@:2}" -i
}

################################################################################
# Build from plist source, which designates separate MTI feature files to use
# with a corresponding Glyphs source.
# Arguments:
#     Path to plist source.
#     Output formats, as separate strings.
################################################################################
function build_plist() {
    glyphs="${1/%.plist/.glyphs}"
    case "$1" in
        */NotoSansDevanagariUI-MM.plist)
            glyphs="${glyphs/UI/}"
            family='Noto Sans Devanagari UI'
            ;;
        *)
            family=''
            ;;
    esac
    if [[ -n "$f" ]]; then
        fontmake -g "$glyphs" -o "${@:2}" --mti-source "$1"\
            --no-production-names --family-name "$family"
        fontmake -g "$glyphs" -o "${@:2}" -i --interpolate-binary-layout\
            --no-production-names --family-name "$family"
    else
        fontmake -g "$glyphs" -o "${@:2}" --mti-source "$1"\
            --no-production-names
        fontmake -g "$glyphs" -o "${@:2}" -i --interpolate-binary-layout\
            --no-production-names
    fi
}

################################################################################
# Build from UFO source, assuming that the source contains quadratic curves (for
# which BooleanOperations is unable to remove overlaps, and only TTFs can be
# generated).
# Arguments:
#     Path to UFO source.
################################################################################
function build_ufo() {
    fontmake -u "$1" -o 'ttf' --keep-overlaps
}
