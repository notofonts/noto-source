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

Noto source (under the src subdirectory) is under the [SIL Open Font License, version 1.1](https://github.com/googlefonts/noto-source/tree/master/src/LICENSE).

Build scripts are under the [Apache license, version 2.0](LICENSE).

## Contributing

To contribute to this project, please read [CONTRIBUTING](CONTRIBUTING.md) and [FONT_CONTRIBUTION](FONT_CONTRIBUTION.md)

## News

* 2020-04-02: converted 63 font sources to UFO+designspace from .glyphs files.
* 2020-02-22: first UFO+designspace source for NotoSansHanifiRohingya
* 2015-12-07: first release, covering Noto Sans UI {Italic, Mono, Roman}, Noto Sans Display {Italic, Roman}, Noto {Sans, Serif} {Armenian, Georgian}.


## Source List as of 2020-04-05

There are three types of sources:

* *.glyphs: a single source file created using Glyphs.app [40 files]
* *.designspace: multiple files (.ufo + .designspace) comprising a source for the font [67 sets of files]
* *.plist: multiple files (.glyphs + .plist + .txt) comprising a source for the font. This one is using [Monotype's Fontdame format](http://monotype.github.io/OpenType_Table_Source/otl_source.html). [95 sets of files]
* The sources as of 2020-04-05 are:
	* [src/Arimo-Bold/Arimo-Bold.plist](https://github.com/googlefonts/noto-source/tree/master/src/Arimo-Bold)
	* [src/Arimo-BoldItalic/Arimo-BoldItalic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Arimo-BoldItalic)
	* [src/Arimo-Italic/Arimo-Italic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Arimo-Italic)
	* [src/Arimo-Regular/Arimo-Regular.plist](https://github.com/googlefonts/noto-source/tree/master/src/Arimo-Regular)
	* [src/Cousine-Bold/Cousine-Bold.plist](https://github.com/googlefonts/noto-source/tree/master/src/Cousine-Bold)
	* [src/Cousine-BoldItalic/Cousine-BoldItalic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Cousine-BoldItalic)
	* [src/Cousine-Italic/Cousine-Italic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Cousine-Italic)
	* [src/Cousine-Regular/Cousine-Regular.plist](https://github.com/googlefonts/noto-source/tree/master/src/Cousine-Regular)
	* [src/NotoKufiArabic.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoKufiArabic.glyphs)
	* [src/NotoMusic/NotoMusic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoMusic)
	* [src/NotoNaskhArabic.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoNaskhArabic.glyphs)
	* [src/NotoNaskhArabicUI.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoNaskhArabicUI.glyphs)
	* [src/NotoNastaliqUrdu/NotoNastaliqUrdu.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoNastaliqUrdu)
	* [src/NotoRashiHebrew.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoRashiHebrew.glyphs)
	* [src/NotoSans-ItalicMM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSans-ItalicMM.glyphs)
	* [src/NotoSans-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSans-MM.glyphs)
	* [src/NotoSansAdlam.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansAdlam.glyphs)
	* [src/NotoSansAdlamUnjoined.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansAdlamUnjoined.glyphs)
	* [src/NotoSansAnatolianHieroglyphs/NotoSansAnatolianHieroglyphs.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansAnatolianHieroglyphs)
	* [src/NotoSansArabic-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansArabic-MM.glyphs)
	* [src/NotoSansArabicUI-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansArabicUI-MM.glyphs)
	* [src/NotoSansArmenian/NotoSansArmenian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansArmenian)
	* [src/NotoSansAvestan/NotoSansAvestan.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansAvestan)
	* [src/NotoSansBamum/NotoSansBamum.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBamum)
	* [src/NotoSansBassaVah/NotoSansBassaVah.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBassaVah)
	* [src/NotoSansBatak/NotoSansBatak.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBatak)
	* [src/NotoSansBengali/NotoSansBengali-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBengali)
	* [src/NotoSansBengali/NotoSansBengaliUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBengali)
	* [src/NotoSansBhaiksuki.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBhaiksuki.glyphs)
	* [src/NotoSansBrahmi/NotoSansBrahmi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBrahmi)
	* [src/NotoSansBuginese/NotoSansBuginese.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBuginese)
	* [src/NotoSansBuhid/NotoSansBuhid.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansBuhid)
	* [src/NotoSansCanadianAboriginal/NotoSansCanadianAboriginal.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCanadianAboriginal)
	* [src/NotoSansCarian/NotoSansCarian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCarian)
	* [src/NotoSansCaucasianAlbanian/NotoSansCaucasianAlbanian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCaucasianAlbanian)
	* [src/NotoSansChakma/NotoSansChakma.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansChakma)
	* [src/NotoSansCham/NotoSansCham-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCham)
	* [src/NotoSansCherokee/NotoSansCherokee.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCherokee)
	* [src/NotoSansCoptic/NotoSansCoptic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCoptic)
	* [src/NotoSansCuneiform/NotoSansCuneiform.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCuneiform)
	* [src/NotoSansCypriot/NotoSansCypriot.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansCypriot)
	* [src/NotoSansDeseret/NotoSansDeseret.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDeseret)
	* [src/NotoSansDevanagari/NotoSansDevanagari-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDevanagari)
	* [src/NotoSansDevanagari/NotoSansDevanagariUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDevanagari)
	* [src/NotoSansDisplay-ItalicMM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDisplay-ItalicMM.glyphs)
	* [src/NotoSansDisplay-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDisplay-MM.glyphs)
	* [src/NotoSansDuployan.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansDuployan.glyphs)
	* [src/NotoSansEgyptianHieroglyphs/NotoSansEgyptianHieroglyphs.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansEgyptianHieroglyphs)
	* [src/NotoSansElbasan/NotoSansElbasan.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansElbasan)
	* [src/NotoSansElymaic/NotoSansElymaic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansElymaic)
	* [src/NotoSansEthiopic/NotoSansEthiopic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansEthiopic)
	* [src/NotoSansGeorgian/NotoSansGeorgian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGeorgian)
	* [src/NotoSansGlagolitic/NotoSansGlagolitic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGlagolitic)
	* [src/NotoSansGothic/NotoSansGothic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGothic)
	* [src/NotoSansGrantha/NotoSansGrantha.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGrantha)
	* [src/NotoSansGujarati/NotoSansGujarati-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGujarati)
	* [src/NotoSansGunjalaGondi.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGunjalaGondi.glyphs)
	* [src/NotoSansGurmukhi/NotoSansGurmukhi-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGurmukhi)
	* [src/NotoSansGurmukhi/NotoSansGurmukhiUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansGurmukhi)
	* [src/NotoSansHanifiRohingya/NotoSansHanifiRohingya.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansHanifiRohingya)
	* [src/NotoSansHanunoo/NotoSansHanunoo.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansHanunoo)
	* [src/NotoSansHatran/NotoSansHatran.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansHatran)
	* [src/NotoSansHebrew/NotoSansHebrew.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansHebrew)
	* [src/NotoSansImperialAramaic/NotoSansImperialAramaic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansImperialAramaic)
	* [src/NotoSansIndicSiyaqNumbers/NotoSansIndicSiyaqNumbers.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansIndicSiyaqNumbers)
	* [src/NotoSansInscriptionalPahlavi/NotoSansInscriptionalPahlavi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansInscriptionalPahlavi)
	* [src/NotoSansInscriptionalParthian/NotoSansInscriptionalParthian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansInscriptionalParthian)
	* [src/NotoSansJavanese/NotoSansJavanese-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansJavanese)
	* [src/NotoSansKaithi/NotoSansKaithi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKaithi)
	* [src/NotoSansKannada/NotoSansKannada-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKannada)
	* [src/NotoSansKannada/NotoSansKannadaUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKannada)
	* [src/NotoSansKayahLi/NotoSansKayahLi.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKayahLi)
	* [src/NotoSansKharoshthi/NotoSansKharoshthi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKharoshthi)
	* [src/NotoSansKhmer/NotoSansKhmer-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKhmer)
	* [src/NotoSansKhmerUI/NotoSansKhmerUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKhmerUI)
	* [src/NotoSansKhojki/NotoSansKhojki.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKhojki)
	* [src/NotoSansKhudawadi/NotoSansKhudawadi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansKhudawadi)
	* [src/NotoSansLao-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLao-MM.glyphs)
	* [src/NotoSansLaoUI-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLaoUI-MM.glyphs)
	* [src/NotoSansLepcha/NotoSansLepcha.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLepcha)
	* [src/NotoSansLimbu/NotoSansLimbu.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLimbu)
	* [src/NotoSansLinearA/NotoSansLinearA.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLinearA)
	* [src/NotoSansLinearB/NotoSansLinearB.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLinearB)
	* [src/NotoSansLisu/NotoSansLisu.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLisu)
	* [src/NotoSansLycian/NotoSansLycian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLycian)
	* [src/NotoSansLydian/NotoSansLydian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansLydian)
	* [src/NotoSansMahajani/NotoSansMahajani.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMahajani)
	* [src/NotoSansMalayalam/NotoSansMalayalam-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMalayalam)
	* [src/NotoSansMalayalam/NotoSansMalayalamUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMalayalam)
	* [src/NotoSansMandaic/NotoSansMandaic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMandaic)
	* [src/NotoSansManichaean/NotoSansManichaean.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansManichaean)
	* [src/NotoSansMarchen/NotoSansMarchen.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMarchen)
	* [src/NotoSansMasaramGondi.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMasaramGondi.glyphs)
	* [src/NotoSansMath/NotoSansMath.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMath)
	* [src/NotoSansMayanNumerals/NotoSansMayanNumerals.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMayanNumerals)
	* [src/NotoSansMeeteiMayek-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMeeteiMayek-MM.glyphs)
	* [src/NotoSansMendeKikakui/NotoSansMendeKikakui.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMendeKikakui)
	* [src/NotoSansMeroitic/NotoSansMeroitic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMeroitic)
	* [src/NotoSansMiao/NotoSansMiao.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMiao)
	* [src/NotoSansModi/NotoSansModi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansModi)
	* [src/NotoSansMongolian/NotoSansMongolian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMongolian)
	* [src/NotoSansMono-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMono-MM.glyphs)
	* [src/NotoSansMro/NotoSansMro.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMro)
	* [src/NotoSansMultani/NotoSansMultani.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMultani)
	* [src/NotoSansMyanmar/NotoSansMyanmar-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMyanmar)
	* [src/NotoSansMyanmarUI/NotoSansMyanmarUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansMyanmarUI)
	* [src/NotoSansNKo/NotoSansNKo.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansNKo)
	* [src/NotoSansNabataean/NotoSansNabataean.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansNabataean)
	* [src/NotoSansNewTaiLue/NotoSansNewTaiLue.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansNewTaiLue)
	* [src/NotoSansNewa/NotoSansNewa.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansNewa)
	* [src/NotoSansOgham/NotoSansOgham.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOgham)
	* [src/NotoSansOlChiki.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOlChiki.glyphs)
	* [src/NotoSansOldHungarian/NotoSansOldHungarian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldHungarian)
	* [src/NotoSansOldItalic/NotoSansOldItalic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldItalic)
	* [src/NotoSansOldNorthArabian/NotoSansOldNorthArabian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldNorthArabian)
	* [src/NotoSansOldPermic/NotoSansOldPermic.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldPermic)
	* [src/NotoSansOldPersian/NotoSansOldPersian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldPersian)
	* [src/NotoSansOldSogdian/NotoSansOldSogdian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldSogdian)
	* [src/NotoSansOldSouthArabian/NotoSansOldSouthArabian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldSouthArabian)
	* [src/NotoSansOldTurkic/NotoSansOldTurkic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOldTurkic)
	* [src/NotoSansOriya-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOriya-MM.glyphs)
	* [src/NotoSansOriyaUI-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOriyaUI-MM.glyphs)
	* [src/NotoSansOsage/NotoSansOsage.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOsage)
	* [src/NotoSansOsmanya/NotoSansOsmanya.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansOsmanya)
	* [src/NotoSansPahawhHmong/NotoSansPahawhHmong.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPahawhHmong)
	* [src/NotoSansPalmyrene/NotoSansPalmyrene.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPalmyrene)
	* [src/NotoSansPauCinHau/NotoSansPauCinHau.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPauCinHau)
	* [src/NotoSansPhagsPa/NotoSansPhagsPa.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPhagsPa)
	* [src/NotoSansPhoenician/NotoSansPhoenician.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPhoenician)
	* [src/NotoSansPsalterPahlavi/NotoSansPsalterPahlavi.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansPsalterPahlavi)
	* [src/NotoSansRejang/NotoSansRejang.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansRejang)
	* [src/NotoSansRunic/NotoSansRunic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansRunic)
	* [src/NotoSansSamaritan/NotoSansSamaritan.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSamaritan)
	* [src/NotoSansSaurashtra/NotoSansSaurashtra.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSaurashtra)
	* [src/NotoSansSharada/NotoSansSharada.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSharada)
	* [src/NotoSansShavian/NotoSansShavian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansShavian)
	* [src/NotoSansSiddham.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSiddham.glyphs)
	* [src/NotoSansSinhala/NotoSansSinhala-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSinhala)
	* [src/NotoSansSogdian/NotoSansSogdian.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSogdian)
	* [src/NotoSansSoraSompeng/NotoSansSoraSompeng.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSoraSompeng)
	* [src/NotoSansSoyombo/NotoSansSoyombo.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSoyombo)
	* [src/NotoSansSundanese/NotoSansSundanese.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSundanese)
	* [src/NotoSansSylotiNagri/NotoSansSylotiNagri.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSylotiNagri)
	* [src/NotoSansSymbols/NotoSansSymbols.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSymbols)
	* [src/NotoSansSymbols2/NotoSansSymbols2.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSymbols2)
	* [src/NotoSansSyriac/NotoSansSyriac-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansSyriac)
	* [src/NotoSansTagalog/NotoSansTagalog.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTagalog)
	* [src/NotoSansTagbanwa/NotoSansTagbanwa.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTagbanwa)
	* [src/NotoSansTaiLe/NotoSansTaiLe.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTaiLe)
	* [src/NotoSansTaiViet/NotoSansTaiViet.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTaiViet)
	* [src/NotoSansTakri/NotoSansTakri.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTakri)
	* [src/NotoSansTamil/NotoSansTamil-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTamil)
	* [src/NotoSansTamil/NotoSansTamilUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTamil)
	* [src/NotoSansTamilSupplement/NotoSansTamilSupplement.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTamilSupplement)
	* [src/NotoSansTelugu/NotoSansTelugu-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTelugu)
	* [src/NotoSansTelugu/NotoSansTeluguUI-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTelugu)
	* [src/NotoSansThaana/NotoSansThaana.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansThaana)
	* [src/NotoSansThai/NotoSansThai.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansThai)
	* [src/NotoSansThaiUI/NotoSansThaiUI.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansThaiUI)
	* [src/NotoSansTifinagh-Regular.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTifinagh-Regular.glyphs)
	* [src/NotoSansTifinagh.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTifinagh.glyphs)
	* [src/NotoSansTirhuta/NotoSansTirhuta.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansTirhuta)
	* [src/NotoSansUgaritic/NotoSansUgaritic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansUgaritic)
	* [src/NotoSansVai/NotoSansVai.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansVai)
	* [src/NotoSansWancho/NotoSansWancho.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansWancho)
	* [src/NotoSansWarangCiti/NotoSansWarangCiti.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansWarangCiti)
	* [src/NotoSansYi/NotoSansYi.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansYi)
	* [src/NotoSansZanabazarSquare/NotoSansZanabazarSquare.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSansZanabazarSquare)
	* [src/NotoSerif-ItalicMM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerif-ItalicMM.glyphs)
	* [src/NotoSerif-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerif-MM.glyphs)
	* [src/NotoSerifAhom/NotoSerifAhom.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifAhom)
	* [src/NotoSerifArmenian/NotoSerifArmenian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifArmenian)
	* [src/NotoSerifBalinese/NotoSerifBalinese.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifBalinese)
	* [src/NotoSerifBengali/NotoSerifBengali.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifBengali)
	* [src/NotoSerifDevanagari-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifDevanagari-MM.glyphs)
	* [src/NotoSerifDisplay-ItalicMM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifDisplay-ItalicMM.glyphs)
	* [src/NotoSerifDisplay-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifDisplay-MM.glyphs)
	* [src/NotoSerifDogra.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifDogra.glyphs)
	* [src/NotoSerifEthiopic/NotoSerifEthiopic.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifEthiopic)
	* [src/NotoSerifGeorgian/NotoSerifGeorgian.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifGeorgian)
	* [src/NotoSerifGrantha/NotoSerifGrantha.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifGrantha)
	* [src/NotoSerifGujarati-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifGujarati-MM.glyphs)
	* [src/NotoSerifGurmukhi-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifGurmukhi-MM.glyphs)
	* [src/NotoSerifHebrew/NotoSerifHebrew.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifHebrew)
	* [src/NotoSerifKannada-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifKannada-MM.glyphs)
	* [src/NotoSerifKhmer/NotoSerifKhmer-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifKhmer)
	* [src/NotoSerifLao-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifLao-MM.glyphs)
	* [src/NotoSerifMalayalam/NotoSerifMalayalam-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifMalayalam)
	* [src/NotoSerifMyanmar/NotoSerifMyanmar-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifMyanmar)
	* [src/NotoSerifSinhala/NotoSerifSinhala.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifSinhala)
	* [src/NotoSerifTamil-Slanted/NotoSerifTamilSlanted.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifTamil-Slanted)
	* [src/NotoSerifTamil/NotoSerifTamil.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifTamil)
	* [src/NotoSerifTangut/NotoSerifTangut.designspace](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifTangut)
	* [src/NotoSerifTelugu/NotoSerifTelugu-MM.plist](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifTelugu)
	* [src/NotoSerifThai-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifThai-MM.glyphs)
	* [src/NotoSerifTibetan-MM.glyphs](https://github.com/googlefonts/noto-source/tree/master/src/NotoSerifTibetan-MM.glyphs)
	* [src/Tinos-Bold/Tinos-Bold.plist](https://github.com/googlefonts/noto-source/tree/master/src/Tinos-Bold)
	* [src/Tinos-BoldItalic/Tinos-BoldItalic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Tinos-BoldItalic)
	* [src/Tinos-Italic/Tinos-Italic.plist](https://github.com/googlefonts/noto-source/tree/master/src/Tinos-Italic)
	* [src/Tinos-Regular/Tinos-Regular.plist](https://github.com/googlefonts/noto-source/tree/master/src/Tinos-Regular)

