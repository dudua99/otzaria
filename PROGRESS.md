# combined delta 2711 — progress (2026-11-27T19:17:57Z)

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
2026-11-27T17:47:50Z v2a START rest
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
- 17:47Z v2a Sefaria phase done (48 min); rest started.
## tail of v2a.rest.log
```
Info: (DatabaseGenerator) books 2079/2814 (73.8%) · lines 3.0M · toc 534.8K · elapsed 1:25:45 · eta ~30:19
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 1000/7010 lines (14%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 2000/7010 lines (28%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 3000/7010 lines (42%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 4000/7010 lines (57%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 5000/7010 lines (71%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 6000/7010 lines (85%)
Info: (DatabaseGenerator) Book 7898 'משנתם סדורה - בבא מציעא פרק איזהו נשך': 7000/7010 lines (99%)
Info: (DatabaseGenerator) Book 7900 'משנתם סדורה - ביצה מלאכות יום טוב': 1000/5805 lines (17%)
Info: (DatabaseGenerator) Book 7900 'משנתם סדורה - ביצה מלאכות יום טוב': 2000/5805 lines (34%)
Info: (DatabaseGenerator) Book 7900 'משנתם סדורה - ביצה מלאכות יום טוב': 3000/5805 lines (51%)
Info: (DatabaseGenerator) Book 7900 'משנתם סדורה - ביצה מלאכות יום טוב': 4000/5805 lines (68%)
Info: (DatabaseGenerator) Book 7900 'משנתם סדורה - ביצה מלאכות יום טוב': 5000/5805 lines (86%)
Info: (DatabaseGenerator) books 2086/2814 (74.1%) · lines 3.1M · toc 546.5K · elapsed 1:26:46 · eta ~30:17
Info: (DatabaseGenerator) Book 7908 'משנתם סדורה - כתובות פרק ראשון': 1000/5762 lines (17%)
Info: (DatabaseGenerator) Book 7908 'משנתם סדורה - כתובות פרק ראשון': 2000/5762 lines (34%)
Info: (DatabaseGenerator) Book 7908 'משנתם סדורה - כתובות פרק ראשון': 3000/5762 lines (52%)
Info: (DatabaseGenerator) Book 7908 'משנתם סדורה - כתובות פרק ראשון': 4000/5762 lines (69%)
Info: (DatabaseGenerator) Book 7908 'משנתם סדורה - כתובות פרק ראשון': 5000/5762 lines (86%)
Info: (DatabaseGenerator) books 2093/2814 (74.3%) · lines 3.1M · toc 559.4K · elapsed 1:27:47 · eta ~30:14
Info: (DatabaseGenerator) Book 7912 'משנתם סדורה - שבת מוקצה בפרק כירה': 1000/5862 lines (17%)
Info: (DatabaseGenerator) Book 7912 'משנתם סדורה - שבת מוקצה בפרק כירה': 2000/5862 lines (34%)
Info: (DatabaseGenerator) Book 7912 'משנתם סדורה - שבת מוקצה בפרק כירה': 3000/5862 lines (51%)
Info: (DatabaseGenerator) Book 7912 'משנתם סדורה - שבת מוקצה בפרק כירה': 4000/5862 lines (68%)
Info: (DatabaseGenerator) Book 7912 'משנתם סדורה - שבת מוקצה בפרק כירה': 5000/5862 lines (85%)
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6830        1885          12        7805        9256
/dev/vda        252G   52G   17G  76% /
 19:17:57 up 11:07,  0 user,  load average: 1.04, 1.08, 1.08
```
