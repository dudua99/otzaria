# combined delta 2711 — progress (2026-11-27T17:17:46Z)

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
2026-11-27T15:30:33Z v2b DONE build -> /work/db/v2b.db
2026-11-27T15:30:33Z PIPE waiting for /work/v2a/READY
2026-11-27T15:30:43Z DELTA v2b compress v1
2026-11-27T16:19:15Z DELTA v2b copy raw + compress v2b
2026-11-27T16:43:45Z DELTA v2b producePatchAndVerify
2026-11-27T16:58:20Z DELTA v2b PATCH DONE
2026-11-27T16:58:20Z ANALYZE v2b
2026-11-27T16:58:20Z ANALYZE v2b rc=0
2026-11-27T16:59:39Z v2a START sefaria phase fordb=9bf3ab1cd0b2959962e688caf59fd8a90d32e8b1b7dc545823b21f49fa0d9911 code=c5e28010
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
- 11:59Z v1 DONE (Sefaria 51 min, rest 2h52m). v1.db 10.3 GB. v2b build started.
- v1 sanity: books 8259 / lines 7925185 = v40 library_stats exactly; links 4,454,493 vs v40 7,001,824 — the LINKER (GPU relink) links are not produced by a local build; identical on every local build, so they cancel in the deltas.
- 12:50Z v2b Sefaria phase done (50 min). Early check: Sefaria link 1064034 (שבת קמא:, טז ↔ חידושי רמב"ן קמא:, ב) gone, new link 4454494 (שבת קמא:, כח → same Ramban line), link_range rows Shabbat↔Ramban 4→5 (#4023 as expected).
- 15:05Z disk nearly full during v2b links phase (DbPublish writes a full seforim.db.candidate copy, +9.7 GB). Deleted /work/db/v1.pristine.db (v1.db itself was still uncompressed and identical).
- 16:05Z v1 compressed. My delta.sh edit had a syntax error -> v2b compress not started; fixed and restarted 16:1xZ.
- 16:58Z v2b patch verified (target hash 8be6a1a8…); analysis done; v2b.db removed for disk; v2a build released.
- 17:05Z v2b result pushed: prbody/libdata-2611-delta @112c4568 (READY).
## tail of v2a.sefaria.log
```
Info: (SefariaDirect) Processed 200/5818 books
Info: (SefariaDirect) Processed 300/5818 books
Info: (SefariaDirect) Processed 400/5818 books
Info: (SefariaDirect) Processed 500/5818 books
Info: (SefariaDirect) Processed 600/5818 books
Info: (SefariaDirect) Processed 700/5818 books
Info: (SefariaDirect) Processed 800/5818 books
Info: (SefariaDirect) Processed 900/5818 books
Info: (SefariaDirect) Processed 1000/5818 books
Info: (SefariaDirect) Processed 1100/5818 books
Info: (SefariaDirect) Processed 1200/5818 books
Info: (SefariaDirect) Processed 1300/5818 books
Info: (SefariaDirect) Processed 1400/5818 books
Info: (SefariaDirect) Processed 1500/5818 books
Info: (SefariaDirect) Processed 1600/5818 books
Info: (SefariaDirect) Processed 1700/5818 books
Info: (SefariaDirect) Processed 1800/5818 books
Info: (SefariaDirect) Processed 1900/5818 books
Info: (SefariaDirect) Processed 2000/5818 books
Info: (SefariaDirect) Processed 2100/5818 books
Info: (SefariaDirect) Processed 2200/5818 books
Info: (SefariaDirect) Processed 2300/5818 books
Info: (SefariaDirect) Processed 2400/5818 books
Info: (SefariaDirect) Processed 2500/5818 books
Info: (SefariaDirect) Processed 2600/5818 books
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087       10031        1887          12        4528        6056
/dev/vda        252G   36G   34G  52% /
 17:17:46 up  9:07,  0 user,  load average: 1.12, 1.23, 1.33
```
