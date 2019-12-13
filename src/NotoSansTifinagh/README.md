# Noto Sans Tifinagh

Noto Sans Tifinagh is an updated design of Tifiniagh that pair up better with Noto Sans Latin. The new source contains additonal characters to support various written traditions. Since language tag support for the different writing traditions covered is weak and many characters have alternate forms, the source file breaks up each writing tradition into separate instances allowing users to choose the correct font.

## Instances

Glyphs Source: NotoSansTifinagh-Master-Regular.glyphs contains all instances.

The [Instances](noto-source/src/NotoSansTifinagh/Instances) directory contains Glyphs source files for the following writing traditions.

  - Agraw Imazighen (Academie Berbere)
  - Adrar
  - Ahaggar
  - Aïr
  - APT (Association for the Promotion of Tifinagh)
  - Azawagh
  - Ghat
  - HawadNo 
  - Rhissa Ixa
  - SIL
  - Tawellemmet


## Build Notes

Version 2.x of Noto Sans Tifinagh is developed to be built using fontmake and a Glyphs source file.
The AFDKO `.fea` file is included as a reference, but the code is in the Glyphs file and so can be generated from Glyphs. 
The pre-existing FontDame files are no longer required.

### Test Font build commands

    Need to sort out Build instructions

    fontmake -g .glyphs
    
    fontmake -g .glyphs -o variable
    
    ttfautohint -f xxxx .ttf _autohint.ttf  
    
    ttfautohint -f xxxx .ttf _autohint.ttf  

