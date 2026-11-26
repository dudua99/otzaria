NOT READY

# Verification: dudua99/otzaria-library `names/uniform-titles-3209`

- Head: `9f6a441d` (5 commits on Otzaria/otzaria-library main)
- BASE: `f4b89786530fd6ecd267c50cd15ca9dfa0786cd6` (merge-base with upstream/main)
- Run date: 2026-11-26. Python 3.12.

## Verdict

**NOT READY.** One blocking error was introduced by the branch:
`ForDB/sefaria_category_changes.csv` record 1243 still points to the old category path. This breaks the unittest step and the name validator on the PR, and it would break the auto-fix on main. A second problem needs a decision: 28 `book_info.csv` identities were renamed by hand with no events in `ForDB/book_info_identity.json`.

The runtime layer (Java/SeforimLibrary) and Step C **could not run here**. The sandbox's network policy blocks `api.adoptium.net` (Java 25), `github.com`/`api.github.com` (the release `seforim.db`, `gh release`), and `www.sefaria.org` (live title list). Those steps say BLOCKED below and are not counted as PASS.

## Step A — the `pull_request` job of validate-fordb-book-names.yml

| # | Step | Branch | upstream/main | Notes |
|---|---|---|---|---|
| A0 | Hydrate validation inputs from LFS | PASS | PASS | |
| A1 | Self-test (`python3 -m unittest` with the 11 modules, 216 tests) | **FAIL** (1 failure) | PASS (216 OK) | `CategoryDescriptionPathsTest.test_the_committed_rows_follow_the_committed_renames`: **introduced by the branch** |
| A2 | `check_author_mirrors.py --base BASE` | PASS (rc 0, warning) | – | "1 new since BASE" is `חידושי הרא״ה על עבודה זרה` ('אהרן הלוי' ≠ 'הרב שלום מאיר יונגרמן'). The same mismatch is on main under the old key `חידושי הראה על עבודה זרה`. It only moved with the rename and is not new. |
| A3 | `validate_fordb_book_names.py --rename-base BASE` (the PR run, `SEFARIA_FETCH=1`) | BLOCKED (rc 2) | BLOCKED | `www.sefaria.org` 403 from the sandbox proxy. Rerun with `SEFARIA_FETCH=0` and with a Sefaria stand-in (below). |
| A3' | same, `SEFARIA_FETCH=0`, report-only and `--rename-base BASE` | **FAIL** (rc 1) | FAIL (rc 1) | Offline mode reports every Sefaria title as "not found" on both sides. Branch vs main diff: only the 20 renamed מהרש"א titles (an artifact of offline mode) **plus the new error `sefaria_category_changes.csv` record 1243**. |
| A3'' | same, with a stand-in Sefaria list (`logs/run_fix_sim.py`) | **FAIL** (rc 1) | **PASS** (rc 0) | The stand-in is every title main's ForDB references that offline mode can't find, plus the 23 new rename sources. Main is fully clean. The branch's only error is record 1243. Rename-follow finds 5 renames, 0 that can't be aligned. |
| A4 | `follow_lock_renames.py --base BASE` (push-only in the workflow, run here as requested) | PASS | – | "0 lock rows followed". `locked_metadata.tsv` **unchanged**. |
| A5 | `check_locked_metadata.py --git-rev HEAD --since BASE` | PASS | – | 113 changed books compared, 6621 locked values OK |
| A6 | `fordb_archive.py build fordb_candidate.zip` | PASS | – | 16 files, sha256 `8fc527cb…` |
| A7 | Install Java 25 Temurin | BLOCKED | – | api.adoptium.net 403. Only JDK 21 is installed, and the build needs `jvmToolchain = 25`. |
| A8 | Clone Otzaria/SeforimLibrary@otzaria | PASS | – | `adb91b28` |
| A9 | Self-test released DB downloads / `select_released_db_tag.sh` / `download_released_fordb_db.sh` | BLOCKED | – | `gh release` needs api.github.com and github.com (403) |
| A10 | `library_tree.py` base/candidate | PASS* | – | *Ran with BASE vs HEAD, because the release `otzaria_target_commit` is in the blocked build_provenance.json. |
| A11 | `./gradlew :sefariasqlite:validateForDbInputs …` | BLOCKED | – | needs Java 25 and the release DB. I expect it to fail too: `parseCategoryDescriptionOverrides` reads record 1243 after the category renames (see the comment in the unittest: "aborts SeedAllMetadata mid-build"). |

Main's A3' fails for the same offline reason. It is an artifact of the blocked Sefaria API, not a fault on main. The real CI on main passes, and A3'' on main gives rc 0.

## Findings

### F1 — BLOCKING (introduced by this branch): a description row on the old category path
`ForDB/sefaria_category_changes.csv` record 1243:
```
"תלמוד בבלי/ראשונים/חדושי הרא״ה","","","חידושי רבנו אהרן הלוי [הרא""ה] על מסכתות כתובות ועבודה זרה.", …
```
Commit `ecf2e555` adds `חדושי הרא״ה,חידושי הרא״ה` to `category_renames.csv` but leaves this row on the old path. The validator says: «הקטגוריה «חדושי הרא״ה» משנה את שמה ל«חידושי הרא״ה»; יש לכתוב את הנתיב בשם החדש — הבנייה תיכשל». **Fix:** change the path to `תלמוד בבלי/ראשונים/חידושי הרא״ה`. After the rename the Sefaria category merges with the KSK folder of the same name, and this is the only description row for it, so the merge should not conflict. The runtime merge check (A11) could not run, so this is not confirmed.

### F2 — needs a decision: no identity-ledger events for 28 renamed `book_info.csv` identities
The branch renames 28 `(bookName, authorName)` identities in `book_info.csv` (23 Sefaria + `תוספות ישנים  על כריתות` + 4 repo books; the list is in `logs/identity_gap.txt`). It adds **no** events to `ForDB/book_info_identity.json`. The auto-fix (Step B) won't add them either: it records events only for rows it renames itself, and here the rows were already renamed. ADDING_BOOKS.md §book_info_identity says the website applies only later events, and that a disappearance with no event needs explicit resolution. The precedent commit `7d1e1d74` (renames for restored gershayim) added rename events 6302–6656 by hand. **Recommendation:** append 28 `rename` events (same `authorName`, `commit` = the commit that made the rename), or confirm it isn't needed.

### F3 — minor/cosmetic
- `ForDB/sefaria_metadata_changes.csv`: two rows still have a path prefix in folder form, `שות/אחרונים/שות שבט סופר` (שבט סופר חלק ב) and `שות/אחרונים/שות תעלומות לב` (תעלומות לב חלק ג). This is pre-existing (the `שות/` prefix was there on main). Column 0 isn't used at runtime (`parseDescriptionOverrides` reads only title/heShortDesc/heDescNew), so there is no effect on the DB.
- `files_manifest.json` still lists the old `_links.json` names that the auto-fix renames. `update-library.yml` (the bot) regenerates the manifest.
- `MoreBooks/.../acronym.json` still has `book_title: "חידושי הראה על עבודה זרה"` (old name). Not a ForDB input.

### Checked and OK
- 133 moves, all R100 (129 folder renames + 4 file renames). Every folder change matches the commit messages (DELTA.md).
- No ForDB row points to an old folder path in `sefaria_category_changes.csv`, `book_moves.csv` or `category_moves.csv` (except F1). Same in `sefaria_metadata_changes.csv` (except F3).
- Lock: `follow_lock_renames` leaves it unchanged, and `check_locked_metadata` passes.
- Each of the 24 new `book_renames.csv` rows has a unique source (1 row) and a unique target, matches exactly one row in main's `book_info.csv` and `sefaria_metadata_changes.csv`, and the target doesn't already exist. Matching against the real DB was **not** checked (BLOCKED).

## Last 40 lines per step

### A1 unittest (branch)
```
/root/w/lib/.github/scripts/check_locked_metadata.py:327: ResourceWarning: unclosed file <_io.BufferedReader name=5>
  lines = read_second_lines(repo, rev, {key for key in keys if key in paths and key in changed})
ResourceWarning: Enable tracemalloc to get the object allocation traceback
ok
test_rewrites_the_lock_and_lists_it_as_touched (test_follow_lock_renames.MainTest.test_rewrites_the_lock_and_lists_it_as_touched) ... 1 lock rows followed (author 1, sefaria_short 0, sefaria_long 0, line2 0)
ok
test_without_a_report_or_base_does_nothing (test_follow_lock_renames.MainTest.test_without_a_report_or_base_does_nothing) ... no fordb_renamed.json and no --base: nothing to follow
ok
test_an_unknown_or_missing_file_fails (test_fordb_archive.ArchiveTest.test_an_unknown_or_missing_file_fails) ... ok
test_same_content_reads_trees_and_ignores_unshipped_files (test_fordb_archive.ArchiveTest.test_same_content_reads_trees_and_ignores_unshipped_files) ... fb34cb4333f080a952952531d94770b498d8f000 and cf57379fafc522a6f3fd44d0c3ab443545f41ae2 ship the same ForDB files
ForDB differs between cf57379fafc522a6f3fd44d0c3ab443545f41ae2 and 10c8cd99d9be7e0aa56a6a0650eabe37330ef47a: ForDB/book_moves.csv
ok
test_ships_exactly_the_consumed_files_in_byte_order (test_fordb_archive.ArchiveTest.test_ships_exactly_the_consumed_files_in_byte_order) ... ok
test_symlinks_are_refused (test_fordb_archive.ArchiveTest.test_symlinks_are_refused) ... ok
test_the_digest_depends_only_on_names_and_bytes (test_fordb_archive.ArchiveTest.test_the_digest_depends_only_on_names_and_bytes) ... ok
test_both_workflows_build_through_this_module (test_fordb_archive.RepositoryArchiveTest.test_both_workflows_build_through_this_module) ... ok
test_the_committed_fordb_folder_is_covered (test_fordb_archive.RepositoryArchiveTest.test_the_committed_fordb_folder_is_covered) ... ok

======================================================================
FAIL: test_the_committed_rows_follow_the_committed_renames (test_validate_fordb_book_names.CategoryDescriptionPathsTest.test_the_committed_rows_follow_the_committed_renames)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/w/lib/.github/scripts/test_validate_fordb_book_names.py", line 320, in test_the_committed_rows_follow_the_committed_renames
    self.assertEqual(
AssertionError: Lists differ: [('רשומה 1243', 'תלמוד בבלי/ראשונים/חדושי [85 chars]דש')] != []

First list contains 1 additional elements.
First extra element 0:
('רשומה 1243', 'תלמוד בבלי/ראשונים/חדושי הרא״ה', 'הקטגוריה «חדושי הרא״ה» משנה את שמה ל«חידושי הרא״ה»; יש לכתוב את הנתיב בשם החדש')

+ []
- [('רשומה 1243',
-   'תלמוד בבלי/ראשונים/חדושי הרא״ה',
-   'הקטגוריה «חדושי הרא״ה» משנה את שמה ל«חידושי הרא״ה»; יש לכתוב את הנתיב בשם '
-   'החדש')]

----------------------------------------------------------------------
Ran 216 tests in 34.605s

FAILED (failures=1)
```

### A1 unittest (main)
```
..........................................................................::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
..............................................................................::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
.::warning::ForDB/title_acronyms.txt חסר; שמות התצוגה לפי ה-<h1> בלבד.
...............................................0 lock rows followed (author 1, sefaria_short 0, sefaria_long 0, line2 0)
.1 lock rows followed (author 0, sefaria_short 0, sefaria_long 0, line2 1)
/root/w/main/.github/scripts/check_locked_metadata.py:327: ResourceWarning: unclosed file <_io.BufferedReader name=5>
  lines = read_second_lines(repo, rev, {key for key in keys if key in paths and key in changed})
ResourceWarning: Enable tracemalloc to get the object allocation traceback
.1 lock rows followed (author 1, sefaria_short 0, sefaria_long 0, line2 0)
.no fordb_renamed.json and no --base: nothing to follow
..b0fa0336645b2eb1d5eb41bcddef43518f613457 and d01b45668fdebeef25178b5e425441aab9bbc97b ship the same ForDB files
ForDB differs between d01b45668fdebeef25178b5e425441aab9bbc97b and 1cdfaab153c087a2652429087df3fc08aba4c63d: ForDB/book_moves.csv
......
----------------------------------------------------------------------
Ran 216 tests in 19.363s

OK
```

### A2 check_author_mirrors
```
::warning file=all_metadata.json,title=Author mirror differs from metadata.json::חידושי הרא״ה על עבודה זרה: 'אהרן הלוי' != 'הרב שלום מאיר יונגרמן'
Author mirror differences (metadata.json is the source): ForDB/all_metadata.json: 63, ForDB/book_info.csv: 31, all_metadata.json: 182, all_metadata_with_file_paths.json: 116
1 new since f4b89786530f
```

### A3 validate (SEFARIA_FETCH=1, report-only)
```
[canonical] 2944 שמות מקבצי ספרים נארזים (PACKAGED_PREFIXES)
[canonical] all_metadata: 5934 ספריא + 1692 אוצריא
::warning::משיכת השמות מספריא נכשלה (<urlopen error Tunnel connection failed: 403 Forbidden (agent proxy: no rule or network setting allows this host)>).
::error::משיכת השמות מספריא נכשלה ו-SEFARIA_FETCH=1 — לא מאמתים מול רשימה חלקית; הריצו שוב.
```

### A3 validate --rename-base (SEFARIA_FETCH=1)
```
[canonical] 2944 שמות מקבצי ספרים נארזים (PACKAGED_PREFIXES)
[canonical] all_metadata: 5934 ספריא + 1692 אוצריא
::warning::משיכת השמות מספריא נכשלה (<urlopen error Tunnel connection failed: 403 Forbidden (agent proxy: no rule or network setting allows this host)>).
::error::משיכת השמות מספריא נכשלה ו-SEFARIA_FETCH=1 — לא מאמתים מול רשימה חלקית; הריצו שוב.
```

### A3' validate --rename-base (SEFARIA_FETCH=0, branch)
```
     - שורה 2829: 'שו"ת במראה הבזק חלק שמיני' (כפי שב-DB: 'שות במראה הבזק חלק שמיני') — לא נמצא
     - שורה 2830: 'שו"ת במראה הבזק חלק שני' (כפי שב-DB: 'שות במראה הבזק חלק שני') — לא נמצא
     - שורה 2831: 'שו"ת במראה הבזק חלק תשיעי' (כפי שב-DB: 'שות במראה הבזק חלק תשיעי') — לא נמצא
     - שורה 2832: 'שו"ת בני בנים' (כפי שב-DB: 'שות בני בנים') — לא נמצא
     - שורה 2837: 'שיג ושיח מהדורה משפחתית' — לא נמצא
     - שורה 2838: 'שיג ושיח; מהדורה עברית' — לא נמצא
     - שורה 2839: 'שיג ושיח; קריאות חדשות בפרשת השבוע, במדבר' — לא נמצא
     - שורה 2840: 'שיג ושיח; קריאות חדשות בפרשת השבוע, בראשית' — לא נמצא
     - שורה 2841: 'שיג ושיח; קריאות חדשות בפרשת השבוע, דברים' — לא נמצא
     - שורה 2842: 'שיג ושיח; קריאות חדשות בפרשת השבוע, ויקרא' — לא נמצא
     - שורה 2843: 'שיג ושיח; קריאות חדשות בפרשת השבוע, שמות' — לא נמצא
     - שורה 2877: 'שיעורים בגמרא - שמיטה' — לא נמצא
     - שורה 2878: 'שיעורים במנהיגות; מהדורה עברית' — לא נמצא
     - שורה 2879: 'שיעורים במנהיגות; קריאות חדשות בפרשת השבוע' — לא נמצא
     - שורה 2880: 'שיעורים ברוחניות; קריאות חדשות בפרשת השבוע' — לא נמצא
     - שורה 2881: 'שלהבות של אמונה' — לא נמצא
     - שורה 2882: 'שמונה קבצים' — לא נמצא
     - שורה 2956: 'שפתי כהן על התורה' — לא נמצא
     - שורה 2958: 'תְּפִלַּת מְנַשֶׁה' (כפי שב-DB: 'תפלת מנשה') — לא נמצא
     - שורה 2959: 'תהילים קנ"א' (כפי שב-DB: 'תהילים קנא') — לא נמצא
     - שורה 2960: 'תהלים קנ"ד' (כפי שב-DB: 'תהלים קנד') — לא נמצא
     - שורה 3094: 'תורת אמך' — לא נמצא
     - שורה 3095: 'תורת ההגיון בהלכה' — לא נמצא
     - שורה 3098: 'תנאי בנישואין ובגט' — לא נמצא
     - שורה 3100: 'תפארת יהונתן על תורה' — לא נמצא
     - שורה 3108: 'תקות אנוש על איוב' — לא נמצא
     - שורה 3114: 'תשובות בעת מלחמה (אנגלית)' — לא נמצא
     - שורה 3116: 'תשובות לקציני דת (אנגלית)' — לא נמצא
     - שורה 4589: 'מהרש"א - חידושי אגדות על ברכות' (כפי שב-DB: 'מהרשא - חידושי אגדות על ברכות') — לא נמצא
     - שורה 4590: 'מהרש"א - חידושי אגדות על נזיר' (כפי שב-DB: 'מהרשא - חידושי אגדות על נזיר') — לא נמצא
     - שורה 5032: 'טעבעלה באנדי על הגדה של פסח' — לא נמצא
     - שורה 5548: 'מהר"ם שיף על עירובין' (כפי שב-DB: 'מהרם שיף על עירובין') — לא נמצא
     - שורה 6423: 'פסקי הרא"ש על נדה' (כפי שב-DB: 'פסקי הראש על נדה') — לא נמצא
     - שורה 6999: 'רד"ק על ישעיהו' (כפי שב-DB: 'רדק על ישעיהו') — לא נמצא


❌ 1 בעיות ב-ForDB/sefaria_category_changes.csv; הבנייה תיכשל:

     - רשומה 1243: 'תלמוד בבלי/ראשונים/חדושי הרא״ה' — הקטגוריה «חדושי הרא״ה» משנה את שמה ל«חידושי הרא״ה»; יש לכתוב את הנתיב בשם החדש

```

### A3' validate (SEFARIA_FETCH=0, main)
```
     - שורה 2824: 'שו"ת במראה הבזק חלק ראשון' (כפי שב-DB: 'שות במראה הבזק חלק ראשון') — לא נמצא
     - שורה 2825: 'שו"ת במראה הבזק חלק רביעי' (כפי שב-DB: 'שות במראה הבזק חלק רביעי') — לא נמצא
     - שורה 2826: 'שו"ת במראה הבזק חלק שביעי' (כפי שב-DB: 'שות במראה הבזק חלק שביעי') — לא נמצא
     - שורה 2827: 'שו"ת במראה הבזק חלק שישי' (כפי שב-DB: 'שות במראה הבזק חלק שישי') — לא נמצא
     - שורה 2828: 'שו"ת במראה הבזק חלק שלישי' (כפי שב-DB: 'שות במראה הבזק חלק שלישי') — לא נמצא
     - שורה 2829: 'שו"ת במראה הבזק חלק שמיני' (כפי שב-DB: 'שות במראה הבזק חלק שמיני') — לא נמצא
     - שורה 2830: 'שו"ת במראה הבזק חלק שני' (כפי שב-DB: 'שות במראה הבזק חלק שני') — לא נמצא
     - שורה 2831: 'שו"ת במראה הבזק חלק תשיעי' (כפי שב-DB: 'שות במראה הבזק חלק תשיעי') — לא נמצא
     - שורה 2832: 'שו"ת בני בנים' (כפי שב-DB: 'שות בני בנים') — לא נמצא
     - שורה 2837: 'שיג ושיח מהדורה משפחתית' — לא נמצא
     - שורה 2838: 'שיג ושיח; מהדורה עברית' — לא נמצא
     - שורה 2839: 'שיג ושיח; קריאות חדשות בפרשת השבוע, במדבר' — לא נמצא
     - שורה 2840: 'שיג ושיח; קריאות חדשות בפרשת השבוע, בראשית' — לא נמצא
     - שורה 2841: 'שיג ושיח; קריאות חדשות בפרשת השבוע, דברים' — לא נמצא
     - שורה 2842: 'שיג ושיח; קריאות חדשות בפרשת השבוע, ויקרא' — לא נמצא
     - שורה 2843: 'שיג ושיח; קריאות חדשות בפרשת השבוע, שמות' — לא נמצא
     - שורה 2877: 'שיעורים בגמרא - שמיטה' — לא נמצא
     - שורה 2878: 'שיעורים במנהיגות; מהדורה עברית' — לא נמצא
     - שורה 2879: 'שיעורים במנהיגות; קריאות חדשות בפרשת השבוע' — לא נמצא
     - שורה 2880: 'שיעורים ברוחניות; קריאות חדשות בפרשת השבוע' — לא נמצא
     - שורה 2881: 'שלהבות של אמונה' — לא נמצא
     - שורה 2882: 'שמונה קבצים' — לא נמצא
     - שורה 2956: 'שפתי כהן על התורה' — לא נמצא
     - שורה 2958: 'תְּפִלַּת מְנַשֶׁה' (כפי שב-DB: 'תפלת מנשה') — לא נמצא
     - שורה 2959: 'תהילים קנ"א' (כפי שב-DB: 'תהילים קנא') — לא נמצא
     - שורה 2960: 'תהלים קנ"ד' (כפי שב-DB: 'תהלים קנד') — לא נמצא
     - שורה 3094: 'תורת אמך' — לא נמצא
     - שורה 3095: 'תורת ההגיון בהלכה' — לא נמצא
     - שורה 3098: 'תנאי בנישואין ובגט' — לא נמצא
     - שורה 3100: 'תפארת יהונתן על תורה' — לא נמצא
     - שורה 3108: 'תקות אנוש על איוב' — לא נמצא
     - שורה 3114: 'תשובות בעת מלחמה (אנגלית)' — לא נמצא
     - שורה 3116: 'תשובות לקציני דת (אנגלית)' — לא נמצא
     - שורה 4589: 'מהרש"א - חידושי אגדות על ברכות' (כפי שב-DB: 'מהרשא - חידושי אגדות על ברכות') — לא נמצא
     - שורה 4590: 'מהרש"א - חידושי אגדות על נזיר' (כפי שב-DB: 'מהרשא - חידושי אגדות על נזיר') — לא נמצא
     - שורה 5032: 'טעבעלה באנדי על הגדה של פסח' — לא נמצא
     - שורה 5548: 'מהר"ם שיף על עירובין' (כפי שב-DB: 'מהרם שיף על עירובין') — לא נמצא
     - שורה 6423: 'פסקי הרא"ש על נדה' (כפי שב-DB: 'פסקי הראש על נדה') — לא נמצא
     - שורה 6999: 'רד"ק על ישעיהו' (כפי שב-DB: 'רדק על ישעיהו') — לא נמצא

```

### A3'' stand-in (branch)
```
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 668
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 669
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 670
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 673
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 675
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 676
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 677
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 680
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 682
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 683
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 685
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 687
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 688
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 691
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 693
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 696
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 700
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 703
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 704
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 705
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 707
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 710
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 712
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 713
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 714
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 716
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 717
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 719
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 720
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 721
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 722
         · MoreBooks/links/שולחן ערוך, יורה דעה_links.json: links_ref רשומה 723
     - 'חידושי הראה על עבודה זרה' → 'חידושי הרא״ה על עבודה זרה'  (ecf2e5556a)  [איות בלבד]
         · KSK/links/חידושי הראה על עבודה זרה_links.json: links_file_renamed KSK/links/חידושי הרא״ה על עבודה זרה_links.json
     - 'חידושי רעא על תלמוד בבלי' → 'חידושי רע״א על תלמוד בבלי'  (9f6a441d6c)  [איות בלבד]

❌ 1 בעיות ב-ForDB/sefaria_category_changes.csv; הבנייה תיכשל:

     - רשומה 1243: 'תלמוד בבלי/ראשונים/חדושי הרא״ה' — הקטגוריה «חדושי הרא״ה» משנה את שמה ל«חידושי הרא״ה»; יש לכתוב את הנתיב בשם החדש

```

### A3'' stand-in (main)
```
[sim] stand-in Sefaria list: 476 titles
[canonical] 2944 שמות מקבצי ספרים נארזים (PACKAGED_PREFIXES)
[canonical] all_metadata: 5934 ספריא + 1692 אוצריא
[canonical] נמשכו 476 שמות חיים מספריא; נוספו 475 חדשים (union)
[canonical] מקור: 9654 | ב-DB: 9303 | סופיים: 9654/9303 (אחרי שינויי שם)

✅ כל שמות הספרים ב-ForDB קיימים ברשימת הספרים הקנונית, מאויתים כפי שייכתבו ל-book.title, אין כפילויות שם בתיקיות הנארזות, ואין דליפת-מקור.
```

### A4 follow_lock_renames
```
0 lock rows followed (author 0, sefaria_short 0, sefaria_long 0, line2 0)
```

### A5 check_locked_metadata
```
line2: 113 changed books compared since f4b89786530f
lock matches: 6621 locked values checked
```

### A6 fordb_archive build
```
fordb_candidate.zip: 16 files
```

### A7/A9/A11 (blocked)
```
$ curl -sSL https://api.adoptium.net/v3/binary/latest/25/ga/linux/x64/jdk/hotspot/normal/eclipse
curl: (56) CONNECT tunnel failed, response 403
$ curl https://github.com/Otzaria/SeforimLibrary/releases   -> 403
$ curl https://api.github.com/repos/Otzaria/SeforimLibrary/releases -> 403
$ curl https://www.sefaria.org/api/index/ -> 403
```
Full logs: `logs/`.
