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
# Build font instances from Glyphs source.
# Arguments:
#     Path to Glyphs source.
#     Output formats, as separate strings.
################################################################################
function build_glyphs() {
    fontmake -g "$1" -o "${@:2}" -i
}

################################################################################
# Build font instances from plist source, which designates separate MTI feature
# files to use with a corresponding Glyphs source.
# Arguments:
#     Path to plist source.
#     Output formats, as separate strings.
################################################################################
function build_plist() {
    glyphs="$(glyphs_from_plist "$1")"
    family="$(family_from_plist "$1")"
    if [[ -n "$family" ]]; then
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
# Build variable font from Glyphs source.
# Arguments:
#     Path to Glyphs source.
################################################################################
function build_glyphs_variable() {
    fontmake -g "$1" -o variable
}

################################################################################
# Build variable font from plist source.
# Arguments:
#     Path to plist source.
################################################################################
function build_plist_variable() {
    glyphs="$(glyphs_from_plist "$1")"
    family="$(family_from_plist "$1")"
    if [[ -n "${family}" ]]; then
        fontmake -g "${glyphs}" -o variable --mti-source "$1"\
            --family-name "${family}"
    else
        fontmake -g "${glyphs}" -o variable --mti-source "$1"
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

function glyphs_from_plist() {
    glyphs="${1/%.plist/.glyphs}"
    case "$1" in
        */NotoSansDevanagariUI-MM.plist)
            echo "${glyphs/UI/}"
            ;;
        *)
            echo "${glyphs}"
            ;;
    esac
}

function family_from_plist() {
    case "$1" in
        */NotoSansDevanagari-MM.plist)
            echo 'Noto Sans Devanagari'
            ;;
        */NotoSansDevanagariUI-MM.plist)
            echo 'Noto Sans Devanagari UI'
            ;;
        *)
            echo ''
            ;;
    esac
}
