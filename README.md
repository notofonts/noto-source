![Noto](images/noto.png)

# Noto Source

Source files for generating Noto fonts.

The files in this repository might be work-in-progress for future versions of the fonts that have not been released yet. 
The designs and glyph sets might not final.

## Building

To obtain all sources and build tools:

```
$ git clone --recursive https://github.com/googlei18n/noto-source.git
$ cd noto-source
$ ./build setup
```
To build everything from source:

```
$ ./build all
```

other build options exist:

```bash
$ ./build src/NotoSans-MM.glyphs  # build from a single source
$               # if a font has both .glyphs and .plist files
$ ./build src/NotoSansBrahmi/NotoSansBrahmi.plist  # build from a single source
$ ./build variable src/NotoSans-MM.glyphs  # build a single variable font
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

## License

Noto source (under the src subdirectory) is under the [SIL Open Font License, version 1.1](src/LICENSE).

Build scripts are under the [Apache license, version 2.0](LICENSE).

## Contributing

To contribute to this project, please read [CONTRIBUTING](CONTRIBUTING.md) and [FONT_CONTRIBUTION](FONT_CONTRIBUTION.md)

## News

* 2015-12-07: first release, covering Noto Sans UI {Italic, Mono, Roman}, Noto Sans Display {Italic, Roman}, Noto {Sans, Serif} {Armenian, Georgian}.

