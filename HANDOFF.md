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

# Issue handoff — #5537 (search history inside the search dialog)
New branch to create: fix/search-history-menu-options-5537 · WIP: origin/wip/fix/search-history-menu-options-5537 (072723fac, base 8eb1d8808). Visual change → before/after capture needed (light + dark).

- Reporter: in the dialog's history menu the words are hard to find among option markers (prefixes, full/defective spelling…); wants markers smaller/different colour.
- Mechanism: lib/search/view/search_history_menu.dart:159 shows Text(entry.ref). The history screen already splits words vs options via _searchTitleSpan (lib/history/view/history_screen.dart:69, using buildSearchTitleSegments in history_bloc.dart:81): options at fontSize 13, not bold, primary colour.
- Not a regression: list added in 2fd607d3e (06.11.2025), moved to SearchHistoryMenu in e3b978bf8 (mmichaelush 17.11); 81a9d5682 (Y-PLONI 24.07, in 0.9.95) added rich title only to the history screen. Use 81a9d5682 as "missed by" in the fix body.
- Only two places render search history (.isSearch grep); plugin_bridge only returns data.
- WIP fix: moved _searchTitleSpan as public searchTitleSpan into search_history_menu.dart (after _kMaxListHeight, imports history_bloc.dart); history_screen.dart imports it, private copy deleted; menu row: Text.rich(searchTitleSpan(context, entry) ?? TextSpan(text: entry.ref), …) — maxLines/overflow/style/Tooltip unchanged. Net lib ≈ +3.
- WIP test: test/search/search_history_menu_test.dart "…כמו בחלון ההיסטוריה (issue #5537)": main async with tryInitSearchEngine, skip: !engineReady; Bookmark with searchOptions {'שלום_0': {'קידומות דקדוקיות': true}}; expects segments ['(קד)','שלום',' + ','עולם'], '(קד)' fontSize 13 + primary colour, 'שלום' no style, tooltip = full ref. Expected to fail on dev (Text(data) → textSpan null). NEVER RUN.
- TRAP: buildSearchTitleSegments splits words via the Rust engine (splitQueryWords) — without an initialised engine the test is SKIPPED and proves nothing. Make sure the engine (otzaria_search_engine ^7.2.0) builds and initialises in the test; report if the test was skipped.
- Existing menu tests don't need the engine (entries without searchOptions return null early). find.text works with Text.rich (toPlainText) — verify existing tests (e.g. long-query maxLines) still pass.
- Out of scope, don't touch: onSelect in search_dialog.dart (~805) always restores options per-word without globalOptionsFromPerWord (that is issue #4067).
- Related tests: test/search/search_history_menu_test.dart, test/history/view/history_screen_test.dart, test/history/build_search_title_segments_test.dart, and `grep -rl "search_history_menu\|SearchHistoryMenu" test`.
- Open PRs checked: mmichaelush #5396, #3036 (135 files), #2726 — none touch these files; palmoni5 #5249 touches only search_dialog.dart.
