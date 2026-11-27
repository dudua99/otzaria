NOT READY
# uniform-titles-3209 (dudua99/otzaria-library `names/uniform-titles-3209` @ `1f5dd43be8`): full local build + delta vs v40 inputs (2026-11-27)

`producePatchAndVerify`: **✅ Patch apply verified: target hash matches new** (`31b546b0f5d3bb4b8de462a4fbb10fc1a4b93e090cdee6c43e62709db905ffb7`); patch.db 1,961,984 bytes → 184,660 bytes zstd.
The renames themselves come out as intended (28 book titles, 23 folders + the Sefaria category `חדושי הרא״ה`), no book, line, note, author or description is lost. **Two real losses block it**, and both need a companion change:

1. **`line_dh` of `חוות דעת חידושים` (book 6305) disappears: −1163 rows.** SeforimLibrary `generator/common/src/jvmMain/resources/line_dh_book_overrides.csv` line 261 includes the book by its old title (`"MoreBooks","חוות דעת חדושים","include",…`). After the rename no override matches, so `buildLineDhIndex` drops the book (its dibbur-hamatchil index is gone). Fix: SeforimLibrary has to rename that override row to `חוות דעת חידושים` (same PR train / before the library release), or the book keeps its old name. No other SeforimLibrary resource names any of the 28 old titles (checked).
2. **1 link lost** (`link` 3928314, COMMENTARY `תוספות ישנים  על כריתות, ג., א, א` → `שפת אמת על כריתות 15`). `DictaToOtzaria/ערוך/links/שפת אמת על כריתות_links.json` still has `path_2: "תוספות ישנים  על כריתות.txt"` / `heRef_2: "תוספות ישנים  על כריתות ג., א, א"` (double space); the branch renames that Sefaria book to `תוספות ישנים על כריתות` (commit fa8bad9f), so the reference no longer resolves. The CI auto-fix (`validate_fordb_book_names.py --fix`) follows only repo-file renames, not `book_renames.csv`, and does not touch it. Fix: rewrite that entry in the same branch. It is the only reference to any of the 24 old Sefaria titles in all packaged links files (checked).

Also not "ideal" (no data lost, but ids churn, so worth knowing before merging):
3. **Renamed folders get new category ids.** Only the Sefaria category `חדושי הרא״ה` (id 1043) is renamed in place. The 23 repo folders that get gershayim are deleted and re-created with new ids, and so are 6 sub-folders whose own names did not change (`ליקוטי מהרי״ל/סדר נשים`, and `גליוני הש״ס/{מועד,נזיקין,נשים}` under both Bavli and Yerushalmi). That's 29 categories deleted + 29 inserted, `category_closure` −100/+100, and `book.categoryId` changes on the 122 books inside them. `category_renames.csv` (11 folder rules) does not carry their ids. A client that keys anything by category id (open shelves, filters) loses it for those 29 shelves.
4. **Topics follow the folder names.** 21 topics are deleted and 22 created (`book_topic` −116/+116, same 116 books). One side-effect: the author topic `רמחל` (id 71, 30 books in v1) is split. The 3 Ben-Yehuda books moved from `מחשבת ישראל/אחרונים/רמחל` to `…/רמח״ל` get a new topic `רמח״ל` (289), and the other 27 books keep `רמחל` (71). `IdAllocatorBindings.upsertTopic` keys topics by the exact folder spelling.

## Inputs
| | v1 (baseline) | v2a (candidate) |
|---|---|---|
| SeforimLibrary | `c5e2801` (+ SeforimMagicIndexer `a5a0245b`) | same (unchanged) |
| Sefaria export | `2026-11-23_10-32-45139177019-1`, archive sha256 `1226ae7c…f87c` ✔ | same |
| ForDB | `fordb-sha256-4be7b46c…3faf10` ✔ (re-zipping its contents with `fordb_archive.py` reproduces `4be7b46c`) | v40 ForDB + `git diff f4b89786..1f5dd43b -- ForDB` minus `README.md` and `book_info_identity.json` (not shipped) → **`9bf3ab1cd0b2959962e688caf59fd8a90d32e8b1b7dc545823b21f49fa0d9911`**. All 9 shipped-file diffs applied with `git apply` without hand edits. `book_info.csv` hunks landed at offsets −4/−4/−4/−8 because main moved since v40 (`fordb.diff` here). |
| Otzaria tree | `library-links-45147067439-1-28976848e5b0` `otzaria_latest.zip` sha256 `580bfa03…2be4` ✔ | v40 tree + the **133 R100 moves** at packaged paths (`<root>/ספרים/אוצריא/X` → `אוצריא/X`; all 133 sources found, no destination existed, moved files byte-identical; `moves_packaged.tsv`), + `metadata.json` diff (4 titles) and `SourcesBooks.csv` diff (both applied cleanly), + CI links auto-fix (below), + `files_manifest.json`: 135 keys moved (133 books + 2 links files), SA YD links hash updated |
| v2a allocator | — | seeded with v1's `seforim.db.buildstate` |

**Links auto-fix:** `validate_fordb_book_names.py --rename-base f4b89786` on a checkout of 1f5dd43b. The Sefaria index was served from the pinned export's `table_of_contents.json` because sefaria.org is blocked here. Report mode exits **0**: the row-1243 failure found on 9f6a441d (`sefaria_category_changes.csv` path with the old `חדושי הרא״ה`) **is fixed** by 1916669d/1f5dd43b. `--fix` exits 0 and changes only links files: `KSK/links/חידושי הראה על עבודה זרה_links.json` → `חידושי הרא״ה …`, `MoreBooks/links/חוות דעת חדושים_links.json` → `חוות דעת חידושים …`, and the path_2/heRef_2 rewrites in `MoreBooks/links/שולחן ערוך, יורה דעה_links.json` (`links_autofix.diff`). No ForDB file is touched. The packaged links files were byte-identical to the repo files, so the fixed files were copied into `links/`.

## Durations (4 cores / 15 GB)
v1: Sefaria phase 51 min + rest 2 h 52 min. v2a: Sefaria 48 min + rest 2 h 38 min. compressLineContent v2a 21 min; producePatchAndVerify 12 min.

## Per-table counts (patch.db; every other upsert_/delete_ table = 0) and attribution
| table | upsert | delete | what |
|---|---|---|---|
| `book` | 150 | 0 | 24 Sefaria renames (`title` only; `book.heRef` stays), 4 repo renames (`title`+`heRef`), 122 `categoryId` (books in the 29 re-created categories) |
| `line` | 16,901 | 0 | `heRef` only, lines of the 4 renamed repo books: 7575 `חידושי רע״א על תלמוד בבלי` 15,478; 6305 `חוות דעת חידושים` 1,231; 7971 `חידושי הרא״ה על עבודה זרה` 189; 8023 `חידושי הר״י מיגאש על בבא מציעא` 3. Same ids; Sefaria books' line heRefs unchanged |
| `category` | 30 | 29 | 1 rename in place (1043 `חדושי הרא״ה` → `חידושי הרא״ה`) + 29 re-created (item 3) |
| `category_closure` | 100 | 100 | follows the 29 re-created categories only |
| `topic` | 22 | 21 | folder-name topics (item 4) |
| `book_topic` | 116 | 116 | same 116 books, re-pointed to the new topics |
| `book_acronym` | 6 | 3 | the old title kept as a search term of 6 renamed books (4975, 4976, 5071, 6305, 7575, 8023); for 4975/4976/5071 the acronymizer's full-spelling alias is dropped because it now equals the title |
| `line_dh` | 0 | **1163** | **loss, item 1** |
| `link` | 0 | **1** | **loss, item 2** |
| `schema_meta` | 1 | 0 | `db_version` 1 → 2 |

Totals v1 → v2a: book 8259 = 8259, line 7,925,185 =, category 1442 =, tocEntry, line_note, link_range, link_coverage, link_anchor, author, book_author unchanged; link 4,454,493 → 4,454,492; line_dh 1,273,149 → 1,271,986; topic 284 → 285; book_acronym 41,825 → 41,828. No book, author, note, description or metadata row lost.

Full lists of the 28 book-title changes and the category changes are in `DELTA.md`.

## Local environment (identical on both sides; not committed)
Same as yesterday's draft, except: JDK Temurin 25.0.1+8 (github.com/adoptium tarball worked today); `acronymizer.db` = the `.db` asset of SeforimAcronymizer release `20261119.68`, downloaded directly; `lexical.db` downloaded directly. Gradle Maven Central mirror; Android targets removed + `Stable` stub; `args(persistDb)` for appendOtzariaLines/Links; generatorHeap=8g; `-PinMemoryDb=false --max-workers=2`; textimages.sefaria.org blocked on both sides. The Sefaria phase was run as its own invocation, then `generateSeforimDb -x :sefariasqlite:generateSefariaSqlite`. See `local_workarounds.diff`.
Local builds do not run the GPU Linker, so LINKER links are absent on both sides: v1 has 4,454,493 links vs v40's 7,001,824, while books (8259) and lines (7,925,185) match v40 exactly.
