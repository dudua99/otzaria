# Cloud FIX instructions (generic)

Fix one bug of the Flutter app Otzaria from scratch. Upstream: https://github.com/Otzaria/otzaria (branch dev). Your checkout is the fork dudua99/otzaria (remote origin). Issue-specific notes: `git show FETCH_HEAD:notes/<N>.md` (same branch as this file) — VERIFY them.

Hard rules: do NOT open PRs or comment on GitHub; NEVER force-push; no Co-Authored-By / AI attribution anywhere; Hebrew commit messages and PR body; root fix, not a wrapper; PREFER removing lines, add only what's needed, never create new bugs.

Setup: `git remote add upstream https://github.com/Otzaria/otzaria && git fetch upstream dev`; `git checkout -b <branch> upstream/dev` (branch name: `fix/<short-english-slug>-<N>`); install Flutter 3.47.7 stable (linux tarball from storage.googleapis.com/flutter_infra_release; `git config --global --add safe.directory <dir>`); `flutter pub get`. Read AGENTS.md and CONTRIBUTING*.md.
Reading GitHub: the REST API for Otzaria/otzaria is blocked in this session — use `gh api -X GET search/issues -f q='repo:Otzaria/otzaria is:issue <N>'` (works) and `gh api repos/Otzaria/otzaria/issues/<N>/comments` if it works, else the public page. RECHECK: if the issue is closed, or a maintainer said fixed / rejected / handled in an open PR, or an open PR already fixes it (`gh api -X GET search/issues -f q='repo:Otzaria/otzaria is:pr is:open <N>'` and list open PRs) — stop and report.

Procedure (mandatory):
1. Reproduce for real: a test through the real code path that FAILS on upstream/dev. Commit 1 = test only, subject "בדיקת אימות: … (issue #N)".
2. History: `git log -S` / `-p`; assume a regression first; exact commit and why it broke.
3. Commit 2 = root fix, subject "תיקון issue #N — <short Hebrew>", root-cause commit in the body. Twins: same faulty pattern elsewhere.
4. No regressions: neighbouring behaviour unchanged; related tests (and anything importing the touched files) with `flutter test -j 1` on the branch AND on base (`git worktree add ../base upstream/dev`; git stash forbidden) — exact pass/fail/skip counts for both.
5. `dart analyze` + `dart format --set-exit-if-changed` on touched files clean; `dart tool/ui_lint_cli.dart` — no new violations.
6. Conflicts: for every open PR `git fetch upstream pull/<n>/head:pr-<n>`; `git merge-tree` must show no NEW conflict compared with upstream/dev.
7. Exactly 2 commits over upstream/dev; `git push origin <branch>`.
8. Visual change → temporary widget-test capture before/after (not committed), describe differences; say if a local visual check is advisable.

If it is not a code bug, already fixed, needs reporter info, or needs a maintainer decision you cannot reasonably infer from the thread — do not push; explain with evidence.

OUTPUT: push an orphan branch `prbody/<N>-fix` with two files: BODY.md (final PR body in plain Hebrew: what was broken, root cause with commit, fix, "Closes #N" or "Refs #N" if only part is fixed, "## בדיקות" with exact counts, the line `<!-- SUITE -->`, no AI attribution, no "🤖") and VERDICT.md (first line `READY` or `NOT READY`, then ≤25 Hebrew lines: reason, branch name + head SHA, PR title = fix commit subject, tests branch vs base, conflicts, open decisions, visual check advice). Example: `git checkout --orphan prbody/<N>-fix && git rm -rf -q . && cp /tmp/BODY.md /tmp/VERDICT.md . && git add BODY.md VERDICT.md && git commit -qm body && git push origin HEAD:prbody/<N>-fix`.


GIT IDENTITY (mandatory, before any commit): commits must be authored by the fork owner, not "Claude". Run: `git config user.name "dudua99"; git config user.email "$(git log -1 --format=%ae --author=dudua99 origin/dev 2>/dev/null || git log -1 --format=%ae --author=dudua99 --all)"` and check `git config user.email` is not empty and not noreply@anthropic.com. Never add Co-Authored-By.
