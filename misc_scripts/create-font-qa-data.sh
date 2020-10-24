#! /bin/zsh
# Copyright 2020 Google Inc. All Rights Reserved.
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
#
# Arguments (all required):
# <noto-font-name> e.g., NotoSansMarchen 
# <directory-of-fontdiff-tests> where the fondiff compatible tests for <noto-font-name> are
#     e.g. ~/github/googlefonts/noto-source/tests/Arabic
# <to-dir> is a local directory where https://github.com/googlefonts/noto-fonts/ resides
#     e.g. ~/github/googlefonts/noto-fonts
# <from-dir> is a local directory where https://github.com/googlefonts/noto-source resides
#     e.g. ~/github/googlefonts/noto-source

TS=`date "+%Y%m%d-%H%M"`; echo $TS
if (( $# != 4 )) then echo usage: "create-font-qa-data <noto-font-name> <directory-of-fontdiff-tests> <to-dir> <from-dir>"; exit 1; fi
if ([ ! -d $2 ]) then echo "Test directory $2 does not exist"; exit 1; fi
if ([ ! -d $3 ]) then echo "Published font directory $3 does not exist"; exit 1; fi
if ([ ! -d $4 ]) then echo "noto-source directory $4 does not exist"; exit 1; fi	
ls $2/fontdiff-*.html 1>/dev/null 2>&1 || exit 1
if ([ ! -d $3/unhinted/ttf/$1 ]) then echo "Directory $3/unhinted/ttf/$1 does not exist"; exit 1; fi
if ([ ! -d $3/unhinted/otf/$1 ]) then echo "Directory $3/unhinted/otf/$1 does not exist"; exit 1; fi
if ([ ! -d $3/hinted/ttf/$1 ]) then echo "Directory $3/hinted/ttf/$1 does not exist"; exit 1; fi
ls $4/instance_ttf/$1-*.ttf 1>/dev/null 2>&1 || exit 1
ls $4/instance_otf/$1-*.otf 1>/dev/null 2>&1 || exit 1
ls $3/unhinted/ttf/$1/$1-*.ttf 1>/dev/null 2>&1 || exit 1
ls $3/unhinted/otf/$1/$1-*.otf 1>/dev/null 2>&1 || exit 1
ls $3/hinted/ttf/$1/$1-*.ttf 1>/dev/null 2>&1 || exit 1
ls `which diffenator` 1>/dev/null 2>&1 || exit 1
ls `which fontdiff` 1>/dev/null 2>&1 || exit 1
ls `which fontbakery` 1>/dev/null 2>&1 || exit 1
echo "diffenator, fontdiff, fontbakery were found"
# cd new-noto-source-dir directory
cd $4
if ([ ! -d ../Font-QA-Data ]) then mkdir ../Font-QA-Data; fi
mkdir ../Font-QA-Data/$1-$TS
cd $4/instance_ttf
# mkdir $4/../Font-QA-Data/$1-$TS/fontdiff
# for j in `ls $1-*.ttf | sed -e "s/.ttf//"`; do for i in $2/fontdiff-*.html; do echo fontdiff $j $i; test=`echo $(basename $i) | sed -e "s/.html//"`; echo $test; fontdiff --before $3/unhinted/ttf/$1/$j.ttf --after $j.ttf --specimen $i --out $4/../Font-QA-Data/$1-$TS/fontdiff/$j-$i.pdf ; done; done 
mkdir $4/../Font-QA-Data/$1-$TS/diffenator
for j in `ls $1-*.ttf | sed -e "s/.ttf//"`; do echo "====== " diffenator $j; diffenator $3/unhinted/ttf/$1/$j.ttf $j.ttf -r $4/../Font-QA-Data/$1-$TS/diffenator/$j-img  -html > $4/../Font-QA-Data/$1-$TS/diffenator/$j-out.html ; done
mkdir $4/../Font-QA-Data/$1-$TS/fontbakery
for j in `ls $1-*.ttf | sed -e "s/.ttf//"`; do echo "====== " fontbakery check-notofonts $j; fontbakery check-notofonts $j.ttf > $4/../Font-QA-Data/$1-$TS/fontbakery/$j-out.txt ; done
cd $4/variable_ttf
echo "====== " diffenator $1-VF.ttf ; diffenator $3/unhinted/variable-ttf/$1-VF.ttf $1-VF.ttf -r $4/../Font-QA-Data/$1-$TS/diffenator/$1-VF-img  -html > $4/../Font-QA-Data/$1-$TS/diffenator/$1-VF-out.html 
echo "====== " fontbakery $1-VF.ttf ; fontbakery check-notofonts $1-VF.ttf > $4/../Font-QA-Data/$1-$TS/fontbakery/$1-VF-out.txt 
