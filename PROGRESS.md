# combined delta 2711 — progress (2026-11-27T17:47:49Z)

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
2026-11-27T17:47:44Z v2a DONE sefaria; snapshot
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
Info: (SefariaDirect) report written to /work/SL/build/generator-reports/sefaria-source-hashes-not-recorded.json
Info: (SefariaDirect) Category descriptions: parsed=152, used=125, unused=27
Info: (SefariaDirect) Direct Sefaria import completed.
Info: (SefariaSqlite) Link-import metrics report written to /work/SL/build/seforim.db.link-import-metrics.json
Info: (IdAllocator) build_state.db snapshot written to /work/SL/build/seforim.db.buildstate in 161.8s (books=8259, lines=7925185, tocEntries=1676654, links=4454493)
Info: (IdAllocator) IdAllocator snapshot: source(reused=1, fresh=0), author(reused=5177, fresh=0), pub_date(reused=5400, fresh=0), connection_type(reused=3908913, fresh=0), category(reused=1169, fresh=0), tocText(reused=912753, fresh=0), book_version(reused=6734, fresh=0), book(reused=5818, fresh=0)
Info: (SefariaSqlite) build_state verified against /work/SL/build/seforim.db: 15 counters ahead of the DB
Info: (SefariaSqlite) Sefaria -> SQLite completed. DB at /work/SL/build/seforim.db
[Incubating] Problems report is available at: file:///work/SL/build/reports/problems/problems-report.html
Deprecated Gradle features were used in this build, making it incompatible with Gradle 10.
You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.
For more on this, please refer to https://docs.gradle.org/9.8.0/userguide/command_line_interface.html#sec:command_line_warnings in the Gradle documentation.
BUILD SUCCESSFUL in 48m 4s
19 actionable tasks: 5 executed, 14 up-to-date
Configuration cache entry stored.
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087         824        4365          12       11359       15262
/dev/vda        252G   43G   27G  62% /
 17:47:49 up  9:37,  0 user,  load average: 1.19, 2.10, 1.97
```
