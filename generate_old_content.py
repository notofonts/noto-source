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


"""Print directories and branches which are not longer being used."""

import glob
import json
import re
import subprocess
import sys
import urllib2


def main(staging_prefix, credentials):
    url = 'https://api.github.com/repos/googlei18n/noto-source/pulls?state=open'
    auth_handler = urllib2.HTTPBasicAuthHandler()
    auth_handler.add_password(None, url, *credentials.split(':'))
    opener = urllib2.build_opener(auth_handler)
    prs = json.load(opener.open(urllib2.Request(url)))

    open_prs = set()
    for pr in prs:
        ref = pr['head']['ref']
        if ref.startswith('%s-' % staging_prefix):
            open_prs.add(ref[ref.find('-') + 1:])

    cmp_dir_re = re.compile('([a-z0-9]{40})')
    for cmp_dir in glob.glob('*'):
        match = cmp_dir_re.match(cmp_dir)
        if match and match.group(1) not in open_prs:
            print('directory:%s' % cmp_dir)

    branch_re = re.compile('refs/heads/%s-([a-z0-9]{40})' % staging_prefix)
    lines = subprocess.check_output(['git', 'ls-remote', '--heads', 'origin'])
    for line in [l.strip() for l in lines.splitlines()]:
        _, branch = line.split('\t')
        match = branch_re.match(branch)
        if match and match.group(1) not in open_prs:
            print('branch:%s' % branch.replace('refs/heads/', ''))


if __name__ == '__main__':
    main(*sys.argv[1:])
