# combined delta 2711 — progress (2026-11-27T09:47:14Z)

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
Info: (DatabaseGenerator) Book 6401 'גנזי יוסף': 3000/6127 lines (48%)
Info: (DatabaseGenerator) Book 6401 'גנזי יוסף': 4000/6127 lines (65%)
Info: (DatabaseGenerator) Book 6401 'גנזי יוסף': 5000/6127 lines (81%)
Info: (DatabaseGenerator) Book 6401 'גנזי יוסף': 6000/6127 lines (97%)
Info: (DatabaseGenerator) Book 6418 'חק לישראל - בראשית': 1000/5523 lines (18%)
Info: (DatabaseGenerator) Book 6418 'חק לישראל - בראשית': 2000/5523 lines (36%)
Info: (DatabaseGenerator) Book 6418 'חק לישראל - בראשית': 3000/5523 lines (54%)
Info: (DatabaseGenerator) Book 6418 'חק לישראל - בראשית': 4000/5523 lines (72%)
Info: (DatabaseGenerator) Book 6418 'חק לישראל - בראשית': 5000/5523 lines (90%)
Info: (DatabaseGenerator) books 601/2814 (21.3%) · lines 1.0M · toc 205.5K · elapsed 31:14 · eta ~1:55:00
Info: (DatabaseGenerator) books 701/2814 (24.9%) · lines 1.0M · toc 207.7K · elapsed 31:42 · eta ~1:35:32
Info: (DatabaseGenerator) ⏭️ Skipping already-processed priority book: מדרש/אגדה/מדרש זוטא.txt
Info: (IdAllocator) Category key 'מחשבת ישראל/אחרונים/רמחל' now holds 1476 (was unset)
Info: (DatabaseGenerator) books 782/2814 (27.7%) · lines 1.0M · toc 210.4K · elapsed 32:42 · eta ~1:24:58
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 14000/135957 lines (10%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 28000/135957 lines (20%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 42000/135957 lines (30%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 56000/135957 lines (41%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 70000/135957 lines (51%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 84000/135957 lines (61%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 98000/135957 lines (72%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 112000/135957 lines (82%)
Info: (DatabaseGenerator) Book 6642 'אספקלריה אותיות א - מ': 126000/135957 lines (92%)
Info: (DatabaseGenerator) books 824/2814 (29.2%) · lines 1.2M · toc 243.3K · elapsed 37:30 · eta ~1:30:34
Info: (DatabaseGenerator) Book 6643 'אספקלריה אותיות נ - ת': 10000/90850 lines (11%)
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6230        1754          12        8547        9857
/dev/vda        252G   36G   33G  53% /
 09:47:14 up  1:36,  0 user,  load average: 1.20, 1.14, 1.18
```
