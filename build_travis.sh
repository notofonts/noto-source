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
    # do nothing unless pusing to staging or master
    branch="${TRAVIS_BRANCH}"
    event="${TRAVIS_EVENT_TYPE}"
    if [[ ( "${branch}" != 'master' && "${branch}" != 'staging' ) ||
          "${event}" != 'push' ]]; then
        exit 0
    fi

    # make sure there's a directory for cached fonts
    outdir='instance_ttf'
    cached_outdir='cached_instance_ttf'
    if [[ ! -d "${cached_outdir}" ]]; then mkdir "${cached_outdir}"; fi

    # build the updated sources
    git diff --name-only "${TRAVIS_COMMIT_RANGE}" | while read src; do
        if [[ "${src}" =~ src/[^/]+\.glyphs ]]; then
            fontmake -i -g "${src}" -o 'ttf'
        fi
    done

    for ttf in ${outdir}/*.ttf; do
        # check if * didn't expand, because no TTFs were found
        if [[ "${ttf}" == "${outdir}/*.ttf" ]]; then
            break
        fi

        ttf_basename="$(basename "${ttf}")"
        cached_ttf="${cached_outdir}/${ttf_basename}"

        # compare new output with old if pushed to staging
        #TODO add more tests and comparisons
        #TODO add comprehensive text samples to noto-source and use those here
        if [[ "${branch}" == 'staging' && -e "${cached_ttf}" ]]; then
            specimen="$(python generate_fontdiff_input.py\
                        "${ttf}" 'nototools/sample_texts')"
            if [[ "${specimen}" == 'None' ]]; then continue; fi
            ./fontdiff --before "${cached_ttf}" --after "${ttf}"\
                --specimen "${specimen}" --out "${ttf_basename/ttf/pdf}"
            echo "fontdiff exit status for ${ttf}: $?"

        # cache new output if pushed to master
        elif [[ "${branch}" == 'master' ]]; then
            mv "${ttf}" "${cached_ttf}"
        fi
    done

    # create a new pull request to master, if pushed to staging
    if [[ "${branch}" == 'staging' && $(ls *.pdf) ]]; then
        git config 'user.name' 'noto-buildbot'
        git config 'user.email' 'noto-buildbot@google.com'
        git checkout artifact-branch
        #TODO could put results in a directory just for this change, to simplify
        # simultaneous reviews. would also have to to remove it afterwards.
        mv *.pdf artifacts
        git add artifacts
        git commit -m 'Review commit' --amend
        git_url='github.com/googlei18n/noto-source'
        credentials="noto-buildbot:${noto_buildbot_token}"
        git push --force "https://${credentials}@${git_url}.git" artifact-branch
        pull_request_json="{
            'title': 'Review request',
            'body': 'Review build results at
                https://${git_url}/tree/artifacts-branch/artifacts',
            'head': 'staging',
            'base': 'master'
        }"
        curl -u "${credentials}" -d "${pull_request_json}"\
            'https://api.github.com/repos/googlei18n/noto-source/pulls'
        #TODO find and post a comment on the original PR to staging
    fi
}

main "$@"
