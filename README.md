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

