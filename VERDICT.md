# Library-data fixes for milestone 0.9.99 — verdict

| Issue | Repo | Branch (dudua99 fork) | Verdict |
|---|---|---|---|
| #3449 | toldot-gedolei-yisrael | `fix/ref-override-3449` (b0db29f) | **READY** |
| #4843 | toldot-gedolei-yisrael | `fix/ref-override-4843` (7940ab7) | **READY** |
| #4488 part 1 | SeforimLibrary | — (not pushed) | **NOT READY** — proposed cause is wrong |
| #4898 (Peretz part) | SeforimLibrary | — (not pushed) | **NOT READY** — Sefaria has no printed letters |

Note: the issue pages on Otzaria/otzaria could not be read from this session (the
API refused the repo), so the issue details used here come from the task description,
checked against the data.

## #3449 — READY
- `data/review/ref-overrides.json` did not exist on upstream `main`; `link_refs.py` reads it
  (`OVERRIDES = REVIEW / "ref-overrides.json"`), and a `null` value pops the claim's `ref`.
- Created it with `{"Q2909664|students|הרב צבי כץ, ראש ישיבת חזון נחום": null}` and
  re-ran `python scripts/link_refs.py`.
- Diff: only `data/entries/Q2909664.json`, one claim: `"ref": "Q18121747"` removed
  (Q18121747 = "צבי כץ", era *acharonim* — a different person). Stats: registry 5664 → 5663,
  unresolved 8200 → 8201; nothing else changed. A clean run on upstream before the
  change produced no content diff (only CRLF noise in `refs-unresolved.csv`, which git normalizes).
- `python scripts/validate.py`: 4305 checked, 0 with errors — same as before the change.
- The bundle was not rebuilt: `dist/biographies.json` and `site/index.html` are not
  updated in data commits upstream (they are stale on `main`); the release workflow
  builds assets from the entries when a `v*` tag is pushed — that is the maintainers' job.

## #4843 — READY
- Same procedure, branched separately from upstream `main`, with
  `{"Q7223005|family|רבי צבי הירש מייזליש": null}`.
- Diff: only `data/entries/Q7223005.json`, family claim `{"relation": "חתנו וממלא מקומו",
  "name": "רבי צבי הירש מייזליש"}` loses `"ref": "Q12410817"` (the Veitzener Rav, era
  *acharonei_zmanenu*). Stats as above. `validate.py`: 0 errors.
- **Merge note:** both branches create `data/review/ref-overrides.json`; the second one to
  merge will conflict. Resolve by keeping both keys in one object.

## #4488 part 1 — NOT READY
The proposed fix (map `Seif Katan` → `סעיף קטן` before `seif` in `mapSectionNameToHebrew`)
would change nothing for the reported books. That function is only a fallback used when
`heSectionNames` is blank (`SefariaBookPayloadReader.readHeSectionNames`). Sefaria's current
export (`storage.googleapis.com/sefaria-export/schemas/...`, 2026-11-01) has:

| Book | sectionNames | heSectionNames |
|---|---|---|
| Siftei Kohen on SA, Yoreh De'ah | Siman, Seif, Paragraph | סימן, **סעיף**, פסקה |
| Siftei Kohen on SA, Choshen Mishpat | Siman, Seif, Paragraph | סימן, **סעיף**, פסקה |
| Ketzot HaChoshen on SA, Choshen Mishpat | Siman, Seif, Paragraph | סימן, **סעיף**, פסקה |

So the "סעיף" label comes straight from Sefaria's Hebrew names, and "Seif Katan" does not
appear. Of 62 `* on Shulchan Arukh` schemas, every one named "Seif Katan" (Ba'er Hetev ×4,
Kaf HaChayim ×2, Eliyah Rabbah) already ships `heSectionNames = סעיף קטן`, so the mapping
is never reached there either.

A real fix needs a per-book decision: relabel level 2 as "סעיף קטן" for the books where
Sefaria's "Seif" is really a ס"ק (at least Shach YD/CM and Ketzot; probably also Taz,
Sma (Me'irat Einayim), Nekudot HaKesef, Pitchei Teshuva and others that use "Seif" — but
Be'er HaGolah/Beur HaGra-type books need checking against the print). Side effect to
handle: `SynthesizeSeifimAltTocPostProcess.simanHeadingMirror` deliberately skips books
whose main TOC already has "סעיף X" headings under a siman ("Shach, Taz on Yoreh De'ah");
after relabelling, those books would start getting a synthesized Seifim alt-TOC. That
needs a maintainer decision, so no branch was pushed.

## #4898 (Haggahot Rabbeinu Peretz) — NOT READY
- Exact titles (Sefaria export): commentary `Haggahot Rabbeinu Peretz on Sefer Mitzvot Katan`,
  base `Sefer Mitzvot Katan`, itag `data-commentator="Haggahot Rabbeinu Peretz on Sefer Mitzvot Katan"`.
- SeforimLibrary#88's `BaseTextLettering` takes each note's letter from the base text's
  itag `data-label` (and throws `itag without data-label` otherwise). In the SMK text all
  **709** Peretz itags have only `data-commentator` and `data-order`; **none** has
  `data-label`. So a `BaseTextLettering` entry would fail the build, and the printed letters
  aren't in Sefaria's data at all.
- Further facts: `data-order` equals the note's position within its siman in all 294 simanim;
  no note opens with its own letter. The commentary schema is `['Siman','Segment']` /
  `['סימן','']`, so the leaf has no Hebrew name and `numbersIntegerLeaf` leaves notes
  unprefixed, while `SefariaInlineAnchors` already labels the SMK anchors with
  `toGematria(order)`.
- Possible real fix (needs confirmation against the printed SMK, e.g. Kopys 1820, which
  Sefaria uses as its version): if the print letters the notes א, ב, ג… restarting per
  siman, number this book's leaf (as `NUMBERED_PARAGRAPH_SECTIONS` does for Shulchan Arukh
  HaRav). That would match the anchor letters already shown. Not done because it rests on
  an unverified assumption about the print. The Korban Netanel part is out of scope.

## Tests / linters
- toldot-gedolei-yisrael: `scripts/validate.py` (the repo's check; there's no test suite) — 0 errors on both branches.
- SeforimLibrary: no code changes, so no Gradle run.
