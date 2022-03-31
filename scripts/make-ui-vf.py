import argparse
from dataclasses import replace
import sys
import glyphsLib
from fontTools.ttLib import TTFont
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen

def transform(ttfont, x, y):
    glyphset = ttfont.getGlyphSet()

    for glyphname in glyphset.keys():
        glyph = glyphset[glyphname]
        pen = TTGlyphPen(glyphset)
        
        transformpen = TransformPen(pen, (1, 0, 0, 1, x, y))
        glyph.draw(transformpen)
        transformed = pen.glyph()
        ttfont['glyf'].glyphs[glyphname] = transformed

def reencode(ttfont, glyph, cp):
    print("Reencoding %x to %s" % (cp, glyph))
    for subtable in ttfont["cmap"].tables:
        subtable.cmap[cp] = glyph

def grovel_substitutions(font, lookup, glyphmap):
    if lookup.LookupType == 7:
        raise NotImplementedError
    gmap = lambda g: glyphmap.get(g,g)
    go = font.getGlyphOrder()

    def do_coverage(c):
        c.glyphs = list(sorted([gmap(g) for g in c.glyphs], key=lambda g:go.index(g)))
        return c

    for st in lookup.SubTable:
        if lookup.LookupType == 1:
            newmap = {}
            for inglyph, outglyph in st.mapping.items():
                newmap[gmap(inglyph)] = gmap(outglyph)
        elif lookup.LookupType == 2:
            newmap = {}
            for inglyph, outglyphs in st.mapping.items():
                newmap[gmap(inglyph)] = [gmap(g) for g in outglyphs]
            st.mapping = newmap
        elif lookup.LookupType == 4:
            newligatures = {}
            for outglyph, inglyphs in st.ligatures.items():
                for ig in inglyphs:
                    ig.LigGlyph = gmap(ig.LigGlyph)
                    ig.Component = [gmap(c) for c in ig.Component]
                newligatures[gmap(outglyph)] = inglyphs
        elif lookup.LookupType == 5:
            if st.Format == 1:
                do_coverage(st.Coverage)
                for srs in st.SubRuleSet:
                    for subrule in srs.SubRule:
                        subrule.Input = [gmap(c) for c in subrule.Input]
            elif st.Format == 2:
                do_coverage(st.Coverage)
                st.ClassDef.classDefs = {gmap(k):v for k,v in st.ClassDef.classDefs.items()}
            else:
                st.Coverage = [do_coverage(c) for c in st.Coverage]
        elif lookup.LookupType == 6:
            if st.Format == 1:
                do_coverage(st.Coverage)
                for srs in st.ChainSubRuleSet:
                    for subrule in srs.ChainSubRule:
                        subrule.Backtrack = [gmap(c) for c in subrule.Backtrack]
                        subrule.Input = [gmap(c) for c in subrule.Input]
                        subrule.LookAhead = [gmap(c) for c in subrule.LookAhead]
            elif st.Format == 2:
                do_coverage(st.Coverage)
                st.BacktrackClassDef.classDefs = {gmap(k):v for k,v in st.BacktrackClassDef.classDefs.items()}
                st.InputClassDef.classDefs = {gmap(k):v for k,v in st.InputClassDef.classDefs.items()}
                st.LookAheadClassDef.classDefs = {gmap(k):v for k,v in st.LookAheadClassDef.classDefs.items()}
            elif st.Format == 3:
                st.BacktrackCoverage = [ do_coverage(c) for c in st.BacktrackCoverage]
                st.InputCoverage = [ do_coverage(c) for c in st.InputCoverage]
                st.LookAheadCoverage = [ do_coverage(c) for c in st.LookAheadCoverage]

# Parse command line arguments
parser = argparse.ArgumentParser(description='Generate a UI font from existing binary and Glyphs file')
parser.add_argument('--output', '-o', help='Output font file')
parser.add_argument('binary', help='Binary font file')
parser.add_argument('glyphs', help='Glyphs file')
args = parser.parse_args()

if not args.output:
    if "-VF.ttf" not in args.binary:
        print("Error: Output file not specified")
        sys.exit(1)
    args.output = args.binary.replace('-VF.ttf', 'UI-VF.ttf')

gsfont = glyphsLib.GSFont(args.glyphs)
ttfont = TTFont(args.binary)

# Find UI instances
cp = None
for instance in gsfont.instances:
    if "UI" in instance.familyName:
        cp = instance.customParameters
        break

if cp is None:
    print("No UI instance found")
    sys.exit(1)

cp = { p.name: p.value for p in cp }
print("Creating UI font with custom parameters %s" % cp)

if "typoAscender" in cp:
    ttfont['OS/2'].sTypoAscender = int(cp["typoAscender"])
if "typoDescender" in cp:
    ttfont['OS/2'].sTypoDescender = int(cp["typoDescender"])
if "typoLineGap" in cp:
    ttfont['OS/2'].sTypoLineGap = int(cp["typoLineGap"])
if "winAscent" in cp:
    ttfont['OS/2'].usWinAscent = int(cp["winAscent"])
if "winDescent" in cp:
    ttfont['OS/2'].usWinDescent = int(cp["winDescent"])
if "hheaAscender" in cp:
    ttfont['hhea'].ascent = int(cp["hheaAscender"])
if "hheaDescender" in cp:
    ttfont['hhea'].descent = int(cp["hheaDescender"])
if "hheaLineGap" in cp:
    ttfont['hhea'].lineGap = int(cp["hheaLineGap"])
if "xHeight" in cp:
    ttfont['OS/2'].sxHeight = int(cp["xHeight"])

if "Filter" in cp:
    assert cp["Filter"].startswith("Transformations;")
    filter_args = cp["Filter"].split(";")
    filter_args = filter_args[1:-1]
    filter_args = { arg.split(":")[0]: arg.split(":")[1] for arg in filter_args }
    if "ScaleX" in filter_args or "ScaleY" in filter_args:
        print("ScaleX and ScaleY are not supported")
        sys.exit(1)
    offset_x = int(filter_args.get("OffsetX", "0"))
    offset_y = int(filter_args.get("OffsetY", "0"))
    if offset_x or offset_y:
        print("Transforming glyphs by %d, %d" % (offset_x, offset_y))
        transform(ttfont, offset_x, offset_y)

if "Reencode Glyphs" in cp:
    for parm in cp["Reencode Glyphs"]:
        glyph, codepoint = parm.split("=")
        reencode(ttfont, glyph, int(codepoint, 16))

# Mash the GSUB table
uis = [ x for x in ttfont.getGlyphOrder() if "UI" in x and x.replace("UI", "") in ttfont.getGlyphOrder() ]
for lookup in ttfont["GSUB"].table.LookupList.Lookup:
    grovel_substitutions(ttfont, lookup, { g.replace("UI", ""): g for g in uis})


ttfont.save(args.output)
