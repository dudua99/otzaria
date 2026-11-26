NOT READY

# Re-verification: dudua99/otzaria-library `names/uniform-titles-3209` @ `b2d4fb3b`

- Head: `b2d4fb3b2f6fde6a77ea698a3c186fcf14ed8ad4` (7 commits on Otzaria/otzaria-library main). The new commits are `1916669d` (F1 fix) and `b2d4fb3b` (F2 fix and two path rows in sefaria_metadata_changes.csv).
- BASE: `f4b89786530fd6ecd267c50cd15ca9dfa0786cd6` (merge-base). upstream/main is now `d9325ddb` (5 commits ahead of BASE). A trial merge into it has no conflicts (`logs2/C_trial_merge_upstream_main.log`).
- Run date: 2026-11-26. Python 3.12.3 (the same as the workflow). Oracle JDK 25.0.5.1. SeforimLibrary `otzaria` @ `adb91b28`.
- Report for the previous head `9f6a441d`: in this branch's history (commit `7a522cc`), logs in `logs/`. Logs for this run are in `logs2/`.

## Verdict

**NOT READY.** F1 and F2 are fixed, and every Python step of the PR job now passes. The runtime layer ran in full for the first time, and it **fails on the branch while it passes on upstream/main**:

`./gradlew :sefariasqlite:validateForDbInputs` against release v40 stops with "ForDB validation FAILED: 7 rule(s) cannot apply". When those 7 are worked around, it stops again with `sefaria_category_changes.csv record 624 references missing category 'תלמוד בבלי/אחרונים/ליקוטי מהרי״ל/סדר נשים'`. The cause is the same in both cases (F4 below). The branch renames 11 repo folders (`git mv`, as ForDB/README.md says). The ForDB rows now point to the new folder names, but the released DB still has the old names, and the dry-run has no rule that renames them. This step is part of the PR's `validate` job, so the PR check would be red. `update-fordb.yml` gates ForDB publication with the same task, so after a merge the new ForDB would not be published either.

A tested workaround: 11 rows in `category_renames.csv` (`logs2/F4_candidate_fix.patch`). With it, all layers pass: unittest 216/216, validator rc 0, and Gradle BUILD SUCCESSFUL. Read F4 before applying it.

## Steps: the `pull_request` job of validate-fordb-book-names.yml on `b2d4fb3b`

| # | Step | Branch | upstream/main | Notes |
|---|---|---|---|---|
| A0 | Hydrate validation inputs from LFS | PASS | PASS | |
| A1 | Self-test, unittest with the 11 modules | **PASS** (216/216 OK) | PASS (216, previous run) | F1 test `CategoryDescriptionPathsTest` now passes |
| A2 | `check_author_mirrors.py --base BASE` | PASS (rc 0, 1 warning) | – | The same "1 new since BASE" (`חידושי הרא״ה על עבודה זרה`) as before. It moved with the rename and is not new (see the previous report). |
| A3 | `validate_fordb_book_names.py --rename-base BASE`, live `SEFARIA_FETCH=1` | BLOCKED (rc 2) | – | `www.sefaria.org` returns 403 from the sandbox proxy (`logs2/A3_validate_fetch1.log`) |
| A3' | same, with the Sefaria index from the **pinned export's `table_of_contents.json`** (`logs2/run_with_toc.py`), report-only and `--rename-base BASE` | **PASS** (rc 0 / rc 0) | – | Export `2026-11-23_10-32-45139177019-1` (the one v40 was built from): release_metadata sha256 `dedbf438…` = the provenance value, archive `1226ae7c…` OK, TOC `05f7d137…` = the export manifest. 6610 titles. Rename-follow: 5 renames, 0 that can't be aligned. No errors. |
| A4 | `follow_lock_renames.py --base BASE` (push-only, run as requested) | PASS | – | 0 lock rows followed. `locked_metadata.tsv` unchanged. |
| A5 | `check_locked_metadata.py --git-rev HEAD --since BASE` | PASS | – | 113 changed books, 6621 locked values OK |
| A6 | `fordb_archive.py build fordb_candidate.zip` | PASS | PASS | 16 files, sha256 `611553f1…f9a7`. `book_info_identity.json` is NOT_SHIPPED (by design). |
| A7 | Java 25 | PASS* | – | *Oracle JDK 25.0.5.1 instead of Temurin (api.adoptium.net is blocked) |
| A8 | Clone Otzaria/SeforimLibrary@otzaria | PASS | – | `adb91b28` |
| A9a | Self-test released DB downloads (`test_download_released_fordb_db.py`) | PASS | – | 19 tests OK |
| A9b | `select_released_db_tag.sh` + `download_released_fordb_db.sh` | PASS* | – | *By hand: `gh`/api.github.com are blocked. Tag v40-20261123094345 as instructed. Downloaded with curl from github.com/.../releases/download. Each asset's sha256 = the value in `build_provenance.json` (the API digest is unreachable). Schema 7 → `seforim-schema7.db.zst`. The manifest passed the script's jq contract, then `assemble_split_asset.sh`, then `unzstd --long=31`. Same layout: `seforim.db`, `seforim.db.buildstate`, `build_provenance.json` (`logs2/A9_db_download.log`). |
| A10 | `library_tree.py` for `otzaria_target_commit` and HEAD | PASS | PASS | BASE_COMMIT = `28976848e5b0…` (from build_provenance.json, an ancestor of HEAD): 2900 files. HEAD: 2909. main: 2917. |
| A11 | `./gradlew :sefariasqlite:validateForDbInputs` (the workflow's -P arguments) | **FAIL** (rc 1) | **PASS** (BUILD SUCCESSFUL) | See F4. Log: `logs2/A11_gradle_validateForDbInputs.log`. main: `logs2/A11_main_gradle_validateForDbInputs.log`. The first attempt with no changes failed earlier, on the Android plugin from dl.google.com (`logs2/A11_gradle_attempt1_unmodified.log`). |
| B | `--fix --rename-base BASE` in a scratch worktree (see AUTOFIX.md) | **PASS** (rc 0) | – | Only the expected links changes. The identity ledger is accepted, and `--fix` adds no events. |

### Environment deviations (A7/A11)
- Oracle JDK 25.0.5.1 (download.oracle.com) instead of Temurin.
- dl.google.com is blocked. I did what the other run did (branch `prbody/uniform-titles-3209-delta`, "Environment deviations"): I removed the Android plugin, the `android {}` block and `androidMain` from `build.gradle.kts`, `core` and `dao`, and replaced the compileOnly `compose.runtime` (`@Stable`) with a local stub. The full diff is in `logs2/A11_seforim-tool_local_android_strip.patch`. No JVM code changed, and main and the branch ran on the same build.
- `-Dorg.gradle.jvmargs=-Xmx2g -Pkotlin.daemon.jvmargs=-Xmx3g -PgeneratorHeap=10g --max-workers=2` (15 GB machine; 10g is the default generator heap). `LANG=C.UTF-8` so that the Hebrew in the log is readable.

## Findings

### F1 — fixed ✔
`1916669d`: record 1243 (`תלמוד בבלי/ראשונים/חידושי הרא״ה`) now uses the new path. A1 passes, and A3' has no error. In the runtime check with the workaround from F4, the category rename `חדושי הרא״ה → חידושי הרא״ה` (id=357) applied and SeedAllMetadata accepted the row, with no merge conflict.

### F2 — fixed ✔
`b2d4fb3b` adds events 6657–6684 (28 `rename` events). Checked against git (`logs2/B_identity_events_check.txt`):
- the 28 identities that disappeared from `book_info.csv` between BASE and HEAD each match exactly one event, and each of the 28 new identities is in HEAD;
- authorName doesn't change in any event;
- each event's `commit` is in the BASE..HEAD range, and it is exactly the commit where the old identity disappears and the new one appears;
- ids are contiguous 1..6684, and the BASE prefix (6656 events) is unchanged. upstream/main has no new events since BASE, so no ids collide.

### F4 — BLOCKING (in the branch since `ea836afd`/`ecf2e555`, not found before because A11 couldn't run): runtime dry-run against v40 fails on 11 renamed repo folders
The branch renames repo folders with `git mv` and changes the ForDB rows that point to them to the new name. That is what ForDB/README.md asks for ("שם של תיקייה מהמאגר… שורות `sefaria_category_changes.csv` ויעדי `book_moves.csv` עוברים לנתיב החדש באותו קומיט"). But `validateForDbInputs` applies ForDB to the **released** DB, where these categories still have their old names, and nothing renames them:
1. `book_moves.csv` (7 errors). In v40 the books are already in the old folder. That folder is neither the source nor the new destination, so the move fails with `source … matched 0`:
   `שו"ת מהרש"ם חלק א/ב/ג` → `שו״ת/אחרונים/שו״ת מהרש״ם` (in the DB: `שות מהרשם`, id 1472). `ספר ההגיון`, `ספר המליצה`, `דרך ה'`, `מאמר העיקרים` → `מחשבת ישראל/אחרונים/רמח״ל` (in the DB: `רמחל`, id 1476).
2. `sefaria_category_changes.csv`. `planCategoryDescriptionOverrides` stops at the first missing path (record 624, `…/ליקוטי מהרי״ל/סדר נשים`). In total, 16 rows changed by the branch point to a path that doesn't exist in v40 (`logs2/F4_unresolved_paths.txt`). Their leaf names: `ליקוטי מהריל`, `רמחל`, `ראש`, `מביט`, `מהרם שיק`, `מהרש`, `שות מהרשם`, `שות תעלומות לב`, `תשובות הראם`, `חידושי המהריט`, `גליוני השס` (×2).

On upstream/main the same task passes against the same DB (`… already applied` for these 7 moves).

**Tested workaround** (`logs2/F4_candidate_fix.patch`): add 11 rows to `ForDB/category_renames.csv`, `<old name>,<new name>`, one for each name above. In v40 each old name appears exactly once (`גליוני השס` twice, and both are renamed), so the name-based rename hits only the intended folders. With the patch, on top of b2d4fb3b: unittest 216/216, validator (pinned TOC) rc 0, `validateForDbInputs` BUILD SUCCESSFUL. The log shows the 12 categories renamed by their ids, and the moves "already applied" (`logs2/F4_try_*.log`). In a fresh build these rows find nothing, which is only an info message ("not found; no rows changed"). Two points need a decision:
- These rows become dead after the next release (the repo history shows commits that delete rules that "לא תפסו כלום": 2f2c047c, 9a143199). They are probably needed only until the next release.
- `ראש,רא״ש` and `מהרש,מהר״ש` are short names. If a category with that name ever comes from Sefaria, it will be renamed too. Today each appears only once in the DB.

The alternative is to change the dry-run validator (SeforimLibrary) so that it derives renames of repo folders from base.tree/candidate.tree. That is outside this repo.

Not verified: that a full fresh build passes **without** the workaround. I expect it to, because the Otzaria categories are created from the new folder names. That is the build the other run is doing, and its report is still IN PROGRESS.

### F3 — minor (still there)
- `sefaria_metadata_changes.csv`: `b2d4fb3b` changed the leaf (`שו״ת שבט סופר`, `שו״ת תעלומות לב`), but the prefix is still `שות/אחרונים/…`. Column 0 isn't read at runtime, so there is no effect.
- `files_manifest.json` and the `book_title` in `acronym.json`: as in the previous report.

## Last lines per step

### A1
```
Ran 216 tests in 20.864s

OK
```
### A2
```
::warning file=all_metadata.json,title=Author mirror differs from metadata.json::חידושי הרא״ה על עבודה זרה: 'אהרן הלוי' != 'הרב שלום מאיר יונגרמן'
Author mirror differences (metadata.json is the source): ForDB/all_metadata.json: 63, ForDB/book_info.csv: 31, all_metadata.json: 182, all_metadata_with_file_paths.json: 116
1 new since f4b89786530f
```
### A3 (live) / A3' (pinned TOC, --rename-base)
```
::error::משיכת השמות מספריא נכשלה ו-SEFARIA_FETCH=1 — לא מאמתים מול רשימה חלקית; הריצו שוב.
---
[toc] Sefaria index from pinned export table_of_contents.json: 6610 titles
[canonical] נמשכו 6610 שמות חיים מספריא; נוספו 687 חדשים (union)
[canonical] מקור: 9862 | ב-DB: 9511 | סופיים: 9862/9511 (אחרי שינויי שם)
[renames] בסיס f4b89786530f..HEAD: 134 שינויי קבצי .txt, 5 שינויי-שם ליישור, 0 שלא ניתן ליישר
✅ כל שמות הספרים ב-ForDB קיימים ברשימת הספרים הקנונית, מאויתים כפי שייכתבו ל-book.title, אין כפילויות שם בתיקיות הנארזות, ואין דליפת-מקור.
```
### A4 / A5 / A6
```
0 lock rows followed (author 0, sefaria_short 0, sefaria_long 0, line2 0)
line2: 113 changed books compared since f4b89786530f
lock matches: 6621 locked values checked
fordb_candidate.zip: 16 files   611553f117f404124a7f4754c6b6531f8faf628121d3c2fad522ca1b8289f9a7
```
### A11 (branch)
```
Error: (ValidateForDbInputs) [book_moves.csv] 'שו"ת מהרש"ם חלק א': 'שו״ת/אחרונים' -> 'שו״ת/אחרונים/שו״ת מהרש״ם': Book move 'שו"ת מהרש"ם חלק א' has 1 candidate(s); source 'שו״ת/אחרונים' matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'שו"ת מהרש"ם חלק ב': … matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'שו"ת מהרש"ם חלק ג': … matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'ספר ההגיון': 'מחשבת ישראל/אחרונים' -> 'מחשבת ישראל/אחרונים/רמח״ל': … matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'ספר המליצה': … matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'דרך ה'': … matched 0
Error: (ValidateForDbInputs) [book_moves.csv] 'מאמר העיקרים': … matched 0
Error: (ValidateForDbInputs) ForDB validation FAILED: 7 rule(s) cannot apply against /root/w2/dbdir/seforim.db. Fix the rows above (nothing was modified, nothing may be auto-deleted).
BUILD FAILED
```
### A11 (branch + only the 2 rows for מהרשם/רמחל: the next error; that run's log was overwritten by the full run, so this is an excerpt from the transcript)
```
Exception in thread "main" java.lang.IllegalArgumentException: sefaria_category_changes.csv record 624 references missing category 'תלמוד בבלי/אחרונים/ליקוטי מהרי״ל/סדר נשים'
	at …SeedAllMetadataPostProcessKt.planCategoryDescriptionOverrides(SeedAllMetadataPostProcess.kt:290)
```
### A11 (upstream/main d9325ddb) / (branch + the 11-row workaround)
```
BUILD SUCCESSFUL in 1m 24s
---
BUILD SUCCESSFUL in 1m 16s
```
