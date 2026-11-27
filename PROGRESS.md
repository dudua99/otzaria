# combined delta 2711 — progress (2026-11-27T15:17:37Z)

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
- 15:05Z disk nearly full during v2b links phase (DbPublish writes a full seforim.db.candidate copy, +9.7 GB). Deleted /work/db/v1.pristine.db (v1.db itself was still uncompressed and identical).
## tail of v2b.rest.log
```
Info: (GemaraDafAltToc)   רי"ף כתובות: 147 entries
Info: (GemaraDafAltToc)   רי"ף מגילה: 35 entries
Info: (GemaraDafAltToc)   רי"ף מועד קטן: 25 entries
Info: (GemaraDafAltToc)   רי"ף מכות: 18 entries
Info: (GemaraDafAltToc)   רי"ף נדרים: 100 entries
Info: (GemaraDafAltToc)   רי"ף סוכה: 58 entries
Info: (GemaraDafAltToc)   רי"ף סנהדרין: 49 entries
Info: (GemaraDafAltToc)   רי"ף עבודה זרה: 73 entries
Info: (GemaraDafAltToc)   רי"ף עירובין: 104 entries
Info: (GemaraDafAltToc)   רי"ף פסחים: 50 entries
Info: (GemaraDafAltToc)   רי"ף קידושין: 81 entries
Info: (GemaraDafAltToc)   רי"ף ראש השנה: 18 entries
Info: (GemaraDafAltToc)   רי"ף שבועות: 34 entries
Info: (GemaraDafAltToc)   רי"ף שבת: 125 entries
Info: (GemaraDafAltToc)   רי"ף תענית: 40 entries
Info: (BuildStateVerifier) build_state verified against /work/SLb/build/seforim.db: 15 counters ahead of the DB
> Task :generator-common:buildLineRefIndex
Picked up JAVA_TOOL_OPTIONS: -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Djavax.net.ssl.trustStoreType=JKS -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=39655 -Dhttp.nonProxyHosts=localhost|127.0.0.1|::1|127.*|0.*|::|169.254.*|api.anthropic.com|api-staging.anthropic.com|api-pr-preview.an
Picked up _JAVA_OPTIONS: -XX:+UnlockDiagnosticVMOptions -XX:DisableIntrinsic=_base64_encodeBlock,_base64_decodeBlock
Info: (BuildLineRefIndexCli) line_ref: 1000 books, 897006 keys
Info: (BuildLineRefIndexCli) line_ref: 2000 books, 947896 keys
Info: (BuildLineRefIndexCli) line_ref: 3000 books, 1437555 keys
Info: (BuildLineRefIndexCli) line_ref: 4000 books, 1655069 keys
Info: (BuildLineRefIndexCli) line_ref: 5000 books, 2018162 keys
Info: (BuildLineRefIndexCli) line_ref: 6000 books, 3316822 keys
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        2044        4489          12        9895       14042
/dev/vda        252G   48G   22G  70% /
 15:17:37 up  7:07,  0 user,  load average: 1.56, 1.31, 1.18
```
