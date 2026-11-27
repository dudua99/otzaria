# combined delta 2711 — progress (2026-11-27T14:47:35Z)

## markers
```
2026-11-27T08:15:21Z v1 START sefaria phase fordb=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10 code=c5e28010
2026-11-27T09:06:48Z v1 DONE sefaria; snapshot
2026-11-27T09:07:00Z v1 START rest
2026-11-27T11:59:24Z v1 DONE build -> /work/db/v1.db
2026-11-27T11:59:35Z PIPE waiting for /work/v2b/READY
2026-11-27T11:59:38Z v2b START sefaria phase fordb=b5ceef29ee3f84c6682846d4f76e1bc7d53b689c606d06b2ea3b430d3dbf9a35 code=1ed6179a
2026-11-27T12:49:59Z v2b DONE sefaria; snapshot
2026-11-27T12:50:05Z v2b START rest
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
- 11:59Z v1 DONE (Sefaria 51 min, rest 2h52m). v1.db 10.3 GB. v2b build started.
- v1 sanity: books 8259 / lines 7925185 = v40 library_stats exactly; links 4,454,493 vs v40 7,001,824 — the LINKER (GPU relink) links are not produced by a local build; identical on every local build, so they cancel in the deltas.
- 12:50Z v2b Sefaria phase done (50 min). Early check: Sefaria link 1064034 (שבת קמא:, טז ↔ חידושי רמב"ן קמא:, ב) gone, new link 4454494 (שבת קמא:, כח → same Ramban line), link_range rows Shabbat↔Ramban 4→5 (#4023 as expected).
## tail of v2b.rest.log
```
Info: (DatabaseGenerator) Book 8013 'קובץ שיטות קמאי על בכורות': 16000/17069 lines (93%)
Info: (DatabaseGenerator) books 2195/2814 (78.0%) · lines 3.9M · toc 759.2K · elapsed 1:52:54 · eta ~31:50
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 4000/31364 lines (12%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 8000/31364 lines (25%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 12000/31364 lines (38%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 16000/31364 lines (51%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 20000/31364 lines (63%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 24000/31364 lines (76%)
Info: (DatabaseGenerator) Book 8014 'קובץ שיטות קמאי על חולין': 28000/31364 lines (89%)
Info: (DatabaseGenerator) books 2196/2814 (78.0%) · lines 3.9M · toc 774.1K · elapsed 1:53:59 · eta ~32:04
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 1000/6261 lines (15%)
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 2000/6261 lines (31%)
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 3000/6261 lines (47%)
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 4000/6261 lines (63%)
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 5000/6261 lines (79%)
Info: (DatabaseGenerator) Book 8015 'קובץ שיטות קמאי על כריתות': 6000/6261 lines (95%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 4000/35105 lines (11%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 8000/35105 lines (22%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 12000/35105 lines (34%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 16000/35105 lines (45%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 20000/35105 lines (56%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 24000/35105 lines (68%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 28000/35105 lines (79%)
Info: (DatabaseGenerator) Book 8017 'קובץ שיטות קמאי על מנחות': 32000/35105 lines (91%)
Info: (DatabaseGenerator) books 2199/2814 (78.1%) · lines 4.0M · toc 792.7K · elapsed 1:55:21 · eta ~32:15
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        7172        1757          12        7618        8914
/dev/vda        252G   62G  7.5G  90% /
 14:47:35 up  6:37,  0 user,  load average: 1.08, 1.11, 1.09
```
