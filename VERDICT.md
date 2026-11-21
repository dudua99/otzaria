# SeforimLibrary fixes for Otzaria/otzaria #4488 (part 1) and #4898

Both branches are cut from `upstream/otzaria` (Otzaria/SeforimLibrary, 4bbf7dc) and pushed to dudua99/SeforimLibrary.

| Item | Branch | Commit | Verdict |
|---|---|---|---|
| #4488 part 1 | `fix/seif-katan-label-4488` | b12c124 | **READY** |
| #4898 (Haggahot Rabbeinu Peretz) | `fix/hagahot-peretz-letters-4898` | 17af170 | **READY** |

The earlier attempt (`prbody/datafix-0.9.99`) found that the first ideas were wrong:
`mapSectionNameToHebrew` is only a fallback, and SMK itags have no `data-label`, so
`BaseTextLettering` does not apply. These fixes take the routes that the verdict described.

## #4488 part 1 — READY
**Cause.** Sefaria's own `heSectionNames` for the three books are `סימן, סעיף, פסקה`
(checked against the current export). Level 2 numbers the commentator's סעיפים קטנים.

**Fix** (`SefariaImportText.kt`, `SefariaBookPayloadReader.kt`):
- `SEIF_KATAN_LEVEL_BOOKS` is an explicit per-book list of exactly these books: Siftei Kohen YD,
  Siftei Kohen CM and Ketzot HaChoshen CM. It maps each English title to its Hebrew title (`book.heRef`).
- `withSeifKatanLevel` relabels level 2 of the book's **main (default) node only**, so
  "S'fek S'feka Summary" (Shach YD) and "Dinei Migo" (Shach CM) keep their own names.
  It accepts only `[סימן, סעיף, …]` (or an already-fixed `סעיף קטן`). Any other shape
  throws `SefariaSchemaException`.
- Line ids stay stable. The relabelled heading lines keep the key of their old text
  (`"<h3>סעיף X</h3>"`), using the same mechanism as `legacyThousandsGematria`.

**Alt-TOC side effect handled** (`SynthesizeSeifimAltTocPostProcess.kt`):
`simanHeadingMirror` used to skip these books because they had "סעיף X" under each siman. It now gets
`seifKatanLevel = candidate.heRef in SEIF_KATAN_LEVEL_BOOKS.values`, and for those books only
a "סעיף קטן X" heading under a siman also excludes the book. Other books are unaffected:
the existing test `se'if-katan headings under the siman do not exclude the book`
(Mishnah Berurah fixture) still passes. The match uses `heRef`, which stays the same through
`book_renames.csv` and author prefixes.

**Tests.**
- New `SefariaSeifKatanLevelTest` (7 tests): Shach YD, Shach CM and Ketzot get "סעיף קטן X"; no
  "סעיף X" heading remains; the named node is untouched; an unlisted book of the same shape
  (Taz CM) keeps "סעיף"; the line key equals the old heading's hash; a reshaped schema fails loudly.
- New integration test `a relabelled seif-katan main TOC stays excluded like its old seif headings`:
  for each of the 3 heRefs the book stays out of the Seifim synthesis. It is also
  excluded with the old "סעיף א" label, so the output is the same before and after.
- Before the fix: 6 of the new tests fail. After the fix: all pass.
- Full `./gradlew :sefariasqlite:jvmTest`: **969 tests, 0 failures**.

**Not extended (candidates for maintainers, need checking against the print):** Taz (Turei Zahav),
Sma (Me'irat Einayim), Nekudot HaKesef, Pitchei Teshuva, and other `* on Shulchan Arukh` books whose
level 2 Sefaria calls "Seif". Books like Be'er HaGolah and Beur HaGra may really be by se'if.
Adding a book means one entry in `SEIF_KATAN_LEVEL_BOOKS`. The alt-TOC exclusion follows automatically.

## #4898 — READY
**Cause.** `SefariaInlineAnchors` labels the SMK anchors `toGematria(data-order)`, because the itags
have no `data-label`. The commentary schema is `['Siman','Segment'] / ['סימן','']`. Its leaf has no Hebrew
name, so `numbersIntegerLeaf` was false and the notes had no letter.

**Fix** (`SefariaBookPayloadReader.kt`): `BASE_ANCHOR_LETTERED_SECTIONS =
["Haggahot Rabbeinu Peretz on Sefer Mitzvot Katan, "]` feeds `numbersIntegerLeaf`, using the same
mechanism as `NUMBERED_PARAGRAPH_SECTIONS`. The no-nodes path now passes its ref prefix too.
Each note gets "(letter) " by its position in the siman, and the letters restart per siman.
A `lettersLoneLeaf` flag also letters a siman's **only** note. Otherwise the generic
`nonEmptyCount > 1` rule would leave 50 single-note simanim bare while their anchor shows "א".
Line keys hash the raw segment (generated prefixes are excluded), so line ids do not change.

**Verification on the real Sefaria export** (merged.json for both books, run through the real
`SefariaBookPayloadReader`, compared with `toGematria(data-order)` of every Peretz itag in SMK):
`notes=709 lettered=709 anchors=709 simanim=134 mismatches=0`. Every note has an anchor and
every anchor has a note. (294 is the length of the siman array, and 134 simanim have notes.)

**Tests.** New `SefariaBaseAnchorLetteredNotesTest` (3 tests). The first checks the letters restart
per siman, including a lone note and an empty siman. The second checks headings and refs are unchanged.
The third checks another book of the same shape stays unlettered. Before the fix the lettering test fails.
After the fix all pass. Full `:sefariasqlite:jvmTest`: **964 tests, 0 failures**.

## Build environment (cloud run)
Gradle needed local changes that were not committed: Google Maven (dl.google.com) is blocked by the proxy,
so the Android plugin and target were removed from `build.gradle.kts`, `core` and `dao`.
`compileOnly(compose.runtime)` was replaced by a stub `androidx.compose.runtime.Stable`.
Maven Central was reached through its Google mirror (init script) because of HTTP 429.
JDK 25 came from apt, and the build ran with a UTF-8 locale. None of this is in the pushed branches.
Nothing was posted on GitHub.
