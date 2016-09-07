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

function main() {
    event="${TRAVIS_EVENT_TYPE}"
    if [[ ( "${event}" != 'push' && "${event}" != 'pull_request' ) ||
          "${TRAVIS_BRANCH}" != 'master' ]]; then
        exit 0
    fi

    outdir='instance_ttf'
    cached_outdir='cached_instance_ttf'
    if [[ ! -d "${cached_outdir}" ]]; then mkdir "${cached_outdir}"; fi

    git diff --name-only "${TRAVIS_COMMIT_RANGE}" | while read src; do
        if [[ "${src}" =~ src/[^/]+\.glyphs ]]; then
            fontmake -i -g "${src}" -o 'ttf'
        fi
    done

    for ttf in ${outdir}/*.ttf; do
        cached_ttf="${cached_outdir}/$(basename "${ttf}")"
        if [[ "${event}" == 'pull_request' && -e "${cached_ttf}" ]]; then
            specimen="$(python generate_fontdiff_input.py\
                        "${ttf}" 'nototools/sample_texts')"
            if [[ "${specimen}" == 'None' ]]; then continue; fi
            ./fontdiff --before "${cached_ttf}" --after "${ttf}"\
                --specimen "${specimen}" --out "${script}.pdf"
            echo "fontdiff exit status for ${ttf}: $?"
        elif [[ "${event}" == 'push' ]]; then
            mv "${ttf}" "${cached_ttf}"
        fi
    done
}

main "$@"
