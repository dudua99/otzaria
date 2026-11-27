# combined delta 2711 — progress (2026-11-27T08:47:09Z)

## markers
```
2026-11-27T08:15:21Z v1 START sefaria phase fordb=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10 code=c5e28010
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
## tail of v1.sefaria.log
```
Info: (SefariaDirect) Processed 2600/5818 books
Info: (SefariaDirect) Processed 2700/5818 books
Info: (SefariaDirect) Processed 2800/5818 books
Info: (SefariaDirect) Processed 2900/5818 books
Info: (SefariaDirect) Processed 3000/5818 books
Info: (SefariaDirect) Processed 3100/5818 books
Info: (SefariaDirect) Processed 3200/5818 books
Info: (SefariaDirect) Processed 3300/5818 books
Info: (SefariaDirect) Processed 3400/5818 books
Info: (SefariaDirect) Processed 3500/5818 books
Info: (SefariaDirect) Processed 3600/5818 books
Info: (SefariaDirect) Processed 3700/5818 books
Info: (SefariaDirect) Processed 3800/5818 books
Info: (SefariaDirect) Processed 3900/5818 books
Info: (SefariaDirect) Processed 4000/5818 books
Info: (SefariaDirect) Processed 4100/5818 books
Info: (SefariaDirect) Processed 4200/5818 books
Info: (SefariaDirect) Processed 4300/5818 books
Info: (SefariaDirect) Processed 4400/5818 books
Info: (SefariaDirect) Processed 4500/5818 books
Info: (SefariaDirect) Processed 4600/5818 books
Info: (SefariaDirect) Processed 4700/5818 books
Info: (SefariaDirect) Processed 4800/5818 books
Info: (SefariaDirect) Processed 4900/5818 books
Info: (SefariaDirect) Processed 5000/5818 books
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        8605        1712          12        6123        7481
/dev/vda        252G   22G   47G  32% /
 08:47:09 up 36 min,  0 user,  load average: 1.11, 1.14, 1.16
```
