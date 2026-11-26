# AUTOFIX — what the auto-fix on main will do after merge (Step B)

Ran in a separate worktree of the branch head (`9f6a441d`), **without commit**:
`validate_fordb_book_names.py --fix --rename-base f4b89786…`, exactly as in the workflow's push step.

## Run status
- With `SEFARIA_FETCH=1` (as in the workflow): rc 2, `www.sefaria.org` is blocked here (403). The tool exits before any write, as designed. Nothing changed.
- With `SEFARIA_FETCH=0`: rc 2. The tool refuses `--fix` without the live list (by design).
- **Simulation** (`logs/run_fix_sim.py`): `fetch_sefaria_titles` is replaced by a stand-in list. The stand-in is every title that main's ForDB references and offline mode can't find (main's real CI accepts them with live Sefaria), plus the 23 sources of the new book_renames rows. With this list, main is clean (rc 0). The run below is on the branch.

## Files the auto-fix touches (`fordb_touched.txt`)
```
KSK/links/חידושי הראה על עבודה זרה_links.json            → renamed (R100) to  KSK/links/חידושי הרא״ה על עבודה זרה_links.json
MoreBooks/links/חוות דעת חדושים_links.json               → renamed (R100) to  MoreBooks/links/חוות דעת חידושים_links.json
MoreBooks/links/שולחן ערוך, יורה דעה_links.json          → modified: 338 × path_2 "חוות דעת חדושים.txt"→"חוות דעת חידושים.txt"
                                                            + 338 × heRef_2 "חוות דעת חדושים, …"→"חוות דעת חידושים, …"
```
`git diff --stat`: 3 files (2 renames with no content change, 1 file with 676 changed lines), plus the tool's outputs (`fordb_touched.txt`, `fordb_renamed.json`, `fordb_commit_message.txt`, which aren't committed).

Commit message the tool generates:
```
ci(fordb): follow book renames

- חוות דעת חדושים → חוות דעת חידושים (renamed in ecf2e5556a)
- חידושי הראה על עבודה זרה → חידושי הרא״ה על עבודה זרה (renamed in ecf2e5556a)
```

Rename-follow reports 5 renames with 0 that can't be aligned: `חדושי הרי מיגאש על בבא מציעא`, `חדושי רעא על תלמוד בבלי` (two steps: ecf2e555 + 9f6a441d), `חוות דעת חדושים`, and `חידושי הראה על עבודה זרה`. The two Dicta books have no `_links.json` files, so they have no links changes. After the fix, no `_links.json` in the repo references any of the old names. **No ForDB, metadata.json or locked_metadata.tsv changes, and no orphan rows removed.** That matches the expectation: links files renamed, and path_2/heRef_2 references rewritten.

## Caveats
1. **This run ends with rc 1** because of F1 (`sefaria_category_changes.csv` record 1243). In the real workflow, the step fails under `set -e`, the job stops, and the "Commit and push safe ForDB fixes" step **won't run**. So if the branch is merged as is, the links files will **not** be renamed on main until F1 is fixed. Fix F1 before merging.
2. The auto-fix adds no events to `ForDB/book_info_identity.json`. Events are recorded only for book_info rows the tool renames itself, and the branch already renamed them by hand (see F2 in VERDICT.md).
3. `files_manifest.json` will still show the old links file names until the next `update-library.yml` run.
