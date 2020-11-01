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
# note: it is assumed that at list one Noto variable font exists in $1 named like Noto*-VF.ttf
#
# Prepare a slim version of Variable fonts where slim implies weight axis Regular 400 through Bold 700 only
#
if (( $# == 0 )) then echo usage: "slimmer-vfs <variable-ttf-directory> [<script-name-or-prefix>]"; exit 1; fi
if ([ ! -d $1 ]) then echo "Directory $1 does not exist"; exit 1; fi
ls $1/Noto*$2*-VF.ttf 1>/dev/null 2>&1 || exit 1
# cd Noto variable font directory
cd $1
rm -r slim slim-drop slim-no-wdth
mkdir slim slim-drop slim-no-wdth
for i in Noto*$2*.ttf ; do echo "====== dropping wdth axis from $i"; fonttools varLib.instancer -o slim-drop/$i $i wdth=drop wght=400:700 ; done
for i in Noto*$2*.ttf ; do echo "====== restricting wght to 400:700 in $i"; fonttools varLib.instancer -o slim-no-wdth/$i $i wght=400:700 ; done
cp slim-drop/Noto*$2*-VF.ttf slim/ || echo "slim-drop/Noto*$2*-VF.ttf not found"
# copy slim-no-wdth only variable fonts that are NOT already present in slim/ 
cd slim-no-wdth; for i in `ls Noto*-VF.ttf | grep -v Regular | grep -v Medium | grep -v Elymaic | grep -v Old` ; do test -f ../slim/$i && echo yes - $i || cp $i ../slim/ ; done
cd ..
echo "copied to slim/ the following fonts"
ls -l slim/Noto*$2*-VF.ttf
rm -r slim-drop slim-no-wdth
