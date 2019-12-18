# Noto Sans Tifinagh

Noto Sans Tifinagh is an updated design of Tifinagh that pairs better with Noto Sans Latin. The new source contains additional characters to support various written traditions. Since language tag support for the different writing traditions covered is weak and many characters have alternate forms, the source file breaks up each writing tradition into separate instances allowing users to choose the correct font.

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
  - Hawad 
  - IRCAM (This is the default: Noto Sans Tifinagh Regular)
  - Rhissa Ixa
  - SIL
  - Tawellemmet


## Build Notes

Version 2.x of Noto Sans Tifinagh is developed to be built using fontmake and a Glyphs source file.
The AFDKO `.fea` files are included as a reference, but the code is in the Glyphs source files and can be generated from using Glyphs. 

The pre-existing FontDame files are no longer required.

NotoSansTifinagh-Master-Regular.glyphs is the source file that is setup to make glyph management easier for all of the instances. This source employs a number of Glyphs custom parameters that are not compatible with fontmake. Running Generate Instances from within Glyphs produces Instance masters that parse out the correct glyphs for each instance. The instances have then been subsequently edited to fold the contents of the custom paramters into the main feature code. Fonts should be generated directly from the Instance source files.

### Test Font build commands


    fontmake -g NotoSansTifinagh[INSTANCE NAME].glyphs --no-production-names
    
    
# Changelog
Version 2.002
- Updated Parameters to include missing tables (description, trademark, openTypeNameLicense, openTypeNameLicenseURL)
- Change Aïr to Air to fix fontmake issue with diacritic in name
- Generate Instance source files from Master
- Instance Masters scrubbed to remove Custom Parameters (Replace Feature, Remove Prefixes) that are incompatible with fontmake
- Instance Masters have features updated to reflect what was in Custom Parameters

Version 2.001
- New Design of Noto Sans Tifinagh that better matches style of Noto Sans Latin. Includes support for 12 different writing traditions.

