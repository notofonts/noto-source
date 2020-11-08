#  How to Edit and Build Naskh

NotoNaskhArabic.glyphs is used for building and NotoNaskhArabic-for-edit.glyphs is used for editing.

NotoNaskhArabic.glyphs is created from NotoNaskhArabic-for-edit.glyphs by running the following script/macro within the Glyphs.app and then saving the resulting file as NotoNaskhArabic.glyphs
```
for glyph in Glyphs.font.glyphs:
  for layer in glyph.layers:
    if not layer.components:
      continue
    layer.anchors = list(layer.anchorsTraversingComponents())
```

If you know a better way to handle this please advise by filing a new Noto source issue https://github.com/googlefonts/noto-source/issues/new
