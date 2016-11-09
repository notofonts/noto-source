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
    # do nothing unless pushing to staging or master
    branch="${TRAVIS_BRANCH}"
    event="${TRAVIS_EVENT_TYPE}"
    if [[ ( "${branch}" != 'master' && "${branch}" != 'staging' ) ||
          "${event}" != 'push' ]]; then
        exit 0
    fi

    outdir='instance_ttf'
    cached_outdir='output'
    cmp_dir='comparisons'
    cache_branch='cache'

    # build the updated sources
    echo "building sources changed from ${TRAVIS_COMMIT_RANGE}"
    git diff --name-only "${TRAVIS_COMMIT_RANGE}" | while read src; do
        if [[ "${src}" =~ src/[^/]+\.glyphs ]]; then
            fontmake -i -g "${src}" -o 'ttf'
        fi
    done
    if [[ -e "${outdir}" ]]; then
        echo 'new output:'
        ls "${outdir}"
    else
        echo 'no sources changed'
        exit 0
    fi

    # switch to cache branch and make sure there's a directory for cached fonts
    git remote set-branches --add origin "${cache_branch}"
    git fetch
    git checkout "${cache_branch}"
    if [[ ! -d "${cached_outdir}" ]]; then
        mkdir "${cached_outdir}"
    fi

    # configure git for bot account
    git config 'user.name' 'noto-buildbot'
    git config 'user.email' 'noto-buildbot@google.com'
    git_url='github.com/googlei18n/noto-source'
    credentials="noto-buildbot:${noto_buildbot_token}"

    # just cache new output if pushed to master
    if [[ "${branch}" == 'master' ]]; then
        for ttf in ${outdir}/*.ttf; do
            mv "${ttf}" "${cached_outdir}"
        done
        git add "${cached_outdir}"
        git commit -m 'Update cached output' --amend
        git push --force "https://${credentials}@${git_url}.git"\
            "${cache_branch}" >/dev/null 2>&1
        exit 0
    fi

    # otherwise, compare new output with old
    for ttf in ${outdir}/*.ttf; do
        # check if * didn't expand, because no TTFs were built
        if [[ "${ttf}" == "${outdir}/*.ttf" ]]; then
            echo 'No fonts built for these changes'
            exit 0
        fi

        ttf_basename="$(basename "${ttf}")"
        cached_ttf="${cached_outdir}/${ttf_basename}"
        if [[ ! -e "${cached_ttf}" ]]; then
            echo "Cached font not found for ${ttf}"
            continue
        fi

        #TODO add more tests and comparisons
        #TODO add comprehensive text samples to noto-source and use those here
        echo "checking ${ttf} against ${cached_ttf}"
        specimen="$(python generate_fontdiff_input.py\
                    "${ttf}" 'nototools/sample_texts')"
        if [[ "${specimen}" == 'None' ]]; then
            continue
        fi
        ./fontdiff --before "${cached_ttf}" --after "${ttf}"\
            --specimen "${specimen}" --out "${ttf_basename/ttf/pdf}"
        echo "fontdiff exit status for ${ttf}: $?"
    done

    # check that some comparisons were made
    if [[ ! $(ls *.pdf) ]]; then
        echo 'No comparisons made for these changes'
        exit 1
    fi

    # upload comparison results
    #TODO could put results in a directory just for this change, to simplify
    # simultaneous reviews. would also have to to remove it afterwards.
    mv *.pdf "${cmp_dir}"
    git add "${cmp_dir}"
    git commit -m 'Review commit' --amend
    git push --force "https://${credentials}@${git_url}.git"\
        "${cache_branch}" >/dev/null 2>&1

    # create a new pull request to master
    pull_request_json='{
        "title": "Review request",
        "body": "Review build results at
            https://'"${git_url}"'/tree/'"${cache_branch}"'/'"${cmp_dir}"'",
        "head": "staging",
        "base": "master"
    }'
    curl -u "${credentials}" -d "${pull_request_json//$'\n'/}"\
        'https://api.github.com/repos/googlei18n/noto-source/pulls'
    #TODO find and post a comment on the original PR to staging
}

main "$@"
