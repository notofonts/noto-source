# Noto Sans Adlam

Noto Sans Adlam is the connected version of the Adlam script. This repository contains version 3.x which is a redesign by Mark Jamra and Neil Patel (JamraPatel). The intent of version 3.x is to create a design which pairs better with Noto Latin in style. The design was reviewed by Abdoulaye and Ibrahima Barry.

## Build Notes

Version 3.x of Noto Sans Adlam is developed to be built using fontamke and a Glyphs source file. The AFDKO .fea file is included as a reference but can be generated from Glyphs. The pre-existing FontDame files are no longer required.

### Special Notes on Kerning

It seems every application used for testing treats the Adlam numerals like they are Arabic numerals, in that it expects them to run left-to-right. As a result, any kerning that is applied to the numerals gets flipped to the opposite side. Therefore, a few kerning pairs have been left out of the numerals because they would look bad in most applications.

The newer version of Glyphs (1230/1271) injects the "adlm" script tag in the kerning table, which doesn't seem to be reliably recognized by most apps. The work-around employed is to remove the adlm tag from the Languagesystems entry. This suppresses the script tag in the table and makes the kerning work for the letters.
