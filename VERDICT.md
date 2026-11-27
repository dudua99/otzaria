READY
# libdata-2611 — full local build + delta vs v40 inputs (2026-11-27)

Every row of the delta is attributed to one of #4172, #5826, #5471, #4023 (or is the version stamp). Nothing else changed.
`producePatchAndVerify`: **✅ Patch apply verified: target hash matches new** (`8be6a1a85970102e7e08ac9d909031a66a2e1195c57b6567101f823489e7c3f1`).
patch.db 684,032 bytes → 24,847 bytes zstd L22.

## Inputs
| | v1 (baseline) | v2b (candidate) |
|---|---|---|
| SeforimLibrary | `c5e2801` (+ SeforimMagicIndexer `a5a0245b`) | `c5e2801` + `git am patches/4023/*.patch` → `1d7a9269`, `1ed6179a` (applied cleanly) |
| Sefaria export | `2026-11-23_10-32-45139177019-1`, archive sha256 `1226ae7c…f87c` ✔ | same |
| Otzaria tree | `library-links-45147067439-1-28976848e5b0` `otzaria_latest.zip` sha256 `580bfa03…2be4` ✔ | same tree + 38 `חברותא על *.txt` from `python3 -I patches/5471/hadran.py` on otzaria-library `28976848` (the packaged files were byte-identical to the repo files at `28976848`, 38/38); 321 lines differ, every line count unchanged; the 38 hashes in `files_manifest.json` updated |
| ForDB | `fordb-sha256-4be7b46c…3faf10` ✔ (rebuilding its extracted contents with `fordb_archive.py build` reproduces `4be7b46c` exactly) | v40 ForDB + only the two row edits of patches/4172 and patches/5826 → `b5ceef29ee3f84c6682846d4f76e1bc7d53b689c606d06b2ea3b430d3dbf9a35` (exactly 2 rows differ) |
| acronymizer.db | SeforimAcronymizer release `20261119.68` (latest when v40 was built), sha256 `26693189…56cd` | same |
| v2b allocator | — | seeded with v1's `seforim.db.buildstate` |

v1 sanity vs v40's published `library_stats.json`: books **8259 = 8259**, lines **7,925,185 = 7,925,185**. links 4,454,493 vs 7,001,824: the LINKER links come from the GPU relink pipeline, which a local build does not run — identical on both sides, so they cancel.

## Durations (4 cores / 15 GB)
| step | v1 | v2b |
|---|---|---|
| Sefaria phase (`:sefariasqlite:generateSefariaSqlite`) | 51 min | 50 min |
| rest of `generateSeforimDb` (Otzaria lines disk-backed, links, indexes) | 2 h 52 min | 2 h 40 min |
| `compressLineContent` | 35 min | 24 min |
| `producePatchAndVerify` | 14.5 min (both) | |

## Per-table counts (patch.db; every other upsert_/delete_ table = 0)
| table | upsert | delete | issue |
|---|---|---|---|
| `category` | 1 | 0 | #4172 |
| `book` | 39 | 0 | #5826 (1: heDesc) + #5471 (38: contentHash) |
| `line_content` | 321 | 321 | #5471 |
| `line` | 321 | 321 | #5471 (same rows, new line ids — see below) |
| `line_toc` | 321 | 321 | #5471 (follows the new line ids) |
| `link` | 6 | 6 | #4023 (1) + #5471 knock-on (5) |
| `link_range` | 1 | 0 | #4023 |
| `link_coverage` | 1 | 0 | #4023 |
| `schema_meta` | 1 | 0 | `db_version` 1 → 2 (stamp) |

Table totals v1 → v2b: book 8259=8259, line 7,925,185=7,925,185, link 4,454,493=4,454,493, category 1442=1442, tocEntry 1,676,654=, line_note 288,202=, link_anchor 341,239=, link_range 121,493→121,494, link_coverage 996,276→996,277.

## Attribution of every row
- **#4172** — `category` 1735 `דרשות ודרושים`: `heShortDesc` and `heDesc` `דרשות ודרושים על סדר המקרא. ובו: ליקוטי חבר בן חיים.` → `דרשות ודרושים על סדר המקרא.` (1 row). (Local id 1735; v40's published id is 1468 — local ids differ, matched by title.)
- **#5826** — `book` 124 `בבא בתרא` (Sefaria): `heDesc` `המסכת עוסקת בעיקר בדיני קרקעות. טעם כפיית מחיצה על השכן היא משום היזק ראיה, וא"כ גם פרק א' עוסק בהרחקת נזקים` → `המסכת עוסקת בעיקר בדיני קרקעות.` (1 row).
- **#5471** — the 38 books `חברותא על *` (local ids 7932–7969): `contentHash` changed on all 38, nothing else on `book` (`totalLines` unchanged). 321 lines (per book: 3–25; שבת 25): content `<br><center><big><b>הדרן…</b></big></center>` → `<center><big><b>הדרן…</b></big></center><br>` (and the 5 tractate-closing pairs). Each changed line is a delete + insert: **the generator gives a line whose content changed a new line id**; checked for all 321: same `bookId`, `lineIndex`, `heRef`, `charCount` and `tocEntryId`; the 321 `line_toc` rows point to the same toc entries. Knock-on: 5 Havrouta COMMENTARY links (GenerateHavroutaLinks) whose target is one of those lines are re-created with the new line id — identical endpoints (book + heRef) and type:
  ביצה מ:, ד → חברותא על ביצה 4420; עירובין קה., יב → חברותא על עירובין 13461; פסחים צט., ה → חברותא על פסחים 11666; פסחים קכא:, ג → חברותא על פסחים 13501; שבת קנז:, ג → חברותא על שבת 15418.
  No line count, TOC, note or other link changed.
- **#4023** — `link` 1064034 COMMENTARY `שבת, קמא:, טז` → `חידושי רמב"ן על שבת, קמא:, ב` deleted; new `link` 4454494 COMMENTARY `שבת, קמא:, כח` → the same Ramban line (`baseProvenance` 2 as before); + `link_range` (source side, endLineIndex 3626 = `שבת, קמב., א`, line 35456) + 1 `link_coverage` (line 35456). The `<h2>` heading line is not covered. Net link count 0.

## Unexpected / notes
- Only the line-id re-keying above (321 line + 321 line_toc + 5 link delete/insert pairs instead of in-place updates). It is how the generator treats a line whose text changed, not an effect of the data; the endpoints are identical. Nothing else.

## Local environment workarounds (identical for v1 and v2b; not committed)
- Gradle init script: Maven Central mirror `https://maven-central.storage-download.googleapis.com/maven2/` first (429 from repo1).
- Google Maven is blocked: Android plugin removed from `build.gradle.kts`/`core`/`dao`; `compileOnly(libs.compose.runtime)` removed and a stub `core/src/commonMain/kotlin/androidx/compose/runtime/Stable.kt` (`annotation class Stable`) added. JVM generator code untouched.
- `generator/otzariasqlite/build.gradle.kts`: `args(":memory:")` → `args(persistDb)` for `appendOtzariaLines` and `appendOtzariaLinks` (disk-backed, 15 GB box); `~/.gradle/gradle.properties`: `generatorHeap=8g linkerHeap=8g org.gradle.jvmargs=-Xmx1536m`; `-PinMemoryDb=false --max-workers=2`; `LANG=C.UTF-8`.
- JDK Temurin 25.0.1+8 (github.com/adoptium tarball).
- `acronymizer.db` and `lexical.db` downloaded directly from github.com release URLs (the API is blocked); `textimages.sefaria.org` blocked → no Sefaria images on either side.
- The Sefaria phase was run as its own Gradle invocation (`:sefariasqlite:generateSefariaSqlite`), then `generateSeforimDb -x :sefariasqlite:generateSefariaSqlite`, to snapshot between the two; same properties both times.
- Full `git diff` of the workarounds: `local_workarounds.diff`.
