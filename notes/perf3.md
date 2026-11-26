# perf3 — TOC navigator: moving the active heading rebuilds every visible TOC row

Measured by perfscout 26.11 on upstream/dev 4fe1973a4. Refs #1692 (never Closes).

## Area / files (upstream/dev)
- `lib/text_book/view/toc_navigator_screen.dart`: the tree BlocBuilder (L629-645) rebuilds when
  `_activeTocIndex(previous) != _activeTocIndex(current)` — i.e. every time reading scroll crosses a heading.
  The builder then rebuilds `_buildVirtualizedTocList` (L557-600) and `_buildTocRow` (L402-) for EVERY visible row,
  although only `selected` (L418-420: `activeIndex == entry.index`) of 2 rows changes. Same for arrow-key
  browsing (`_highlightedEntryIndex` + setState).
- Same pattern as perf1 (in-book search rows); `text_book_search_screen.dart` already moved its selection into a
  ValueNotifier for this reason (comment at L141-142), the TOC never did.

## Measurement (debug flutter_test, `debugOnRebuildDirtyWidget`)
Setup from `test/text_book/view/toc_navigator_screen_test.dart` (`_TestTextBookBloc`, `_loadedState`, `_wrap`,
`_buildLargeToc(simanim: 60, seifim: 10)`, 400x800). After open (`pump`, `pump(500ms)` — NOT pumpAndSettle, and do
not `await bloc.close()` inside testWidgets: both hang), emit `_loadedState(toc, visibleIndices: [2 + k])`, `pump()`,
`pump(300ms)`, 6 runs:
- **1549-1552 builds per active-heading change**, median **~100 ms** (147/138/110/87/100/86 ms). ~43 visible rows x
  ~35 widgets (Material=75, KeyedSubtree=74, Focus=44, InkWell...).
- Expected after: VLB/one listener per row + 2 row subtrees (~100-150 builds) -> ~90% fewer.

## Proposed change (3-6 lines of logic)
Hold the effective selected entry (`_highlightedEntryIndex ?? activeIndex` as already computed) in a
`ValueNotifier<int?>` owned by the State; remove `_activeTocIndex(...)` from the tree `buildWhen` (keep it in the
BlocListener that scrolls to the active item) and set the notifier there instead; in `_buildTocRow` wrap only the
part that depends on `selected` in a listener that returns the same widget instance when this row's selected flag
did not flip (the perf1 trick), or an equivalent minimal select. `_highlightedEntryIndex` updates go to the notifier
instead of setState where they only change the highlight.
Note: `_visibleActiveIndex` maps the active entry to a visible ancestor when its branch is collapsed — keep that
mapping when computing the notifier value (it needs the display data; compute it where the notifier is set).

## Test that fails on dev (commit 1)
In toc_navigator_screen_test.dart (or a new file next to it): with the 60x10 TOC, emit a state whose
`visibleIndices.first` moves to the next seif and count `NavTreeContentRow` (or `_buildTocRow` rows) builds for that
single change: dev = all visible rows (~43); expected after <= 3. Behaviour asserts: exactly one selected row, the
new active one; the existing 38 tests of toc_navigator_screen_test.dart (auto-expand, collapse by user #4433/#4550,
scroll-to-active, holy names) must stay green.

## Risks
- Auto-expansion of the active branch (`_ensureParentsOpen`, `_expandedRevision`) DOES change the flat list — that
  path must still rebuild the tree (it calls setState / changes the flat cache; keep it).
- Search mode (`showFullText`) and arrow-key highlight share `selected`.
- Twin to check (do not widen scope blindly): `alt_toc_sidebar_view.dart` and the PDF outline view probably have the
  same pattern; PDF is out of scope (#5538/#5945). Mention twins in BODY.md, fix only the text TOC.

## Open PRs near this code
- No open PR of anyone touches toc_navigator_screen.dart (avoid list + search 26.11). The perf/toc-* branches of
  the fork are already merged and are about TOC building/filtering, not row rebuilds.
