# perfscout — find (and only describe) up to 3 MEASURED performance wins for milestone 0.9.99 (26.11)

Why: the owner approved performance work on 26.11. The mandate comes from issue #1692 (milestone 0.9.99), where Y-PLONI asked:
"תתמקד על יעילות!!! כל חישוב קטן שאתה מצליח לבטל, כל widget שלא נהרס לחינם — זה שיפור שהמשתמש ירגיש". Full text: notes/perf-2611-input.md.

This unit is a SCOUT: it measures and writes notes for the next workers. It does NOT implement and does NOT push a fix branch.

## Out of scope (owned by others — do not touch)
- PDF (lib/pdf_book/**, pdfrx): #5538 (palmoni5, yom-chadash) and draft #5945.
- Page shape / צורת הדף and startup slowness: #3156, #4326 (palmoni5).
- Smart / semantic search ranking (Y-PLONI), the plugin bridge `plugin_bridge_adapter.dart` (file split is abaye123's DD-30 work), TextBookRepository (#3442/#3985).
- Any `[תקיעה]` / `[קריסה]` report issue (palmoni5).
- Hunks that open PRs of other people change: notes/perf-avoid-files.md (#3036 and #5740 are very wide; only avoid their hunks).

## In scope (examples, choose by measurement)
Text book reader (scrolling, line selection, commentary side panel refresh), library browser (tree open/filter), tabs/workspace switching, settings screens, in-book search in TEXT books, notes/bookmarks lists.

## How to measure (cloud, no device)
- Widget tests that count builds (a counting wrapper / `debugOnRebuildDirtyWidget`-style hook, or a spy in the bloc listener) for one user action; or `Stopwatch` loops over realistic fixture data in `flutter test`.
- A candidate is valid only if: the number is reproducible (median of ≥5 runs), the waste is clear (e.g. whole list rebuilt on every selection change, the same DB/JSON work repeated per frame or per line, an O(n²) loop), and the fix can delete or narrow code (owner prefers net-negative lines).
- Reject micro-wins under ~20% of the measured action or anything that changes behavior/UI.

## Output
For each accepted candidate k (1..3), on the `cloud-notes` branch (fetch, commit on top, push normally; if rejected re-fetch and retry; never force):
- `notes/perf<k>.md`: area, files+lines on upstream/dev, the measurement (method, before numbers), the proposed change in 3–6 lines, the test that will fail on dev (threshold) and pass after, risks, and which open PRs touch nearby code.
- A QUEUE.md line inserted right AFTER the `perfscout` line: `perf<k> perf   (measured: <one-line number>; notes/perf<k>.md)`.
Then write `prbody/perfscout-fix` (orphan) with VERDICT.md whose FIRST LINE is exactly `SCOUT DONE` (not READY — there is nothing to QA) and a table of all candidates looked at, accepted and rejected, with numbers.

Workers implementing a `perf<k>` item: commit 1 = the measuring test that fails on dev; commit 2 = the change; BODY.md in Hebrew with before/after numbers and net lib/ line count; "Refs #1692" (never Closes).
