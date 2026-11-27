# combined delta 2711 — progress (2026-11-27T13:47:31Z)

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
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
- v2a inputs ready (from 1f5dd43b): ForDB 9bf3ab1c… (all 9 shipped-file diffs applied cleanly; book_info.csv hunks at offsets -4/-8), 133 moves at packaged paths (no missing src / no clobber; moved hashes equal), metadata.json + SourcesBooks.csv diffs applied cleanly, links auto-fix (validator --fix --rename-base f4b89786, exit 0 — the row-1243 failure of 9f6a441d is fixed): 2 links files renamed + SA YD links rewritten; files_manifest 135 keys moved.
- v2a build will start only after the v2b patch is produced (avoids running two 8g JVMs on the 15 GB box).
- 11:59Z v1 DONE (Sefaria 51 min, rest 2h52m). v1.db 10.3 GB. v2b build started.
- v1 sanity: books 8259 / lines 7925185 = v40 library_stats exactly; links 4,454,493 vs v40 7,001,824 — the LINKER (GPU relink) links are not produced by a local build; identical on every local build, so they cancel in the deltas.
- 12:50Z v2b Sefaria phase done (50 min). Early check: Sefaria link 1064034 (שבת קמא:, טז ↔ חידושי רמב"ן קמא:, ב) gone, new link 4454494 (שבת קמא:, כח → same Ramban line), link_range rows Shabbat↔Ramban 4→5 (#4023 as expected).
## tail of v2b.rest.log
```
Info: (DatabaseGenerator) Book 6907 'אבני נזר אורח חיים': 5000/9930 lines (50%)
Info: (DatabaseGenerator) Book 6907 'אבני נזר אורח חיים': 6000/9930 lines (60%)
Info: (DatabaseGenerator) Book 6907 'אבני נזר אורח חיים': 7000/9930 lines (70%)
Info: (DatabaseGenerator) Book 6907 'אבני נזר אורח חיים': 8000/9930 lines (80%)
Info: (DatabaseGenerator) Book 6907 'אבני נזר אורח חיים': 9000/9930 lines (90%)
Info: (DatabaseGenerator) Book 6909 'אבני נזר יורה דעה': 1000/5461 lines (18%)
Info: (DatabaseGenerator) Book 6909 'אבני נזר יורה דעה': 2000/5461 lines (36%)
Info: (DatabaseGenerator) Book 6909 'אבני נזר יורה דעה': 3000/5461 lines (54%)
Info: (DatabaseGenerator) Book 6909 'אבני נזר יורה דעה': 4000/5461 lines (73%)
Info: (DatabaseGenerator) Book 6909 'אבני נזר יורה דעה': 5000/5461 lines (91%)
Info: (DatabaseGenerator) books 1112/2814 (39.5%) · lines 1.7M · toc 341.6K · elapsed 50:13 · eta ~1:16:52
Info: (DatabaseGenerator) Book 6958 'שו״ת בית יצחק': 1000/5310 lines (18%)
Info: (DatabaseGenerator) Book 6958 'שו״ת בית יצחק': 2000/5310 lines (37%)
Info: (DatabaseGenerator) Book 6958 'שו״ת בית יצחק': 3000/5310 lines (56%)
Info: (DatabaseGenerator) Book 6958 'שו״ת בית יצחק': 4000/5310 lines (75%)
Info: (DatabaseGenerator) Book 6958 'שו״ת בית יצחק': 5000/5310 lines (94%)
Info: (DatabaseGenerator) Book 6962 'בית שערים אורח חיים': 1000/5744 lines (17%)
Info: (DatabaseGenerator) Book 6962 'בית שערים אורח חיים': 2000/5744 lines (34%)
Info: (DatabaseGenerator) Book 6962 'בית שערים אורח חיים': 3000/5744 lines (52%)
Info: (DatabaseGenerator) Book 6962 'בית שערים אורח חיים': 4000/5744 lines (69%)
Info: (DatabaseGenerator) Book 6962 'בית שערים אורח חיים': 5000/5744 lines (87%)
Info: (DatabaseGenerator) books 1144/2814 (40.6%) · lines 1.7M · toc 345.7K · elapsed 51:20 · eta ~1:14:55
Info: (DatabaseGenerator) books 1172/2814 (41.6%) · lines 1.7M · toc 351.0K · elapsed 52:21 · eta ~1:13:20
Info: (DatabaseGenerator) books 1208/2814 (42.9%) · lines 1.8M · toc 354.8K · elapsed 53:22 · eta ~1:10:55
Info: (DatabaseGenerator) books 1246/2814 (44.2%) · lines 1.8M · toc 360.8K · elapsed 54:24 · eta ~1:08:28
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        6741        1743          12        8062        9345
/dev/vda        252G   60G  9.6G  87% /
 13:47:31 up  5:37,  0 user,  load average: 1.23, 1.14, 1.10
```
