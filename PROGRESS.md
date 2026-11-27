# combined delta 2711 — progress (2026-11-27T12:47:27Z)

## markers
```
2026-11-27T08:15:21Z v1 START sefaria phase fordb=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10 code=c5e28010
2026-11-27T09:06:48Z v1 DONE sefaria; snapshot
2026-11-27T09:07:00Z v1 START rest
2026-11-27T11:59:24Z v1 DONE build -> /work/db/v1.db
2026-11-27T11:59:35Z PIPE waiting for /work/v2b/READY
2026-11-27T11:59:38Z v2b START sefaria phase fordb=b5ceef29ee3f84c6682846d4f76e1bc7d53b689c606d06b2ea3b430d3dbf9a35 code=1ed6179a
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
- 11:59Z v1 DONE (Sefaria 51 min, rest 2h52m). v1.db 10.3 GB. v2b build started.
- v1 sanity: books 8259 / lines 7925185 = v40 library_stats exactly; links 4,454,493 vs v40 7,001,824 — the LINKER (GPU relink) links are not produced by a local build; identical on every local build, so they cancel in the deltas.
## tail of v2b.sefaria.log
```
type=SUMMARY csvRowsRead=1 csvDropped=1 csvResolvedPairs=0 storedWritten=0
type=SUPER_COMMENTARY csvRowsRead=24886 csvDropped=0 csvResolvedPairs=24886 storedWritten=24886
type=TARGUM csvRowsRead=34728 csvDropped=0 csvResolvedPairs=34728 storedWritten=34729
totals csvRowsRead=5192640 csvDropped=1283772 csvResolvedPairs=3911556 storedWritten=3896061 (resolvedPairs-written=15495: pairs dropped by the heading/self-link filters or collapsed by INSERT OR IGNORE)
Info: (SefariaDirect) Suppressed link sides: 300201 hidden of 7792122 sides carrying a verdict (7491921 cleared by a visible contribution)
Info: (SefariaDirect) Anchored 3448 lines of book 563 to its base text
Info: (SefariaDirect) Derived 279 commentary links from Sefaria segment addresses
Info: (SefariaDirect) Wrote 2 of 2 curated commentary links
Info: (SefariaDirect) Linked 39 sections of parallel books
Info: (SefariaDirect) Links processed
Info: (SefariaDirect) Resolving inline commentary anchors (itags)...
Info: (SefariaDirect) Inline anchors: 173700 anchors from 83579 itag-carrying lines (594 label-only tags re-aligned to their printed comment)
Warn: (SefariaDirect) Inline anchors skipped tags — no commentary book for tag: 143167 (e.g. Notes and Corrections on Midrash Lekach Tov on Midrash Lekach Tov on Esther, Introduction,  2); tag without order/label: 141327 (e.g. Notes by Heinrich Guggenheimer on Jerusalem Talmud Berakhot 1:5:13); co
Info: (SefariaDirect) Printed-marker anchors: 385 inserted (513 markers unmatched, 0 ambiguous)
Info: (SefariaDirect) Resolving char-level anchors (charLevelData, 47784 cells)...
Info: (SefariaDirect) Char-level anchors: 6542 inserted from 47784 CSV cells
Info: (SefariaDirect) Char-level anchors skipped — word-based offsets: 23892; version mismatch: 9817; multi-version book: 7555; offsets out of bounds: 2; known incorrect quotation offset: 2; line modified by cleaning: 3
Info: (SefariaDirect) Demoting cross-corpus dependant links per Sefaria categorisation...
Info: (SefariaDirect) Recorded source hashes for 5818 / 6220 Sefaria books
Warn: (SefariaDirect) source hashes: 402 of 6220 Sefaria books have no source hash — they are fully reprocessed every cycle
Warn: (SefariaDirect) source hashes: 402 not recorded — skipped by the book/author blacklist (אֲהֵבוּךָ עַד מָוֶת, אגרת אריסטיאס, אדם מן האדמה, אוהב גר, אור לישרים על תלמוד ירושלמי ביצה, אור לישרים על תלמוד י�
Info: (SefariaDirect) report written to /work/SLb/build/generator-reports/sefaria-source-hashes-not-recorded.json
Info: (SefariaDirect) Category descriptions: parsed=152, used=125, unused=27
Info: (SefariaDirect) Direct Sefaria import completed.
Info: (SefariaSqlite) Link-import metrics report written to /work/SLb/build/seforim.db.link-import-metrics.json
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087       10758        1816          12        3936        5328
/dev/vda        252G   47G   22G  69% /
 12:47:27 up  4:36,  0 user,  load average: 1.56, 2.19, 1.77
```
