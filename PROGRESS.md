# combined delta 2711 — progress (2026-11-27T11:17:20Z)

## markers
```
2026-11-27T08:15:21Z v1 START sefaria phase fordb=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10 code=c5e28010
2026-11-27T09:06:48Z v1 DONE sefaria; snapshot
2026-11-27T09:07:00Z v1 START rest
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
## tail of v1.rest.log
```
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 1000/8457 lines (11%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 2000/8457 lines (23%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 3000/8457 lines (35%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 4000/8457 lines (47%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 5000/8457 lines (59%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 6000/8457 lines (70%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 7000/8457 lines (82%)
Info: (DatabaseGenerator) Book 8136 'כלי יקר על נביאים': 8000/8457 lines (94%)
Info: (DatabaseGenerator) books 2326/2814 (82.6%) · lines 4.1M · toc 814.0K · elapsed 2:05:50 · eta ~26:24
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 1000/6050 lines (16%)
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 2000/6050 lines (33%)
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 3000/6050 lines (49%)
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 4000/6050 lines (66%)
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 5000/6050 lines (82%)
Info: (DatabaseGenerator) Book 8148 'עזרה להבין': 6000/6050 lines (99%)
Info: (DatabaseGenerator) books 2363/2814 (83.9%) · lines 4.1M · toc 821.1K · elapsed 2:06:51 · eta ~24:12
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 1000/8158 lines (12%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 2000/8158 lines (24%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 3000/8158 lines (36%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 4000/8158 lines (49%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 5000/8158 lines (61%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 6000/8158 lines (73%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 7000/8158 lines (85%)
Info: (DatabaseGenerator) Book 8210 'ליקוטי חבר בן חיים ה': 8000/8158 lines (98%)
Info: (DatabaseGenerator) books 2392/2814 (85.0%) · lines 4.1M · toc 823.1K · elapsed 2:07:54 · eta ~22:33
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6933        1708          12        7892        9154
/dev/vda        252G   39G   30G  57% /
 11:17:20 up  3:06,  0 user,  load average: 1.14, 1.14, 1.10
```
