NOT READY (preliminary — runtime layer still running)

# Verification of dudua99/otzaria-library `names/uniform-titles-3209`

BASE = f4b89786530fd6ecd267c50cd15ca9dfa0786cd6 (merge-base with Otzaria/otzaria-library main)

## Step A (in progress)

| Step | Branch | upstream/main |
|---|---|---|
| Hydrate (LFS) | PASS | PASS |
| unittest list (216 tests) | **FAIL** (1 failure) | PASS |
| check_author_mirrors --base BASE | PASS (warning only) | – |
| validate_fordb_book_names.py (report-only) | see notes | see notes |
| validate_fordb_book_names.py --rename-base BASE | see notes | – |
| follow_lock_renames.py --base BASE | PASS, lock unchanged | – |
| check_locked_metadata.py --git-rev HEAD --since BASE | PASS | – |
| fordb_archive.py build | PASS | – |

## Findings so far

1. `ForDB/sefaria_category_changes.csv` row 1243 still has the path
   `תלמוד בבלי/ראשונים/חדושי הרא״ה`, but `category_renames.csv` now renames
   `חדושי הרא״ה` → `חידושי הרא״ה`. Fails
   `CategoryDescriptionPathsTest.test_the_committed_rows_follow_the_committed_renames`
   and the validator ("הבנייה תיכשל"). Passes on upstream/main → introduced by this branch.
