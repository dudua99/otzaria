# Cloud QA instructions (generic)

Independent QA of one bug-fix branch for the Flutter app Otzaria. Upstream https://github.com/Otzaria/otzaria (branch dev); checkout = fork dudua99/otzaria (origin). The branch was made by a producer agent; verify critically, fix what is wrong, and leave it READY for a non-draft PR — or say NOT READY with reasons.

Hard rules: do NOT open PRs or comment; NEVER force-push or rewrite history — fixes only as NEW commits on top, pushed normally to the same branch; Hebrew commit subjects; no Co-Authored-By / AI attribution; prefer fewer lines; no new bugs.

Setup: `git remote add upstream https://github.com/Otzaria/otzaria && git fetch upstream dev`; `git fetch origin <branch> && git checkout -B qa FETCH_HEAD`; install Flutter 3.47.7 stable (linux tarball from storage.googleapis.com/flutter_infra_release; `git config --global --add safe.directory <dir>`); `flutter pub get`. Read AGENTS.md, CONTRIBUTING*.md; read the issue + comments via `curl -s https://api.github.com/repos/Otzaria/otzaria/issues/<N>` and `/comments` (gh is unauthenticated). RECHECK: closed / maintainer decision / an open PR already fixing it → stop and report. Open PRs: `curl -s 'https://api.github.com/repos/Otzaria/otzaria/pulls?state=open&per_page=100'`.

Check:
1. The reproduction test FAILS on upstream/dev lib (git worktree add ../base upstream/dev, copy the test files there; git stash forbidden) and PASSES on the branch.
2. Root fix, not a wrapper; the claimed root-cause commit is right (git log -S/-p). Could it be done with fewer lines?
3. No regressions: read the diff line by line; think of every caller, setting, view, platform.
4. Related tests (listed in the extra notes + anything importing the touched files): `flutter test -j 1` on branch and on base — exact pass/fail/skip counts for both.
5. `dart analyze` + `dart format --set-exit-if-changed` on touched files clean; if tool/ui_lint exists run it — baseline must not grow.
6. `git merge-tree` vs current upstream/dev clean; for every open PR (`git fetch upstream pull/<n>/head:pr-<n>`) no NEW conflict compared with upstream/dev.
7. If upstream/dev moved and the branch conflicts, merge upstream/dev with a merge commit (Hebrew message).
Push any fix commits: `git push origin HEAD:<branch>`.

FINAL ANSWER (Hebrew): READY / NOT READY + reasons; commits pushed (SHAs); fail-on-base proof; tests branch vs base exact counts; analyze/format/ui_lint; conflicts; open decisions; and the final PR body in plain Hebrew (problem, root cause with commit, fix, "Closes #N" or "Refs #N" if only part is fixed, "## בדיקות" with exact counts, the line `<!-- SUITE -->`, no AI attribution, no "🤖" line). PR title = subject of the fix commit.
