# combined delta 2711 — progress (2026-11-27T14:17:33Z)

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
Info: (DatabaseGenerator) Book 7867 'איזהו מקומן על ערכין': 7000/8422 lines (83%)
Info: (DatabaseGenerator) Book 7867 'איזהו מקומן על ערכין': 8000/8422 lines (94%)
Info: (DatabaseGenerator) books 2049/2814 (72.8%) · lines 2.9M · toc 496.1K · elapsed 1:22:49 · eta ~30:55
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 3000/24207 lines (12%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 6000/24207 lines (24%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 9000/24207 lines (37%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 12000/24207 lines (49%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 15000/24207 lines (61%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 18000/24207 lines (74%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 21000/24207 lines (86%)
Info: (DatabaseGenerator) Book 7868 'איזהו מקומן על שבת': 24000/24207 lines (99%)
Info: (DatabaseGenerator) books 2056/2814 (73.0%) · lines 2.9M · toc 502.0K · elapsed 1:23:52 · eta ~30:54
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 1000/6415 lines (15%)
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 2000/6415 lines (31%)
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 3000/6415 lines (46%)
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 4000/6415 lines (62%)
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 5000/6415 lines (77%)
Info: (DatabaseGenerator) Book 7875 'וזה לשונו - סוכה וארבע מינים [הלכה]': 6000/6415 lines (93%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 1000/6663 lines (15%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 2000/6663 lines (30%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 3000/6663 lines (45%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 4000/6663 lines (60%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 5000/6663 lines (75%)
Info: (DatabaseGenerator) Book 7885 'משנתם בלשונם - ביצה מלאכות יום טוב': 6000/6663 lines (90%)
Info: (DatabaseGenerator) books 2067/2814 (73.4%) · lines 3.0M · toc 511.9K · elapsed 1:25:02 · eta ~30:43
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        7160        1724          12        7662        8926
/dev/vda        252G   61G  8.4G  88% /
 14:17:33 up  6:07,  0 user,  load average: 1.07, 1.08, 1.08
```
