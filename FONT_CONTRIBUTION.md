## Noto Font Submission Requirements


### Objective of This Document
This document gathers in a single place all the requirements and steps that are necessary to submit a font that *could* become part of a Noto family of fonts.


### Process
1. Prepare a proposal for a script
2. Submit it to noto-proposals-external@google.com (needed: review process)
3. The review process might: (i) approve it, (ii) reject it or (iii) require additional information.
4. Any approved scripts need to meet the requirements listed in the sections New Font Delivery Requirements and Additions to an existing Font Delivery Requirements below


### Gates
1. Noto font design proposal review
2. If applicable, Noto font weight and width design proposal review
3. (once a first version of font is produced) Noto font technical review


### New Font Delivery Requirements
To be accepted as a Noto font, the font and the sources need to meet the following properties:
1. proposed font has to address the needs of Android or web community
2. the fonts need to be visually harmonized with both Roboto and Noto Sans fonts (for Sans version of fonts) or Noto Serif fonts (for Serif version of fonts). If there’s only a single font delivered then a low stroke modulation, low contrast font is preferred so it can match better with Roboto Sans and Noto Sans fonts.
3. the license is compatible with Android
4. delivery of a source .glyphs file is required. The source will be published as open source at https://github.com/googlei18n/noto-source/tree/master/src under then current license used by the sources there (as of 2017.10.18 it is the SIL Open Font License, version 1.1). Contributions made by corporations are covered by a different agreement than the one above. Please see CONTRIBUTING for more information.
5. be of high quality
6. any and all codepoints in the font need to already exist in the [UNICODE Standard](http://www.unicode.org/versions/latest/). Then current standard needs to be fully supported.
7. we want to be able to make variable fonts: If there are multiple weights or widths then these need to be interpolatable.
8. widths, weights and naming conventions need to be compatible with the rest of the Noto Family


### Additions to an existing Font Delivery Requirements (when a script already exists)
The items below apply in addition to the items listed in the New Font Delivery Requirements when a script already exists.
1. If a Serif version of font already exists and a Sans version of the font is newly added, the glyphs in the Sans need to be visually matching to the existing glyphs in Serif (or a strong justification is required why they are not). Same is true when a Serif font is submitted and a Sans version already exists.
2. If a Sans or Serif version of a font exists and a new Serif or Sans font is produced then any existing OTF functionality in the existing font ought to re-produced for the new font.
3. The number of widths or weights supported by the new font needs to be equal or greater to the number of corresponding widths or weights and at least the existing widths and weights need to be supported.


### Document vs UI Fonts
When developing various menus, context (right-click) menus, dialog boxes and other visible text for scripts/languages where ascenders and descenders exceed the UI specs, one might need to develop special more compact version of fonts called "UI fonts" and we might need to design a UI version which modifies some "natural" glyph shapes to avoid truncation in the Android UI framework. For example, as of 2018.12.26, Noto family has these UI fonts: ArabicUI, BengaliUI, DevanagariUI, KannadaUI, KhmerUI, LaoUI, MalayalamUI, MyanmarUI, SinhalaUI, TamilUI and ThaiUI. Also NotoSans supporting Latin, Greek and Cyrillic scrips is also a UI font with its correpsonding NotoSansDisplay as a less "compact" version. However, there are many scripts where all the fully shaped glyphs required for characters of "modern usage" (as opposed to characters only used for ancient/archaic/special purposes) can meet the following Noto metric requirements without much quality sacrifice/compromise, they can be "deemed UI" and do not need a separate UI font. For example, as of 2018.12.26, Noto Sans Armenian, Cherokee, Emoji, Ethiopic, Georgian, Gujarati, Gurmukhi, Hebrew, Oriya, Telugu and Thaana are considered as "deemed UI" fonts.

If a script is unlikely to be used for a UI language (and you do not see a need to localize apps, software or web pages to use it) then you might only need a document font.

CSS3 has a generic family 'system-ui' and Noto UI fonts nicely corresponds to that generic family. A lot of web pages/web apps are NOT designed to be flexible in terms of non-Latin TALL script.


### Noto Font Metrics Requirements
units per Em: 1000

|Table|Metric|Noto UI Fonts|Noto Document Fonts|
|-----|------|-------------|-------------------|
|head|ymax|≤ 1069|≤ A|
|head|ymin|≥ -293|≥ -B|
|hhea|Ascender|= 1069|= A|
|hhea|Descender|= -293|= -B|
|hhea|LineGap|= 0|= 0|
|OS/2|usWinAscent|= 1069|= A|
|OS/2|usWinDescent|= 293|= B|
|OS/2|sTypoAscender|= 1069|= A|
|OS/2|sTypoDescender|= -293|= -B|
|OS/2|sTypoLineGap|= 0|= 0|
|Fully shaped text||should fit within (1069, -293)|should fit within (A, -B)|

Note: The (A, B) metric of document fonts need not fit within the constraints specified for the UI font (1069, -293) [Roboto Regular’s metrics translated for 1000em] or (1056, -271) [matching Open Sans Regular’s metrics]. For document fonts, while there is no fixed metric to fit within, A and B should be reasonable and not overly large in comparison to other fonts. When proposing a new document font, at least approximate values for these should be specified.


* For UI fonts if the fully shaped text does not fit within (1069, -293), this should be flagged during the development as a request for an exception.
* Fully shaped text means different things in the UI font versus the document font. In UI font it refers to the the shaped text in languages that we can expect in UIs (e.g., Sanskrit text in a UI is very unlikely, Marathi text in a UI is very likely). In a Document font, it refers to all sensible character combinations in all languages that the font supports that are likely to occur in a document.


### References
* [Typophile](https://typophile.com/node/13081)
* [Microsoft’s hhea table spec](https://www.microsoft.com/typography/otspec/hhea.htm)
* [Microsoft’s OS/2 table spec](https://docs.microsoft.com/en-us/typography/opentype/spec/os2)
* [Microsoft’s head table spec](https://docs.microsoft.com/en-us/typography/opentype/spec/head)

