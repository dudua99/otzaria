# Cloud finish instructions (generic)

You are finishing a bug fix for the Flutter app Otzaria. Upstream: https://github.com/Otzaria/otzaria (branch dev). Your checkout is the fork dudua99/otzaria (remote origin). A local agent started the work and stopped because the PC ran out of memory; its handoff notes are in the section "Issue handoff" below — VERIFY everything, nothing there was run with flutter unless it says so.

Hard rules:
- Do NOT open PRs, do NOT comment on GitHub, NEVER force-push, never rewrite pushed history. Don't modify the wip/* branch except to read it.
- No Co-Authored-By, no AI attribution anywhere (commits, PR body).
- Commit messages and the PR body in Hebrew.
- Prefer fixes that REMOVE lines; add only what is needed; never create new bugs; root fix, not a wrapper.

Setup:
1. `git remote add upstream https://github.com/Otzaria/otzaria && git fetch upstream dev`
2. Install Flutter 3.47.7 stable (linux tarball from storage.googleapis.com/flutter_infra_release; `git config --global --add safe.directory <flutter dir>`), then `flutter pub get` (no skip_build needed in the cloud; Rust is preinstalled for the build hooks).
3. Read AGENTS.md and CONTRIBUTING*.md. Read the issue + all comments via REST: `curl -s https://api.github.com/repos/Otzaria/otzaria/issues/<N>` and `/comments` (gh is unauthenticated; GraphQL blocked). RECHECK: if the issue is closed, or a maintainer says fixed/rejected/in an open PR, stop and report. List open PRs: `curl -s 'https://api.github.com/repos/Otzaria/otzaria/pulls?state=open&per_page=100'`.

Work:
a. Check out the wip branch; take its test and lib changes as a starting point.
b. Build a NEW branch named as given below from upstream/dev with exactly 2 commits: (1) test only — subject "בדיקת אימות: … (issue #N)" — and prove it FAILS on upstream/dev lib; (2) the fix — subject "תיקון issue #N — <short Hebrew>" with the root-cause commit in the body. Prove the test passes after commit 2.
c. History: confirm the root-cause commit with `git log -S` / `-p`.
d. No regressions: run the related test files listed in the handoff (and anything importing the touched files) with `flutter test -j 1`, on the branch AND on upstream/dev (use `git worktree add ../base upstream/dev`; git stash is forbidden). Report exact pass/fail/skip counts for both.
e. `dart analyze` + `dart format --set-exit-if-changed` on touched files must be clean. If tool/ui_lint exists, run it — the baseline must not grow.
f. Conflicts: for every open PR, `git fetch upstream pull/<num>/head:pr-<num>` and verify with `git merge-tree` that your branch adds no NEW conflict compared with upstream/dev.
g. If the change is visual, produce before/after PNGs with a temporary golden/widget-test capture and commit NOTHING of it; instead describe them (sizes, bbox of the difference). Also say if a local visual check is advisable.
h. `git push origin <new branch>`.

FINAL ANSWER (Hebrew):
## סטטוס — READY / NOT READY + reason
## ענף — name + 2 SHAs
## בדיקה חוזרת
## מנגנון ושורש
## תיקון — net lib lines
## בדיקות — branch vs dev exact counts; fail-on-dev proof; analyze/format/ui_lint
## התנגשויות
## החלטות פתוחות — anything a maintainer must decide
## גוף PR — ready body in plain Hebrew: what was broken, root cause with commit, the fix, "Closes #N", "## בדיקות" with exact counts, the line `<!-- SUITE -->`, no AI attribution.

# Issue handoff — #4512 (import links for a book whose title has gershayim, e.g. רי"ף שבת) — also covers closed duplicate #5533
New branch: fix/import-links-gershayim-title-4512 · WIP: origin/wip/fix/import-links-gershayim-title-4512 (bbf0749f9, base 8eb1d8808).
- #5533 adds: even when file name and content use ״ (U+05F4) the book isn't found because the DB title uses ". PR #5532 (ambiguity check in the same importer) was CLOSED by Y-PLONI because a new check blocked unrelated imports — never add a new error/exception path in ingest.
- Mechanism: native import takes the base book name from the file name as-is (user_content_importer.dart:244-251) and target from path_2 as-is; lookup is exact only: _locateIn → _bookByTitle → getBookByTitle (user_link_ref_resolver.dart:96-105, 144-170) = selectByTitle WHERE title = ?. Windows file names can't contain ", so links for רי"ף שבת are never found; ״/׳ vs "/' also fail. Exact match since the feature was added (CSV 65db26bd2, native 3b41a37af, palmoni5) — not a regression; surfaced with the DB titles containing ".
- Twins: <book>.links.csv / .links.json also take the book from the file name (bookTitleFromFile). Not included: headings <book>.כותרות.csv (personal library only, names from file names, no ").
- WIP fix (≈ +113/−31 lib, never compiled): reuse existing normalizeBookTitle (lib/library/models/library.dart:235: strips " ' ״ ׳, double spaces, <>). user_link_ref_resolver.dart: LocatedUserLinkBook gets field title (DB title); _locateIn: when exact match finds nothing in any DB, look for a loose match (_titlesLike via selectAllLocalBooksSlim) — succeeds only if exactly ONE matching title across personal+official, else null (as dev), no new exception. New AttachedLinkBooks.locateLoose(title); existing locate stays exact (CSV path and versions import keep the raw title). user_content_importer.dart: inner locate → static _locateLinkBook; priority exact personal/official → exact attached → loose personal/official → loose attached (everything dev finds stays identical); link records store source.title/target.title from the DB (else dead links); _ingestLinks for .links.csv/.json replaces the file-name title with the DB title via _locateLinkBook, any exception keeps the raw title (as dev); new locateBook parameter on 3 _ingestLinks calls. test/user_content_import/user_content_importer_test.dart: added title: title to 6 fake LocatedUserLinkBook records.
- PREFER a smaller fix if possible (e.g. normalised comparison inside one lookup used only by the native/links ingest path) — the WIP is large; report net lines.
- WIP test (never run): new group at end of test/user_content_import/user_link_ref_resolver_test.dart "כותרת עם גרשיים ושם קובץ בלעדיהם (issue #4512)" on real DBs: (a) 'ריף שבת_links.json' and 'רי״ף שבת_links.json' vs official רי"ף שבת; (b) path_2 'רש״י על שבת' vs DB 'רש"י על שבת'; (c) רי"ף שבת in an attached DB; (d) 'ריף שבת.links.csv' with מקור_אישי=לא. Uses only dev API → should compile and fail on dev.
- Add guard tests (pass on dev too): exact title in attached DB + similar spelling in official → attached still wins; two spellings normalising to the same key → "not found" as dev; loose title in both personal and official → null without exception, import continues to attached.
- Verify compile: `final SeforimRepository? officialRepository;` assigned inside try with an always-rethrowing catch.
- MEASURE: a miss now loads all DB titles (~8,000 official) once per missing title per file, no cache. Measurement test ready in the WIP description (copy temporarily). Risk: personal-folder link sync re-runs failed files every scan with a new userLinkResolversFor per file — if slow, cache per userLinkResolversFor / AttachedLinkBooks (not global, would go stale).
- Traps: do NOT put loose matching into _bookByTitle or AttachedLinkBooks.locate (CSV, versions import, resolveRef keep raw titles → dead links). Any ingest error blocks all import-library actions (_changeAndRebuild in user_import_library.dart:206-222 rebuilds all saved files).
- Related tests: all test/user_content_import/ (user_link_ref_resolver_test, user_content_importer_test, import_lookup_cache_test, user_sidecar_sync / user_import_library tests) + `grep -rl "user_link_ref_resolver\|user_content_importer" test`.
- #5220 (related, NOT in this branch): needs a maintainer decision (store line count at scan vs read file at import); don't implement.
