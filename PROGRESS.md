# combined delta 2711 — progress (2026-11-27T11:47:22Z)

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
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7788 'ראש יוסף על ברכות' (distinct=0.46, oneWord=1.00, opener=0.30, hits=668)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7789 'ראש יוסף על חולין' (distinct=0.19, oneWord=1.00, opener=0.35, hits=1624)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7805 'כפות תמרים על סוכה' (distinct=0.42, oneWord=1.00, opener=0.17, hits=293)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7810 'שפת אמת על ברכות' (distinct=0.30, oneWord=0.89, opener=0.19, hits=27)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7811 'שפת אמת על עירובין' (distinct=0.06, oneWord=0.71, opener=0.02, hits=231)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7812 'שפת אמת על פסחים' (distinct=0.08, oneWord=0.72, opener=0.08, hits=372)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7813 'שפת אמת על שבת' (distinct=0.09, oneWord=0.71, opener=0.10, hits=689)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7814 'שפת אמת על בכורות' (distinct=0.14, oneWord=1.00, opener=0.03, hits=74)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7815 'שפת אמת על זבחים' (distinct=0.09, oneWord=1.00, opener=0.04, hits=343)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7816 'שפת אמת על כריתות' (distinct=0.12, oneWord=1.00, opener=0.11, hits=65)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7817 'שפת אמת על מנחות' (distinct=0.12, oneWord=1.00, opener=0.12, hits=353)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7818 'שפת אמת על מעילה' (distinct=0.20, oneWord=1.00, opener=0.07, hits=44)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7819 'שפת אמת על ערכין' (distinct=0.19, oneWord=1.00, opener=0.13, hits=75)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7820 'שפת אמת על תמורה' (distinct=0.16, oneWord=1.00, opener=0.10, hits=86)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 7833 'תפארת יעקב על גיטין' (distinct=0.06, oneWord=1.00, opener=0.49, hits=2642)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 8032 'חידושי הר״ן (מיוחס לו) על שבת' (distinct=0.49, oneWord=1.00, opener=0.20, hits=1823)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 8045 'אור הישר (ירושלמי)' (distinct=0.03, oneWord=1.00, opener=0.02, hits=1145)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 8105 'שקל הקדש על ירושלמי שקלים' (distinct=0.25, oneWord=1.00, opener=0.52, hits=677)
Info: (BuildLineDhIndexCli) line_dh: dropping noisy book 8158 'תורת נתנאל על התורה' (distinct=0.53, oneWord=0.98, opener=0.38, hits=217)
Info: (BuildLineDhIndexCli) line_dh: 1273149 dibburim over 2631 bold-format (35 of them lead-bold) + 107 dash-format books (2143 books below threshold, 294 books dropped as non-dibbur marking; eligible=4892 metadata + 283 reviewed overrides, unreviewed=3084)
> Task :sefariasqlite:buildLineDivineNameIndex
Picked up JAVA_TOOL_OPTIONS: -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Djavax.net.ssl.trustStoreType=JKS -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=39655 -Dhttp.nonProxyHosts=localhost|127.0.0.1|::1|127.*|0.*|::|169.254.*|api.anthropic.com|api-staging.anthropic.com|api-pr-preview.an
Picked up _JAVA_OPTIONS: -XX:+UnlockDiagnosticVMOptions -XX:DisableIntrinsic=_base64_encodeBlock,_base64_decodeBlock
Info: (BuildLineDivineNames) Reading pinned ForDB archive /work/in/fordb/fordb_latest.zip (sha256=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10)
Info: (BuildLineDivineNames) line_divine_name: 500000 lines, 22568 spans
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        2863        3551          12       10014       13223
/dev/vda        252G   36G   34G  52% /
 11:47:22 up  3:36,  0 user,  load average: 1.11, 1.15, 1.11
```
