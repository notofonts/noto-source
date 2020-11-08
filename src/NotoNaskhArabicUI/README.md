#  How to Edit and Build Naskh

NotoNaskhArabicUI.glyphs is used for building and NotoNaskhArabicUI-for-edit.glyphs is used for editing.

NotoNaskhArabicUI.glyphs is created from NotoNaskhArabicUI-for-edit.glyphs by running the following script/macro within the Glyphs.app and then saving the resulting file as NotoNaskhArabicUI.glyphs
```
for glyph in Glyphs.font.glyphs:
  for layer in glyph.layers:
    if not layer.components:
      continue
    layer.anchors = list(layer.anchorsTraversingComponents())
```
