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

# Issue handoff — #2977 (link-index sync aborts: UNIQUE constraint failed: attached_external_link_target)
New branch: fix/external-link-target-unique-2977 · WIP: origin/wip/fix/external-link-target-unique-2977 (9f352a3c2, base 5f3663211).
- Report: failing statement INSERT INTO attached_external_link_target VALUES (?, ?, ?) with (otzarya-unofficial-books, o, v:32); stack lines match 4fe82a382 (a dev build from mid-October).
- Mechanism on dev: lib/attached_libraries/repository/external_link_repository.dart (~1216-1236): the marking transaction deletes target rows only when !resuming; the final INSERT (~1345) is a plain INSERT outside the try. If target rows exist, a resume keeps them, the final insert throws, and the exception kills the whole _syncIndex.
- Where duplicates come from: DB state left by released 0.9.98+801 (before PR #2044): there the '!building' marker was written in a separate transaction and old target/index rows were deleted only in the first batch; a build interrupted before batch 1 (e.g. after official v31→v32) leaves a building marker WITH the previous complete index's targets and rows. After upgrade, auto-resume at startup (rows>0, autoRows==null) or manual resume starts without delete and hits UNIQUE; each failed attempt adds rows, so it repeats every launch.
- Root-cause commit: 0b6cd232f (YairDaniel11, PR #2044, 7.10) removed c9d3d504d's guard hasTargets ("rows belong to the interrupted build only if the old targets were deleted"), assuming marker+delete are always atomic. c9d and 0b6 landed together.
- Ruled out: duplicate slug in jobs (_resolveDuplicate), duplicate 'o' in _targets(), concurrent runs in one process (_enqueue).
- palmoni5's work on the file (f004c86f1 #4221 catch-only, 0112428d4, 29f2166b2) and yom-chadash 57eb0fb30 don't touch this block.
- WIP test (never run): test/attached_libraries/attached_external_links_test.dart, before "המשך אוטומטי: קריסה (בלי סיומת)…", loop auto/manual: "המשך … מעל אינדקס שהושלם בונה מאפס, בלי כפילות יעדים (issue #2977)": full build of fourPerLine, corrupt row 0 (targetLineIndex=9), mark '!building:'||targetsSignature; expect sync(autoResume:true) returns the slug (or requestResume then sync), snapshot == full build, meta not starting with '!', incompleteSlugs empty. Expected UNIQUE failure on dev.
- WIP fix (never run, ≈ +6): resuming = decision.resume && no rows in _targetTable for the slug — otherwise rebuild from scratch; the skip check (_isCurrentOrMarked) uses decision.resume; the auto=N suffix is written only when really resuming (!resuming || autoRows==null ? ''). Chosen over deleting targets only, because the old rows (resolved against v31) would be served as v32. Restores the intent of c9d's guard.
- Must still pass: "המשך אוטומטי" group (incl. "בלי התקדמות לא ממשיך"), "requestResume ממשיך מהנקודה השמורה", "בנייה שנקטעה — מסומנת כלא שלמה" (sync() without autoResume still skips). Run all of test/attached_libraries/.
