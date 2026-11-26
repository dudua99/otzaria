# AUTOFIX — what the auto-fix on main will do after merge (Step B), head `b2d4fb3b`

I ran it in a separate worktree of `b2d4fb3b`, **with no commit**:
`validate_fordb_book_names.py --fix --rename-base f4b89786…`, as in the workflow's push step. The Sefaria index came from the pinned export's `table_of_contents.json` (`logs2/run_with_toc.py`; sefaria.org is blocked here). Logs: `logs2/B_*`.

## Result
- **rc 0** (with 9f6a441d it was rc 1 because of F1). The step no longer fails under `set -e`.
- Rename-follow: 5 renames, 0 that can't be aligned (the same as before).
- `fordb_touched.txt` lists exactly the expected links changes. Staged with `git add -A --pathspec-from-file` as in the workflow:
```
R100  KSK/links/חידושי הראה על עבודה זרה_links.json  → KSK/links/חידושי הרא״ה על עבודה זרה_links.json
R100  MoreBooks/links/חוות דעת חדושים_links.json      → MoreBooks/links/חוות דעת חידושים_links.json
M     MoreBooks/links/שולחן ערוך, יורה דעה_links.json  (338 × path_2 "חוות דעת חדושים.txt"→"חוות דעת חידושים.txt", 338 × heRef_2 "חוות דעת חדושים, …"→"חוות דעת חידושים, …")
3 files changed, 676 insertions(+), 676 deletions(-)
```
- No changes to ForDB, metadata.json or `locked_metadata.tsv`. No orphan rows removed.
- Commit message the tool generates:
```
ci(fordb): follow book renames

- חוות דעת חדושים → חוות דעת חידושים (renamed in ecf2e5556a)
- חידושי הראה על עבודה זרה → חידושי הרא״ה על עבודה זרה (renamed in ecf2e5556a)
```

## Identity ledger
- `read_identity_ledger` checks the append-only rule against HEAD, HEAD^ and the base. It accepted the ledger with **no** "historical prefix … changed" error, in report-only, `--fix`, and the trial merge.
- `--fix` **adds no further events**: `book_info_identity.json` isn't in `fordb_touched.txt` and wasn't changed. The tool records events only for book_info rows it renames itself, and the branch already wrote all 28 (6657–6684). Content check: `logs2/B_identity_events_check.txt`.

## Simulating the push to main after the merge
Trial merge of b2d4fb3b into upstream/main `d9325ddb` (local, no conflicts), then `--fix --rename-base d9325ddb`: rc 0, the same 5 renames, and exactly the same `fordb_touched.txt` (`logs2/C_merge_fix_toc.log`).

## Caveat
In the workflow, "Commit and push safe ForDB fixes" runs only after `validateForDbInputs` passes. As long as F4 is open (VERDICT.md), the runtime step fails on main too, and **this commit won't be pushed** (and `update-fordb.yml` won't publish the ForDB). With the workaround in `logs2/F4_candidate_fix.patch`, the runtime step passes. That patch changes only `category_renames.csv`, which doesn't affect the links auto-fix above.
