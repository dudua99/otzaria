# combined delta 2711 — progress (2026-11-27T10:47:18Z)

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
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 3000/9088 lines (33%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 4000/9088 lines (44%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 5000/9088 lines (55%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 6000/9088 lines (66%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 7000/9088 lines (77%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 8000/9088 lines (88%)
Info: (DatabaseGenerator) Book 7921 'שלמי כהן גיטין': 9000/9088 lines (99%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 1000/9736 lines (10%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 2000/9736 lines (20%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 3000/9736 lines (30%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 4000/9736 lines (41%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 5000/9736 lines (51%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 6000/9736 lines (61%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 7000/9736 lines (71%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 8000/9736 lines (82%)
Info: (DatabaseGenerator) Book 7922 'שלמי כהן יבמות': 9000/9736 lines (92%)
Info: (DatabaseGenerator) books 2104/2814 (74.7%) · lines 3.2M · toc 573.8K · elapsed 1:37:23 · eta ~32:51
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 1000/8590 lines (11%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 2000/8590 lines (23%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 3000/8590 lines (34%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 4000/8590 lines (46%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 5000/8590 lines (58%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 6000/8590 lines (69%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 7000/8590 lines (81%)
Info: (DatabaseGenerator) Book 7924 'שלמי כהן כתובות': 8000/8590 lines (93%)
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6570        1693          12        8270        9516
/dev/vda        252G   38G   31G  56% /
 10:47:18 up  2:36,  0 user,  load average: 1.03, 1.08, 1.08
```
