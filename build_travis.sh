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
    branch="${TRAVIS_BRANCH}"
    event="${TRAVIS_EVENT_TYPE}"
    if [[ ( "${branch}" != 'master' && "${branch}" != 'staging' ) ||
          "${event}" != 'push' ]]; then
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
        if [[ "${ttf}" == "${outdir}/*.ttf" ]]; then
            break  # didn't expand *, because no TTFs were found
        fi

        ttf_basename="$(basename "${ttf}")"
        cached_ttf="${cached_outdir}/${ttf_basename}"

        if [[ "${branch}" == 'staging' && -e "${cached_ttf}" ]]; then
            specimen="$(python generate_fontdiff_input.py\
                        "${ttf}" 'nototools/sample_texts')"
            if [[ "${specimen}" == 'None' ]]; then continue; fi
            ./fontdiff --before "${cached_ttf}" --after "${ttf}"\
                --specimen "${specimen}" --out "${ttf_basename/ttf/pdf}"
            echo "fontdiff exit status for ${ttf}: $?"

        elif [[ "${branch}" == 'master' ]]; then
            mv "${ttf}" "${cached_ttf}"
        fi
    done

    if [[ "${branch}" == 'staging' && $(ls *.pdf) ]]; then
        git checkout artifact-branch
        #TODO could put results in a directory just for this change, to simplify
        # simultaneous reviews. would also have to to remove it afterwards.
        mv *.pdf artifacts
        git add artifacts
        git commit -m 'Review commit' --amend
        git push --force origin artifact-branch
        json='{
            "title": "Review request",
            "body": "Review build results at
                https://github.com/googlei18n/noto-source/tree/artifacts-branch/artifacts",
            "head": "staging",
            "base": "master"
        }'
        curl -u "noto-buildbot:${noto_buildbot_token}" -d "${json}"\
            'https://api.github.com/repos/googlei18n/noto-source/pulls'
        #TODO find and post a comment on the original PR to staging
    fi
}

main "$@"
