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

# Issue handoff — #2450 (text too close to the scrollbar rail; selecting near the edge grabs the rail)
New branch: fix/reader-rail-gap-2450 · WIP: origin/wip/fix/reader-rail-gap-2450 (a505d0c12, base 8eb1d8808). VISUAL change → before/after capture required (F18), and a local UI check is advisable afterwards.
- Mechanism: ScrollablePositionedListScrollbar is a Row: 12px rail at the start edge (right in RTL), fully tappable; list in Expanded. In the normal reader buildOuterList (lib/text_book/view/combined_view/combined_book_screen.dart:2581-2587) pads end: trackWidth (centering) + _selectionGutter (8px each side, :325-330) → only 8px between text and the rail's hit area at full width, also in preview (_buildPreviewList :2461). With constrained width the gap is ≥24px (kTextColumnMinMargin=16).
- Twin: page shape — same 8px: lib/text_book/view/page_shape/simple_text_viewer.dart:362 _readerListPadding = EdgeInsets.all(4) + 4 inside the item (:3354); there it is not a regression (since the rail was added, bf8bd1ecb).
- Root cause (regression): fa565b66a (palmoni5, 30.08, issues #1035/#1036) removed a SizedBox(width:16) at the start (rail side) of each row to centre text → 0px; 087a9ad1b (#2554) added the 8px; 2031dac38 (#1791) moved trackWidth into list padding. Keep the deliberate symmetric margins.
- WIP fix (+11/-9 lib): combined view _selectionGutter = EdgeInsets.symmetric(horizontal: kTextColumnMinMargin) (16 each side, centering kept); both marker gutter: args → kSelectionGutterWidth (so the marker stays next to the text, not the rail); affects preview too. Page shape: _readerListPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 4) + _markerGutter = 4.0 in both gutter: args → text 16px from the rail.
- WIP tests (never run): new test/text_book/view/reader_rail_gap_test.dart, 6 cases (normal full width without and with pinned AdaptiveSidePane; constrained 500; narrow 2000 with pane; preview; page shape SimpleTextViewer): a tap 12px from the line start towards the rail near its bottom doesn't change position.pixels; trackKey↔text distance ≥ kTextColumnMinMargin; tapping the rail itself still navigates. Expected to fail on dev at full width, preview, page shape; pass in the constrained cases. Updated combined_view_text_margins_test.dart helper lineInsets to subtract kTextColumnMinMargin instead of kSelectionGutterWidth; removed unused selection_gutter_painter import.
- Traps: don't enlarge the marker gutter together with the padding; ScrollablePositionedList padding takes EdgeInsets only (not Directional); width changes to judge: preview text −16px (palmoni5 deliberately removed double padding there in fa565b66a), constrained narrow column −16px, page-shape columns −16px — decide per case, a narrower alternative is to apply the gap only on the rail side / not touch preview. The test's tap relies on the thumb being at the top (tap near rail bottom); ensure a tap in the padding doesn't select a line or scroll.
- Related tests: reader_rail_gap_test.dart; test/text_book/view/combined_view/ (combined_view_text_margins_test, continuous_commentary_split_test (line width up to 2*kSelectionGutterWidth), preview_mode_scrollbar_test); test/text_book/view/page_shape/ (page_shape_text_width_test, page_shape_narrow_width_test, page_shape_layout_characterization_test, simple_text_viewer_test); test/text_book/view/widgets/selection_gutter_painter_test.dart; test/widgets/scrollable_positioned_list_scrollbar_test.dart; test/design_system/ui_lint_test.dart.
- Open PRs #3036 (>100 files) and #2788 touch both lib files → merge-tree carefully.
