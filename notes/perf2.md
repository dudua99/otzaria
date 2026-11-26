# perf2 — text reader: selecting a line rebuilds EVERY visible reader item

Measured by perfscout 26.11 on upstream/dev 4fe1973a4. Refs #1692 (never Closes).

## Area / files (upstream/dev)
- `lib/text_book/utils/reader_build_policy.dart` `shouldRebuildReader` (L16-33): the reader BlocBuilder
  (`combined_book_screen.dart` L2087-2089, `buildWhen: shouldRebuildReader`) rebuilds on `selectedIndex` /
  `selectedIndices` change (correct: the selection must be shown).
- But then `ScrollablePositionedList.builder(... itemBuilder: (context, index) => wrapReaderItem(... buildExpansiomTile(index, state, ...)))`
  (`combined_book_screen.dart` ~L2478-2490) creates NEW widgets for every visible item, so the full subtree of every
  line (SmartTextWidget, PluginCorrectionParagraph, SelectionFillText, ContextMenuRegion, gesture detectors,
  BlocBuilder/BlocListener<SettingsBloc> ...) is rebuilt on each click, although only the item(s) that contain the
  old or the new selected line change (`selectedLines` / `isSelected` in `buildExpansiomTile` ~L2711-2720).
- Existing helper that already describes "everything except selection": `shouldRebuildIgnoringSelection`
  (reader_build_policy.dart L37-50).

## Measurement (debug flutter_test, `debugOnRebuildDirtyWidget`)
Harness: the `reader_scroll` setup of `test/perf/design_system_hot_paths_perf_test.dart` (400 nikud lines,
1400x900, `TextBookViewerBloc`), with `EmittingStubTextBookBloc` instead of `StubTextBookBloc`; after open + 500 ms,
`bloc.emitState(state.copyWith(selectedIndex: i))`, `pump()`, `pump(300ms)`, 6 runs:
- **1498 builds per selection** (1503 first), median **~110 ms** (134/114/123/107/97/97 ms). For comparison opening
  the whole book = 3143 builds. ~37 visible items x ~40 widgets = ~98% of the builds.
- Expected after: only the 1-2 affected items (~80-100 builds), i.e. >90% fewer builds per click/arrow key.
- Control: a `visibleIndices`-only emit (scroll) costs 1 build — the scroll path is already fine.

## Proposed change (3-6 lines of logic)
Per-item widget cache in `_CombinedViewState`: keep the `Widget` returned for each item index together with the
item's `selectedLines` set (and `commentaryAfter`). In the itemBuilder, if the previous reader state differs from
the current one only by selection (`!shouldRebuildIgnoringSelection(prev, curr)`) and this item's selected lines
are unchanged, return the cached instance (Flutter skips identical widgets); otherwise build and store. Clear the
cache when `shouldRebuildIgnoringSelection` is true, in `didUpdateWidget`, and in `didChangeDependencies`
(theme / MediaQuery). Prefer net-small code; reuse `shouldRebuildIgnoringSelection`, do not add a new policy.

## Test that fails on dev (commit 1)
Widget test (copy the reader setup of the perf harness, smaller: ~100 lines): after open, emit a new
`selectedIndex` and count builds of `SmartTextWidget` (or `PluginCorrectionParagraph`) for that one change:
dev = every visible line (~37); expected after <= 2. Plus behaviour asserts: the new line shows the selection gutter
/ background and the old one no longer does (existing tests in test/text_book/view/selection/* and
combined_view/* must stay green).

## Risks (read before implementing)
- Inputs of an item besides selection: `state` fields (handled by shouldRebuildIgnoringSelection), widget props
  (`textSize`, `showCommentaryAsExpansionTiles`, ... -> clear in didUpdateWidget), Theme/MediaQuery (-> clear in
  didChangeDependencies), State fields read at build time (e.g. `_selectionPointerLineIndex`, search highlight,
  note map, plugin highlight revision). Audit every field `buildExpansiomTile` reads at BUILD time (not inside
  callbacks); any such field changing with setState must clear the cache. If this audit gets large, STOP and write
  NOT READY with the list — do not ship a stale-render bug for speed.
- Multi-line paragraph items (segments with several source lines): selection inside the same item changes the
  item -> must rebuild (key the cache by `selectedLines`, not by a bool).
- Selected-line commentary-as-expansion-tiles (`commentaryAfter`) depends on selection -> part of the key.

## Open PRs near this code
- `combined_book_screen.dart`: #2788 (Bshlomecha) hunks at L1326-1961 and L2691-2793 (start of
  buildExpansiomTile); #3036 (mmichaelush) hunks at L1060, L1450-1575, L3080. The itemBuilder (~L2478) and new
  State fields do not overlap them — keep the change out of L2691-2793. Check `git merge-tree` against both.
- `reader_build_policy.dart`: no open PR (checked 26.11).
