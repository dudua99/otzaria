# combined delta 2711 — progress (2026-11-27T10:17:16Z)

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
Info: (DatabaseGenerator) books 1225/2814 (43.5%) · lines 1.8M · toc 358.0K · elapsed 56:41 · eta ~1:13:32
Info: (DatabaseGenerator) books 1255/2814 (44.5%) · lines 1.8M · toc 362.7K · elapsed 57:43 · eta ~1:11:41
Info: (IdAllocator) Category key 'שו״ת/אחרונים/משיב דבר' now holds 1483 (was unset)
Info: (DatabaseGenerator) books 1286/2814 (45.7%) · lines 1.9M · toc 366.8K · elapsed 58:44 · eta ~1:09:46
Info: (DatabaseGenerator) Book 7119 'עין יצחק חלק א': 1000/5649 lines (17%)
Info: (DatabaseGenerator) Book 7119 'עין יצחק חלק א': 2000/5649 lines (35%)
Info: (DatabaseGenerator) Book 7119 'עין יצחק חלק א': 3000/5649 lines (53%)
Info: (DatabaseGenerator) Book 7119 'עין יצחק חלק א': 4000/5649 lines (70%)
Info: (DatabaseGenerator) Book 7119 'עין יצחק חלק א': 5000/5649 lines (88%)
Info: (DatabaseGenerator) books 1313/2814 (46.6%) · lines 1.9M · toc 372.5K · elapsed 59:45 · eta ~1:08:17
Info: (DatabaseGenerator) books 1351/2814 (48.0%) · lines 1.9M · toc 377.0K · elapsed 1:00:46 · eta ~1:05:48
Info: (DatabaseGenerator) books 1383/2814 (49.1%) · lines 2.0M · toc 380.7K · elapsed 1:01:47 · eta ~1:03:56
Info: (IdAllocator) Category key 'שו״ת/אחרונים/שות מהרשם' now holds 1472 (was unset)
Info: (DatabaseGenerator) books 1418/2814 (50.3%) · lines 2.0M · toc 385.0K · elapsed 1:02:51 · eta ~1:01:51
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 3000/21920 lines (13%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 6000/21920 lines (27%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 9000/21920 lines (41%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 12000/21920 lines (54%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 15000/21920 lines (68%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 18000/21920 lines (82%)
Info: (DatabaseGenerator) Book 7245 'שו״ת פרי עץ חיים': 21000/21920 lines (95%)
Info: (DatabaseGenerator) books 1430/2814 (50.8%) · lines 2.1M · toc 387.0K · elapsed 1:03:51 · eta ~1:01:47
Info: (DatabaseGenerator) books 1457/2814 (51.7%) · lines 2.1M · toc 389.9K · elapsed 1:04:51 · eta ~1:00:24
Info: (DatabaseGenerator) books 1487/2814 (52.8%) · lines 2.1M · toc 394.4K · elapsed 1:05:53 · eta ~58:47
Info: (DatabaseGenerator) books 1500/2814 (53.3%) · lines 2.2M · toc 397.2K · elapsed 1:06:55 · eta ~58:37
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6505        1708          12        8320        9581
/dev/vda        252G   38G   32G  54% /
 10:17:16 up  2:06,  0 user,  load average: 1.23, 1.11, 1.10
```
