# Work queue (top = next). One line per item: <issue> <kind> [note]
# kind: feature = FEATURE in milestone 0.9.99 (implement per notes/<N>.md); feature-default = maintainers undecided, implement the DEFAULT option written in notes/<N>.md and say so clearly in BODY.md
# bug = regular bug fix (FIX.md flow) per notes/<N>.md
5040b bug   (verification only: does engine 7.5.3 (#97) reclaim index space? notes/5040b.md)
3640c bug   (rework of closed #5706: gesture-scoped DOM answer per the maintainer review; notes/3640c.md)
6081 bug   (verify first: portable install stores an absolute library path; notes/6081.md)
3170 feature
4919 feature
4993 feature   (reproduce first which list is missing; if not reproducible -> NOT READY with evidence)
5501 feature   (previous PR #5528 was closed: must not throw when there is no WorkspaceBloc)
4274 feature
4663 feature
4452 feature
2838 feature
4713 feature
3699 feature
2541 feature
3722 feature
5271 feature
5203 feature
5127 feature
5040 feature   (measure first, as palmoni5 asked)
3492 feature   (one PR together with #4665)
4490 feature   (tests only)
4308 feature
4231 feature
2306 feature
2720 feature
4287 feature   (reproduce first; may be library data -> NOT READY with evidence)
2737 feature
2435 feature
5502 feature-default
4455 feature-default
4016 feature-default
3797 feature-default
2537 feature-default
4229 feature-default
1478 feature-default
5290 feature-default
5495 feature-default
5296 feature-default
4466 feature-default
4891 feature-default
4389 feature-default
4394 feature-default
3160 feature-default
2835 feature-default
4345 feature-default
2840 bug
5220 bug   (palmoni5: only if cheap - measure cost; do NOT write book.totalLines)
3491 bug   (touchpad fling in PDF; verify regression b3e7a1c5a)
2091 bug
5303 bug   (reproduce first with real Berakhot 2a lines; if not reproducible -> NOT READY with evidence)
5607 feature-default   (confirm the grey is preview selection first)
1979 feature-default
5185 feature-default
5594 bug   (reproduce first: scrollbar-drag drift; if proportional -> NOT READY with numbers)
5638 feature-default   (arrow tuning only; PageUp/Down already in 0b07a7b88)
5715 bug   (regression 41f93430e: notes highlighted but not counted)
5714 bug   (Word/ODT import only: allowBookLinks for otzaria:// links; rest out of scope)
5711 bug   (reproduce first: debounce echo overwrites newer keystrokes; if not reproducible -> NOT READY with evidence)
5712 feature-default
5747 bug   (reproduce first: tap at line end in RtlTextField; suspect hard-break workaround c4a623e72)
5745 bug   (verify on dev first: 4a1dd70c8 moved link text to source; if all 4 cases pass -> NOT READY)
5744 bug   (palmoni5: fix root + retry button; avoid #3442 matcher overlap)
5742 bug
5728 feature-default
2691 feature-default   (part 1 only: official shelves first; part 2 done in #5624)
5759 bug   (engine budget is index-wide, separate repo: fix banner wording in-app + engine proposal in BODY, Refs)
5757 bug   (reproduce first: first highlight is a partial quote; if not reproducible -> NOT READY with evidence)
5758 feature-default
5761 feature-default   (changes ypl's c4a227ecd: keep "…" expand, only add scroll)
5766 feature-default
5796 bug   (commentators tab: nav + zoom shortcuts missing in handleCommentatorsTabShortcuts; answer Rivka-Or with the failing test)
5772 bug   (vertical tab column never scrolls to the active tab; ReadingTabStrip)
5798 bug   (reproduce first: commentators-tab position after restart/History; 7a8ff8fa9 #2139 may cover it -> NOT READY with evidence)
5840 bug   (reproduce first with windows platform override: restored query not selected in regular mode; if all paths select -> NOT READY with evidence)
5819 feature-default   (read-only "fixed shortcuts" card in settings, as palmoni5 suggested; no behavior change)
5794 feature-default   (location in commentators-tab top-bar title; reuse bookmark ref wording)
5810 feature-default   (remember commentators-TAB selection per book; scope pending Y-PLONI - say so in BODY)
5790 feature-default   (zoomed PDF: Left/Right pan until the edge, then turn page; palmoni5 thought it already works - show failing test)
5727 bug   (page-shape category save: base name "תוספות" startsWith-matches תוספות רא"ש; prefer exact base-name match; read palmoni5 comment first)
5904 bug   (reproduce first: prev-segment arrow selection cleared by combined_book_screen _onScroll stale visibleIndices; 9c79c5f14)
5905 feature-default   (select the target segment after opening from itur, as palmoni5 instructed; notes/5905.md)
5743 bug   (reproduce first in code: main window steals focus back after tab move; Windows-only -> NOT READY with evidence if not provable)
5924 bug   (history subtitle shows raw book facet key id:N; resolve via ScopeTree like search_scope_menu _categoryFacetName)
5925 bug   (reuse _KeepSelectionOnWindowBlurFocusNode from 33eae9ca0 in commentary/links/page-shape SelectionAreas)
4317 bug   (app self-update fails when installed in a Hebrew path C:\אוצריא — reproduce in the launcher/argument code; notes/4317.md)
4966 bug   (PgUp/PgDn in search results — notes/replies-2511.md)
4645 bug   (Android SD card free space measured on internal storage — notes/replies-2511.md)
2457 bug   (restored window bounds cover the taskbar — clamp to work area; notes/replies-2511.md)
3048 bug   (itur from plugin window: previous query not selected — second bug only; notes/replies-2511.md)
3975 bug   (reproduce first: touchpad scroll sticks then jumps; NOT READY with evidence if unprovable; notes/replies-2511.md)
6022 bug   (arrow next/prev section starts from tab.index (top line) instead of selectedIndex; regression 9c79c5f14; keep #5904 tests green)
6024 bug   (export dialog: move "בחר פורמט לייצוא" below the holy-names card, next to the buttons; layout only)
6062 bug   (Android: tools panel requestFocus opens keyboard; gate like shouldAutofocusLibrarySearch c222d5ac7)
6048 bug   (reproduce first: Shift+Down after one-line mouse selection drops it; if pure Flutter -> NOT READY with evidence)
6001 bug   (itur from a plugin while typing in the plugin: caret not in the itur box; #3759 path misses WebView-owned text focus — reproduce first; notes/6001.md)
3657 bug   (reproduce first: unpin textMaxWidth 700 in commentary_card_nested_scroll_test:465 → 7px restore drift at full width; if only test measurement -> NOT READY with numbers; notes/3657.md)
3975b bug   (narrow: touchpad vertical scroll loses first ~20px per gesture in TabSwipeDetector arena; option א; Refs not Closes; keep #3048/#3972 green; notes/3975b.md)
3599 bug   (commentary panel: drop the book name already in the group header from item titles, as Y-PLONI's diagnosis says; keep copy text full; notes/3599.md)
4231b bug   (author link matches the joined "X, Y" author string exactly; match per author + one link per author; merged #5674 left this; notes/4231b.md)
4490b bug   (tests only: DbReadWorkerBusy in re-download/reset/update flows — user message, retry, latency; section 3 not covered by #5662; notes/4490b.md)
4135 bug   (in-book search: engine route returns 0 for the book while the local highlights show hits; fall back to the local literal scan when the engine finds nothing; notes/4135.md)
4497 bug   (PDF outline filter: "ב." matches every title with ב and "קיא."/"קיא:" become equal; rank exact/prefix first and keep the amud mark; notes/4497.md)
5989 bug   (CommentaryNotesSection text not selectable (no SelectionArea); add it + Ctrl+C tests for hover/side note; notes/5989.md)
5212 bug   (verify first: Flutter Windows reports NumLock-off keypad as numpad8 etc.; map to arrows/home/end in reader handlers; notes/5212.md)
5463 bug   (reproduce first with a real Bereshit line: header on a separate line lost in the HTML flavor (OneNote); if HTML identical to Gemara -> NOT READY with evidence; notes/5463.md)
2467 bug   (approved by Y-PLONI, assigned Rivka-Or - check her open PRs first; call retirePreviousSemanticGeneration (engine 7.5.3) after a good non-fallback open; notes/2467.md)
5983 bug   (HebrewBooks dialog closed mid-download -> finished file silently dropped: !mounted return before saveFileWithExtension; notes/5983.md)
5991 bug   (reproduce first: itur "עז ב"/"בב פג" ranking vs complete acronym; if DB lacks the acronym -> NOT READY, DATA; notes/5991.md)
6066 bug   (assigned palmoni5, owner one-time approval 26.11: offline mode must also cut plugin network — evaluatePluginNetworkAccess + resolvePluginNetworkPolicy ignore keyOfflineMode; app update check already gated; notes/6066.md)
