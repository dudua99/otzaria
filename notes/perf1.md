# perf1 — in-book search (TEXT): "next/previous result" rebuilds every visible result row

Measured by perfscout 26.11 on upstream/dev 4fe1973a4. Refs #1692 (never Closes).

## Area / files (upstream/dev)
- `lib/text_book/view/text_book_search_screen.dart` ~L1168-1195: every result row is
  `NavTreeGroupCard > ValueListenableBuilder<int?>(valueListenable: _selectedResult, builder: ... => NavTreeContentRow(isSelected: ...))`.
  `_selectedResult` (L143) is ONE notifier shared by all rows, so each next/prev press (and each tap on a result)
  rebuilds the whole `NavTreeContentRow` subtree (InkWell, Material, Focus, Actions, ... ~22 widgets) of EVERY visible
  row, although only the old and the new selected row change.

## Measurement (debug flutter_test, `debugOnRebuildDirtyWidget` counter, existing harness)
Harness: `test/perf/design_system_hot_paths_perf_test.dart`, record `search_next_result_x20`
(`flutter test test/perf/design_system_hot_paths_perf_test.dart --plain-name search_results`, 5 runs inside).
- Before (dev): **16143 builds** for 20 presses (stable in all runs); median 464.9 / 500.9 / 487.3 ms (3 invocations of 5 runs).
- One press broken down: 649 builds on the first frame = 30 `ValueListenableBuilder<int?>` x full row subtree
  (`NavTreeContentRow`=29, `InkWell`=31, `Material`=31, `Focus`=32 ...).
- Prototype of the change below: **3850 builds** (-76%), median 361.3 ms (-26%); one press 689 -> 176 builds.

## Proposed change (3-6 lines)
Rows must not rebuild their subtree unless THEIR selected flag flips. Minimal prototype that was measured:
declare `NavTreeContentRow? row; bool? rowSelected;` just before `return NavTreeGroupCard(` and in the
`ValueListenableBuilder` builder compute `isSelected`; if `row != null && rowSelected == isSelected` return the same
`row` instance (Flutter skips identical widgets), else build and remember it. (The prototype diff is ~+9 lines net;
if you find a smaller/cleaner equivalent — e.g. a tiny private "select" listenable widget — prefer it, but keep it
local to this file.) Nothing else changes: `_buildSearchResultNavigationBar` keeps its own listener.

## Test that fails on dev (commit 1)
Widget test next to the existing in-book search tests (reuse the harness setup of `search_results` in
test/perf/design_system_hot_paths_perf_test.dart: StubTextBookBloc + StubSettingsBloc + `TextBookSearchView` with
`simpleSearchRunner` returning 200 results, width 400 x 900). After the first settle, press 'התוצאה הבאה' 3 times,
then count `NavTreeContentRow` builds with `debugOnRebuildDirtyWidget` for ONE press + `pump()`:
dev = 29 (all visible rows); expected after = 2 (old + new). Assert `<= 3`. Also assert the selected row is the
new one (behaviour unchanged): exactly one `NavTreeContentRow` with `isSelected == true` and it is the 5th result.
Optionally record the x20 number in BODY.md (before/after from the perf harness above).

## Risks
- The cached `row` captures `onTap` with `resultListIndex` — same values as before (they come from the itemBuilder
  scope, which is rebuilt whenever the results or settings change, so the cache dies with it). Keep it that way:
  do NOT hoist the cache into State fields.
- `child: child!` (the RichText) is unchanged; RichText was already built once per row (VLB child).
- Keyboard/arrow navigation and tap-to-select must keep highlighting the right row (covered by existing tests in
  test/text_book/view/*search* — run them).

## Open PRs near this code
- #6087 (dudua99, own) edits this file at L453-640 only — no overlap with L1135-1195.
- Not touched by #2788/#3036/#5740/#5945 (checked 26.11).
