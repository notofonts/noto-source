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
#
#
#
# Arguments (all required):
# <noto-font-name> e.g., NotoSansMarchen 
# <from-dir> is a local directory where https://github.com/googlefonts/noto-source resides
#     e.g. ~/github/googlefonts/noto-source
# <to-dir> is a local directory where https://github.com/googlefonts/noto-fonts/tree/master/phaseIII_only resides
#     e.g. ~/github/googlefonts/noto-fonts/phaseIII_only
# 
if (( $# != 3 )) then echo usage: "publish-one-noto-font.sh <noto-font-name> <from-dir> <to-dir>"; exit 1; fi
#
if ([ ! -d $2 ]) then echo "from-dir $2 doesn't exist"; exit 1; fi
if ([ ! -d $3 ]) then echo "to-dir $3 doesn't exist"; exit 1; fi
cd $2
#
if ([ ! -d instance_ttf ]) then echo "$2/instance_ttf doesn't exist"; exit 1; fi
ls instance_ttf/$1-*.*tf 1>/dev/null 2>&1 || exit 1
if ([ ! -d $3/unhinted/ttf/$1 ]) then mkdir $3/unhinted/ttf/$1 ; echo "directory $3/unhinted/ttf/$1 was created"; fi
if ([ ! -d $3/hinted/ttf/$1 ]) then mkdir $3/hinted/ttf/$1 ; echo "directory $3/hinted/ttf/$1 was created"; fi
# NotoSansTifinagh has font variants like NotoSansTifinaghTawellemmet, NotoSansTifinagh, or NotoSansTifinaghAgrawImazighen
# we need to be able to handle it
# $~FName forces zsh to do a glob expansion (otherwise it is treated like a string)
FName=$1
if [[ $1 == "NotoSansTifinagh" ]] then FName="$1"*; fi
echo $FName
ls instance_ttf/$~FName-*.*tf
cp instance_ttf/$~FName-*.*tf $3/unhinted/ttf/$1/
# initially populate unhinted fonts into the hinted directory; just in case we do not know how to hint the fonts
cp instance_ttf/$~FName-*.*tf $3/hinted/ttf/$1/
cd $3
ls -l unhinted/ttf/$1/$~FName-*.*tf
langD=`echo "$1" | sed -e "s/Adlam.*$/--adlm/" |  sed -e "s/Arabic.*$/--arab/" |  sed -e "s/Urdu.*$/--arab/" |  sed -e "s/Armenian.*$/--armn/" |  sed -e "s/Avestan.*$/--avst/" |  sed -e "s/Bamum.*$/--bamu/" |  sed -e "s/Bengali.*$/--beng/" |  sed -e "s/Buhid.*$/--buhd/" |  sed -e "s/Chakma.*$/--cakm/" |  sed -e "s/Canadian.*$/--cans/" |  sed -e "s/Carian.*$/--cari/" |  sed -e "s/Cherokee.*$/--cher/" |  sed -e "s/Coptic.*$/--copt/" |  sed -e "s/Cypriot.*$/--cprt/" |  sed -e "s/Devanagari.*$/--deva/" |  sed -e "s/Deseret.*$/--dsrt/" |  sed -e "s/Ethiopic.*$/--ethi/" |  sed -e "s/Georgian.*$/--geor/" |  sed -e "s/Glagolitic.*$/--glag/" |  sed -e "s/Gothic.*$/--goth/" |  sed -e "s/Gujarati.*$/--gujr/" |  sed -e "s/Gurmukhi.*$/--guru/" |  sed -e "s/Hebrew.*$/--hebr/" |  sed -e "s/Kayah.*$/--kali/" |  sed -e "s/Khmer.*$/--khmr/" |  sed -e "s/Kannada.*$/--knda/" |  sed -e "s/Lao.*$/--lao/" |  sed -e "s/Lisu.*$/--lisu/" |  sed -e "s/Malayalam.*$/--mlym/" |  sed -e "s/Mongolian.*$/--mong/" |  sed -e "s/Myanmar.*$/--mymr/" |  sed -e "s/NKo.*$/--nkoo/" |  sed -e "s/Chiki.*$/--olck/" |  sed -e "s/OldTurkic.*$/--orkh/" |  sed -e "s/Osage.*$/--osge/" |  sed -e "s/Osmanya.*$/--osma/" |  sed -e "s/Saurashtra.*$/--saur/" |  sed -e "s/Shavian.*$/--shaw/" |  sed -e "s/Sinhala.*$/--sinh/" |  sed -e "s/Sundanese.*$/--sund/" |  sed -e "s/Tamil.*$/--taml/" |  sed -e "s/TaiViet.*$/--tavt/" |  sed -e "s/Telugu.*$/--telu/" |  sed -e "s/Tifinagh.*$/--tfng/" |  sed -e "s/Thai.*$/--thai/" |  sed -e "s/Vai.*$/--vaii/" | sed -e "s/^.*--/-D/" | sed -e "s/Noto.*//"`
echo $langD
# for now place the result of ttfautohint in the base hinted/ttf directory; if ttfautohint doesn't know what to do
# then it will create a 0 length file; we will have delete these files before copying to the final destination
cd unhinted/ttf/$1/ ; for i in $~FName-*.ttf ; do echo "ttfautohint $langD -i -I $i $3/hinted/ttf/$i"; ttfautohint $langD -i -I $i $3/hinted/ttf/$i; done
cd $3
ls -l hinted/ttf/$~FName-*.*tf
# remove 0 length files (reults of failed ttfautohint)
for i in `ls -l hinted/ttf/$~FName-*.*tf | grep "  0 " | sed -e "s/^.*$1/$1/"` ; do rm hinted/ttf/$i; done
# move whatever files remain (assumed good at this point) to their final destination directory
mv hinted/ttf/$~FName-*.*tf hinted/ttf/$1/
ls -l hinted/ttf/$1/$~FName-*.*tf
# add dsig to the hinted files
for i in hinted/ttf/$1/$~FName-*.*tf ; do gftools fix-dsig --autofix $i; done
cd $2
#
if ([ ! -d instance_otf ]) then echo "$2/instance_otf doesn't exist"; exit 1; fi
ls instance_otf/$~FName-*.*tf 1>/dev/null 2>&1 || exit 1
if ([ ! -d $3/unhinted/otf/$1 ]) then mkdir $3/unhinted/otf/$1 ; echo "directory $3/unhinted/otf/$1 was created"; fi
cp instance_otf/$~FName-*.*tf $3/unhinted/otf/$1/
cd $3
git add unhinted/ttf/$1/$~FName-*.*tf
git add unhinted/otf/$1/$~FName-*.*tf
git add hinted/ttf/$1/$~FName-*.*tf
git commit -m "Published $1 hinted and unhinted static instances"
git push
cd $2
#
if ([ ! -d variable_ttf ]) then echo "$2/variable_ttf doesn't exist"; exit 1; fi
ls variable_ttf/$~FName-*.*tf 1>/dev/null 2>&1 || exit 1
if ([ ! -d $3/unhinted/variable-ttf/ ]) then echo "$3/unhinted/variable-ttf/ doesn't exist"; exit 1; fi
cp variable_ttf/$~FName-*.*tf $3/unhinted/variable-ttf/
#
if ([ ! -d variable_ttf/slim ]) then echo "$2/variable_ttf/slim doesn't exist"; exit 1; fi
ls variable_ttf/slim/$~FName-*.*tf 1>/dev/null 2>&1 || exit 1
if ([ ! -d $3/unhinted/slim-variable-ttf/ ]) then echo "$3/unhinted/slim-variable-ttf/ doesn't exist"; exit 1; fi
cp variable_ttf/slim/$~FName-*.*tf $3/unhinted/slim-variable-ttf/
#
cd $3
git add unhinted/variable-ttf/$~FName-*.*tf
git add unhinted/slim-variable-ttf/$~FName-*.*tf
git commit -m "Published $1 unhinted variable and slim-variable fonts"
git push
