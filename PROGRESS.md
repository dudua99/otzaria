# combined delta 2711 — progress (2026-11-27T09:17:11Z)

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
Info: (DatabaseGenerator) Book 5833 'חזון איש, יורה דעה': 6000/7912 lines (75%)
Info: (DatabaseGenerator) Book 5833 'חזון איש, יורה דעה': 7000/7912 lines (88%)
Info: (DatabaseGenerator) books 46/2814 (1.6%) · lines 75.7K · toc 15.4K · elapsed 02:14 · eta ~2:15:21
Info: (DatabaseGenerator) Book 5866 'דור המלקטים - עניינים כלליים': 1000/5598 lines (17%)
Info: (DatabaseGenerator) Book 5866 'דור המלקטים - עניינים כלליים': 2000/5598 lines (35%)
Info: (DatabaseGenerator) Book 5866 'דור המלקטים - עניינים כלליים': 3000/5598 lines (53%)
Info: (DatabaseGenerator) Book 5866 'דור המלקטים - עניינים כלליים': 4000/5598 lines (71%)
Info: (DatabaseGenerator) Book 5866 'דור המלקטים - עניינים כלליים': 5000/5598 lines (89%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 1000/6491 lines (15%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 2000/6491 lines (30%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 3000/6491 lines (46%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 4000/6491 lines (61%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 5000/6491 lines (77%)
Info: (DatabaseGenerator) Book 5868 'דור המלקטים על אבן העזר': 6000/6491 lines (92%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 20000/190453 lines (10%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 40000/190453 lines (21%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 60000/190453 lines (31%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 80000/190453 lines (42%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 100000/190453 lines (52%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 120000/190453 lines (63%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 140000/190453 lines (73%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 160000/190453 lines (84%)
Info: (DatabaseGenerator) Book 5869 'דור המלקטים על אורח חיים': 180000/190453 lines (94%)
Info: (DatabaseGenerator) books 51/2814 (1.8%) · lines 279.3K · toc 16.3K · elapsed 07:11 · eta ~6:29:40
Info: (DatabaseGenerator) Book 5871 'דור המלקטים על יורה דעה': 12000/118905 lines (10%)
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6181        1707          12        8647        9906
/dev/vda        252G   35G   35G  51% /
 09:17:11 up  1:06,  0 user,  load average: 1.14, 1.33, 1.63
```
