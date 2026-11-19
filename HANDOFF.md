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

# Issue handoff — #2590 (text-mark link doesn't work in Word)
New branch: fix/text-mark-link-word-limit-2590 · WIP: origin/wip/fix/text-mark-link-word-limit-2590 (26dd7cc69, base 5f3663211). NOTE: an old branch fix/text-mark-link-length-2590 exists (02d936731, old dev, no PR) — do NOT use or reuse that name.
- Mechanism: lib/utils/book_link_builder.dart:83-86 buildTextMarkLink puts the whole selection into m= after Uri.encodeComponent, no length cap; a Hebrew letter becomes 6 chars.
- Word limit: hyperlink anchor/docLocation limited to 255 chars (MS-OI29500). Prefix otzaria://open/book/1234?index=42&m= is 36 chars → ~35 letters already exceed it.
- Second symptom (opens without highlight) — hypothesis, unverified: Word truncates at 255 mid %D7%xx; _queryParametersOf (lib/core/external_uri_router.dart:424) falls back to _decodeLegacyComponent → garbled text → highlight not found. Verify if cheap.
- All paths go through buildTextMarkLink: lib/widgets/misc/direct_link_menu_entries.dart (incl. publisher-limit path :54), shortcut lib/text_book/view/text_book_screen.dart:2823, buildDirectLinkSubmenuEntries. PDF has no text-mark link.
- Not a regression: unlimited since ffcd769f2 (PR #322, 26.5, 0.9.94). Y-PLONI's diagnosis comment on the issue suggested falling back to the section mark.
- WIP test (never run): test/utils/copy_direct_link_test.dart, group buildTextMarkLink: "הקישור לא עובר 255 תווים, מגבלת היפר-קישור בוורד (issue #2590)" — at exactly 255 chars ('abc' + 36×'א') m is kept; at 256 and for a 15-word selection via the menu, link ≤255 and == buildSectionMarkLink(1234, 42).
- WIP fix (never run): if the link > 255 → return buildSectionMarkLink (section highlight). ≈ +4 lib lines.
- OPEN DECISION (report it): fallback is silent (menu still says "הדגשת הטקסט"); alternative = trim m to the first words that fit (highlights only part). Pick the one that best matches the issue thread and say why.
- Related tests: test/utils/copy_direct_link_test.dart, test/core/external_uri_router_test.dart, `grep -rl "book_link_builder\|direct_link_menu_entries" test`.
- Open PR #3036 (mmichaelush) touches external_uri_router.dart; the fix does not.
