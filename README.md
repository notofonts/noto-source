![Noto](images/noto.png)

# Noto Source

Source files for generating Noto fonts.

The files in this repository might be work-in-progress for future versions of the fonts that have not been released yet. 
The designs and glyph sets might not final.

## Building

[Python 3.6 or greater](https://www.python.org/downloads/) is required to build the fonts.
To obtain all sources and build tools:

```
$ git clone --recursive https://github.com/googlefonts/noto-source.git
$ cd noto-source
$ ./build setup
```

To build everything from source:

```
$ ./build all
```

other build options exist:

```bash
$ ./build src/NotoSansOlChiki.glyphs  # build from a single source
$               # if a font has both .glyphs and .plist files
$ ./build src/NotoSansBrahmi/NotoSansBrahmi.plist  # build from a single source
$ ./build src/NotoSansYi/NotoSansYi.designspace  # build from a single source
$ ./build variable src/NotoSans-MM.glyphs  # build a single variable font
$ ./build variable src/NotoSansYi/NotoSansYi.designspace  # build a single variable font
$               # if a font has both .glyphs and .plist files
$ ./build variable src/NotoSansBrahmi/NotoSansBrahmi.plist  # build a single variable font
$ ./build all variable  # build all variable fonts
$ ./build all force
$ ./build all variable force  # continue building even when some sources fail
```

be sure to update this repository and its dependencies on subsequent runs:

```
$ git pull
$ git submodule update --recursive
$ ./build setup
$ ...
```

If you want to edit UFO+designspace source in glyphs then convert it to glyphs format.
For example,
```
$ ufo2glyphs NotoSansMarchen/NotoSansMarchen.designspace
```
will create NotoSansMarchen/NotoSansMarchen.glyphs file.

## License

Noto source (under the src subdirectory) is under the [SIL Open Font License, version 1.1](src/LICENSE).

Build scripts are under the [Apache license, version 2.0](LICENSE).

## Contributing

To contribute to this project, please read [CONTRIBUTING](CONTRIBUTING.md) and [FONT_CONTRIBUTION](FONT_CONTRIBUTION.md)

## News

* 2020-04-02: converted 63 font sources to UFO+designspace from .glyphs files.
* 2020-02-22: first UFO+designspace source for NotoSansHanifiRohingya
* 2015-12-07: first release, covering Noto Sans UI {Italic, Mono, Roman}, Noto Sans Display {Italic, Roman}, Noto {Sans, Serif} {Armenian, Georgian}.


## Source List as of 2020-04-05

There are three types of sources:

* *.glyphs: a single source file created using Glyphs.app 
* *.designspace: multiple files (.ufo + .designspace) comprising a source for the font
* *.plist: multiple files (.glyphs + .plist + .txt) comprising a source for the font. This one is using [Monotype's Fontdame format](http://monotype.github.io/OpenType_Table_Source/otl_source.html).
* The sources as of 2020-04-05 are:
	* src/Arimo-Bold/Arimo-Bold.plist
	* src/Arimo-BoldItalic/Arimo-BoldItalic.plist
	* src/Arimo-Italic/Arimo-Italic.plist
	* src/Arimo-Regular/Arimo-Regular.plist
	* src/Cousine-Bold/Cousine-Bold.plist
	* src/Cousine-BoldItalic/Cousine-BoldItalic.plist
	* src/Cousine-Italic/Cousine-Italic.plist
	* src/Cousine-Regular/Cousine-Regular.plist
	* src/NotoKufiArabic.glyphs
	* src/NotoMusic/NotoMusic.plist
	* src/NotoNaskhArabic.glyphs
	* src/NotoNaskhArabicUI.glyphs
	* src/NotoNastaliqUrdu/NotoNastaliqUrdu.plist
	* src/NotoRashiHebrew.glyphs
	* src/NotoSans-ItalicMM.glyphs
	* src/NotoSans-MM.glyphs
	* src/NotoSansAdlam.glyphs
	* src/NotoSansAdlamUnjoined.glyphs
	* src/NotoSansAnatolianHieroglyphs/NotoSansAnatolianHieroglyphs.designspace
	* src/NotoSansArabic-MM.glyphs
	* src/NotoSansArabicUI-MM.glyphs
	* src/NotoSansArmenian/NotoSansArmenian.designspace
	* src/NotoSansAvestan/NotoSansAvestan.designspace
	* src/NotoSansBamum/NotoSansBamum.designspace
	* src/NotoSansBassaVah/NotoSansBassaVah.designspace
	* src/NotoSansBatak/NotoSansBatak.plist
	* src/NotoSansBengali/NotoSansBengali-MM.plist
	* src/NotoSansBengali/NotoSansBengaliUI-MM.plist
	* src/NotoSansBhaiksuki.glyphs
	* src/NotoSansBrahmi/NotoSansBrahmi.plist
	* src/NotoSansBuginese/NotoSansBuginese.designspace
	* src/NotoSansBuhid/NotoSansBuhid.designspace
	* src/NotoSansCanadianAboriginal/NotoSansCanadianAboriginal.designspace
	* src/NotoSansCarian/NotoSansCarian.designspace
	* src/NotoSansCaucasianAlbanian/NotoSansCaucasianAlbanian.plist
	* src/NotoSansChakma/NotoSansChakma.plist
	* src/NotoSansCham/NotoSansCham-MM.plist
	* src/NotoSansCherokee/NotoSansCherokee.designspace
	* src/NotoSansCoptic/NotoSansCoptic.plist
	* src/NotoSansCuneiform/NotoSansCuneiform.designspace
	* src/NotoSansCypriot/NotoSansCypriot.designspace
	* src/NotoSansDeseret/NotoSansDeseret.designspace
	* src/NotoSansDevanagari/NotoSansDevanagari-MM.plist
	* src/NotoSansDevanagari/NotoSansDevanagariUI-MM.plist
	* src/NotoSansDisplay-ItalicMM.glyphs
	* src/NotoSansDisplay-MM.glyphs
	* src/NotoSansDuployan.glyphs
	* src/NotoSansEgyptianHieroglyphs/NotoSansEgyptianHieroglyphs.designspace
	* src/NotoSansElbasan/NotoSansElbasan.plist
	* src/NotoSansElymaic/NotoSansElymaic.designspace
	* src/NotoSansEthiopic/NotoSansEthiopic.designspace
	* src/NotoSansGeorgian/NotoSansGeorgian.designspace
	* src/NotoSansGlagolitic/NotoSansGlagolitic.plist
	* src/NotoSansGothic/NotoSansGothic.designspace
	* src/NotoSansGrantha/NotoSansGrantha.plist
	* src/NotoSansGujarati/NotoSansGujarati-MM.plist
	* src/NotoSansGunjalaGondi.glyphs
	* src/NotoSansGurmukhi/NotoSansGurmukhi-MM.plist
	* src/NotoSansGurmukhi/NotoSansGurmukhiUI-MM.plist
	* src/NotoSansHanifiRohingya/NotoSansHanifiRohingya.designspace
	* src/NotoSansHanunoo/NotoSansHanunoo.plist
	* src/NotoSansHatran/NotoSansHatran.designspace
	* src/NotoSansHebrew/NotoSansHebrew.designspace
	* src/NotoSansImperialAramaic/NotoSansImperialAramaic.designspace
	* src/NotoSansIndicSiyaqNumbers/NotoSansIndicSiyaqNumbers.plist
	* src/NotoSansInscriptionalPahlavi/NotoSansInscriptionalPahlavi.plist
	* src/NotoSansInscriptionalParthian/NotoSansInscriptionalParthian.plist
	* src/NotoSansJavanese/NotoSansJavanese-MM.plist
	* src/NotoSansKaithi/NotoSansKaithi.plist
	* src/NotoSansKannada/NotoSansKannada-MM.plist
	* src/NotoSansKannada/NotoSansKannadaUI-MM.plist
	* src/NotoSansKayahLi/NotoSansKayahLi.designspace
	* src/NotoSansKharoshthi/NotoSansKharoshthi.plist
	* src/NotoSansKhmer/NotoSansKhmer-MM.plist
	* src/NotoSansKhmerUI/NotoSansKhmerUI-MM.plist
	* src/NotoSansKhojki/NotoSansKhojki.plist
	* src/NotoSansKhudawadi/NotoSansKhudawadi.plist
	* src/NotoSansLao-MM.glyphs
	* src/NotoSansLaoUI-MM.glyphs
	* src/NotoSansLepcha/NotoSansLepcha.plist
	* src/NotoSansLimbu/NotoSansLimbu.plist
	* src/NotoSansLinearA/NotoSansLinearA.designspace
	* src/NotoSansLinearB/NotoSansLinearB.designspace
	* src/NotoSansLisu/NotoSansLisu.designspace
	* src/NotoSansLycian/NotoSansLycian.designspace
	* src/NotoSansLydian/NotoSansLydian.designspace
	* src/NotoSansMahajani/NotoSansMahajani.plist
	* src/NotoSansMalayalam/NotoSansMalayalam-MM.plist
	* src/NotoSansMalayalam/NotoSansMalayalamUI-MM.plist
	* src/NotoSansMandaic/NotoSansMandaic.designspace
	* src/NotoSansManichaean/NotoSansManichaean.plist
	* src/NotoSansMarchen/NotoSansMarchen.designspace
	* src/NotoSansMasaramGondi.glyphs
	* src/NotoSansMath/NotoSansMath.designspace
	* src/NotoSansMayanNumerals/NotoSansMayanNumerals.designspace
	* src/NotoSansMeeteiMayek-MM.glyphs
	* src/NotoSansMendeKikakui/NotoSansMendeKikakui.plist
	* src/NotoSansMeroitic/NotoSansMeroitic.plist
	* src/NotoSansMiao/NotoSansMiao.plist
	* src/NotoSansModi/NotoSansModi.plist
	* src/NotoSansMongolian/NotoSansMongolian.plist
	* src/NotoSansMono-MM.glyphs
	* src/NotoSansMro/NotoSansMro.designspace
	* src/NotoSansMultani/NotoSansMultani.designspace
	* src/NotoSansMyanmar/NotoSansMyanmar-MM.plist
	* src/NotoSansMyanmarUI/NotoSansMyanmarUI-MM.plist
	* src/NotoSansNKo/NotoSansNKo.plist
	* src/NotoSansNabataean/NotoSansNabataean.designspace
	* src/NotoSansNewTaiLue/NotoSansNewTaiLue.plist
	* src/NotoSansNewa/NotoSansNewa.plist
	* src/NotoSansOgham/NotoSansOgham.designspace
	* src/NotoSansOlChiki.glyphs
	* src/NotoSansOldHungarian/NotoSansOldHungarian.plist
	* src/NotoSansOldItalic/NotoSansOldItalic.plist
	* src/NotoSansOldNorthArabian/NotoSansOldNorthArabian.designspace
	* src/NotoSansOldPermic/NotoSansOldPermic.plist
	* src/NotoSansOldPersian/NotoSansOldPersian.designspace
	* src/NotoSansOldSogdian/NotoSansOldSogdian.plist
	* src/NotoSansOldSouthArabian/NotoSansOldSouthArabian.designspace
	* src/NotoSansOldTurkic/NotoSansOldTurkic.designspace
	* src/NotoSansOriya-MM.glyphs
	* src/NotoSansOriyaUI-MM.glyphs
	* src/NotoSansOsage/NotoSansOsage.plist
	* src/NotoSansOsmanya/NotoSansOsmanya.designspace
	* src/NotoSansPahawhHmong/NotoSansPahawhHmong.plist
	* src/NotoSansPalmyrene/NotoSansPalmyrene.plist
	* src/NotoSansPauCinHau/NotoSansPauCinHau.plist
	* src/NotoSansPhagsPa/NotoSansPhagsPa.plist
	* src/NotoSansPhoenician/NotoSansPhoenician.designspace
	* src/NotoSansPsalterPahlavi/NotoSansPsalterPahlavi.plist
	* src/NotoSansRejang/NotoSansRejang.plist
	* src/NotoSansRunic/NotoSansRunic.designspace
	* src/NotoSansSamaritan/NotoSansSamaritan.plist
	* src/NotoSansSaurashtra/NotoSansSaurashtra.plist
	* src/NotoSansSharada/NotoSansSharada.plist
	* src/NotoSansShavian/NotoSansShavian.designspace
	* src/NotoSansSiddham.glyphs
	* src/NotoSansSinhala/NotoSansSinhala-MM.plist
	* src/NotoSansSogdian/NotoSansSogdian.plist
	* src/NotoSansSoraSompeng/NotoSansSoraSompeng.designspace
	* src/NotoSansSoyombo/NotoSansSoyombo.designspace
	* src/NotoSansSundanese/NotoSansSundanese.designspace
	* src/NotoSansSylotiNagri/NotoSansSylotiNagri.plist
	* src/NotoSansSymbols/NotoSansSymbols.designspace
	* src/NotoSansSymbols2/NotoSansSymbols2.designspace
	* src/NotoSansSyriac/NotoSansSyriac-MM.plist
	* src/NotoSansTagalog/NotoSansTagalog.plist
	* src/NotoSansTagbanwa/NotoSansTagbanwa.plist
	* src/NotoSansTaiLe/NotoSansTaiLe.plist
	* src/NotoSansTaiViet/NotoSansTaiViet.plist
	* src/NotoSansTakri/NotoSansTakri.plist
	* src/NotoSansTamil/NotoSansTamil-MM.plist
	* src/NotoSansTamil/NotoSansTamilUI-MM.plist
	* src/NotoSansTamilSupplement/NotoSansTamilSupplement.designspace
	* src/NotoSansTelugu/NotoSansTelugu-MM.plist
	* src/NotoSansTelugu/NotoSansTeluguUI-MM.plist
	* src/NotoSansThaana/NotoSansThaana.designspace
	* src/NotoSansThai/NotoSansThai.designspace
	* src/NotoSansThaiUI/NotoSansThaiUI.designspace
	* src/NotoSansTifinagh-Regular.glyphs
	* src/NotoSansTifinagh.glyphs
	* src/NotoSansTirhuta/NotoSansTirhuta.plist
	* src/NotoSansUgaritic/NotoSansUgaritic.designspace
	* src/NotoSansVai/NotoSansVai.designspace
	* src/NotoSansWancho/NotoSansWancho.designspace
	* src/NotoSansWarangCiti/NotoSansWarangCiti.plist
	* src/NotoSansYi/NotoSansYi.designspace
	* src/NotoSansZanabazarSquare/NotoSansZanabazarSquare.designspace
	* src/NotoSerif-ItalicMM.glyphs
	* src/NotoSerif-MM.glyphs
	* src/NotoSerifAhom/NotoSerifAhom.plist
	* src/NotoSerifArmenian/NotoSerifArmenian.designspace
	* src/NotoSerifBalinese/NotoSerifBalinese.plist
	* src/NotoSerifBengali/NotoSerifBengali.designspace
	* src/NotoSerifDevanagari-MM.glyphs
	* src/NotoSerifDisplay-ItalicMM.glyphs
	* src/NotoSerifDisplay-MM.glyphs
	* src/NotoSerifDogra.glyphs
	* src/NotoSerifEthiopic/NotoSerifEthiopic.designspace
	* src/NotoSerifGeorgian/NotoSerifGeorgian.designspace
	* src/NotoSerifGrantha/NotoSerifGrantha.plist
	* src/NotoSerifGujarati-MM.glyphs
	* src/NotoSerifGurmukhi-MM.glyphs
	* src/NotoSerifHebrew/NotoSerifHebrew.designspace
	* src/NotoSerifKannada-MM.glyphs
	* src/NotoSerifKhmer/NotoSerifKhmer-MM.plist
	* src/NotoSerifLao-MM.glyphs
	* src/NotoSerifMalayalam/NotoSerifMalayalam-MM.plist
	* src/NotoSerifMyanmar/NotoSerifMyanmar-MM.plist
	* src/NotoSerifSinhala/NotoSerifSinhala.designspace
	* src/NotoSerifTamil-Slanted/NotoSerifTamilSlanted.designspace
	* src/NotoSerifTamil/NotoSerifTamil.designspace
	* src/NotoSerifTangut/NotoSerifTangut.designspace
	* src/NotoSerifTelugu/NotoSerifTelugu-MM.plist
	* src/NotoSerifThai-MM.glyphs
	* src/NotoSerifTibetan-MM.glyphs
	* src/Tinos-Bold/Tinos-Bold.plist
	* src/Tinos-BoldItalic/Tinos-BoldItalic.plist
	* src/Tinos-Italic/Tinos-Italic.plist
	* src/Tinos-Regular/Tinos-Regular.plist

