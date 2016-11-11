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


"""Generate HTML for reviewing changes to source."""

import os
import sys

HEAD_HTML = '''\
<!DOCTYPE html>
<style>
body {
    font-family: sans-serif;
}
.after {
    color: #00ff00;
}
.before {
    color: #ff0000;
}
.break {
    clear: both;
}
.rendering {
    border: 1px solid black;
    max-height: 12em;
}
.rendering-wrapper {
    float: left;
    height: 14em;
    margin-right: 1em;
}
.report {
    border: 1px solid black;
    max-height: 32em;
    overflow: auto;
}
</style>'''

TITLE_HTML = '<h1>noto-source changes %s</h1>'
HEADING_HTML = '<h2>%s</h2>'
SUBHEADING_HTML = '<h3>%s</h3>'
SPAN_HTML = '<span class="%s">%s</span>'
BREAK_HTML = '<div class="break"></div>'

REPORT_HTML = '<pre class="report">%s</pre>'
RENDERING_HTML = '''\
<div class="rendering-wrapper">
<div class="label">%s</div>
<a href="%s"><img src="%s" class="rendering"/></a>
</div>'''
PDF_HTML = '<div><a href="%s">%s</a></div>'


def span(text, classes):
    return SPAN_HTML % (' '.join(classes), text)


def main(commit_range, cmp_dir):
    root_dir, rel_dir = os.path.split(cmp_dir)

    rendering_dirs = []
    pdf_paths = []
    for path in sorted(os.listdir(cmp_dir)):
        rel_path = os.path.join(rel_dir, path)
        if os.path.isdir(os.path.join(cmp_dir, path)):
            rendering_dirs.append(rel_path)
        elif path.endswith('.pdf'):
            pdf_paths.append(rel_path)

    before, after = commit_range.split('...')
    title_html = TITLE_HTML % commit_range

    report_path = os.path.join(cmp_dir, 'report.txt')
    with open(report_path) as report_file:
        report_text = report_file.read()
    report_html = REPORT_HTML % report_text

    rendering_html = []
    if rendering_dirs:
        heading_text = 'Top glyph differences between %s and %s:' % (
            span(before, ['before']), span(after, ['after']))
        rendering_html.append(HEADING_HTML % heading_text)
    for rendering_dir in rendering_dirs:
        rendering_html.append(SUBHEADING_HTML % os.path.basename(rendering_dir))
        for img_path in sorted(os.listdir(os.path.join(root_dir, rendering_dir))):
            name, ext = os.path.splitext(img_path)
            img_path = os.path.join(rendering_dir, img_path)
            if ext != '.png':
                continue
            rendering_html.append(
                RENDERING_HTML % (name, img_path, img_path))
        rendering_html.append(BREAK_HTML)
    rendering_html = '\n'.join(rendering_html)

    pdf_html = []
    if pdf_paths:
        heading_text = 'Sample text differences between %s and %s:' % (
            span(before, ['before']), span(after, ['after']))
        pdf_html.append(HEADING_HTML % heading_text)
    for pdf_path in pdf_paths:
        pdf_html.append(PDF_HTML % (pdf_path, os.path.basename(pdf_path)))
    pdf_html = '\n'.join(pdf_html)

    html = [HEAD_HTML, title_html, report_html, rendering_html, pdf_html]
    html_path = os.path.join(root_dir, 'index.html')
    with open(html_path, 'w') as html_file:
        html_file.write('\n'.join(html))


if __name__ == '__main__':
    main(*sys.argv[1:])
