# combined delta 2711 — progress (2026-11-27T08:17:06Z)

## markers
```
2026-11-27T08:15:21Z v1 START sefaria phase fordb=4be7b46c3a578165be8246372c18958b0e180f640a320e71a44943e3ec3faf10 code=c5e28010
```
## notes
- 08:15Z v1 started (v40 inputs verified by sha256; SeforimLibrary c5e2801 + local workarounds).
- v2b inputs ready: ForDB b5ceef29… (2 rows vs 4be7b46c; rebuild of v40 ForDB reproduces 4be7b46c), 38 Chavruta files (321 lines, line counts equal), code c5e2801+#4023 (2 commits).
## tail of v1.sefaria.log
```
> Task :dao:compileJvmMainJava NO-SOURCE
> Task :dao:jvmMainClasses
> Task :dao:jvmJar
> Task :generator-common:compileKotlinJvm
w: file:///work/SL/generator/common/src/commonMain/kotlin/io/github/kdroidfilter/seforimlibrary/common/notes/InlineNotes.kt:65:45 Unnecessary non-null assertion (!!) on a non-null receiver of type 'MatchResult'.
> Task :generator-common:compileJvmMainJava NO-SOURCE
> Task :generator-common:jvmMainClasses
> Task :generator-common:jvmJar
> Task :sefariasqlite:compileKotlinJvm
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/GenerateLinkerLinks.kt:346:42 Unnecessary safe call on a non-null receiver of type 'LinkerTarget'.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/SefariaBookPayloadReader.kt:170:35 'val currentName: String!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/SefariaBookPayloadReader.kt:186:35 'val currentName: String!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/SefariaExportFetcher.kt:68:37 'val nextTarEntry: TarArchiveEntry!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/SefariaExportFetcher.kt:87:37 'val nextTarEntry: TarArchiveEntry!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/manuallinks/ManualLinksConfig.kt:53:41 'fun fields(): (Mutable)Iterator<(Mutable)Map.(Mutable)Entry<String!, JsonNode!>!>!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/manuallinks/ManualLinksJson.kt:242:43 'val currentName: String!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/manuallinks/ManualLinksRefFingerprints.kt:72:42 'fun fields(): (Mutable)Iterator<(Mutable)Map.(Mutable)Entry<String!, JsonNode!>!>!' is deprecated. Deprecated in Java.
w: file:///work/SL/generator/sefariasqlite/src/jvmMain/kotlin/io/github/kdroidfilter/seforimlibrary/sefariasqlite/manuallinks/ManualLinksRefFingerprints.kt:76:34 'fun fields(): (Mutable)Iterator<(Mutable)Map.(Mutable)Entry<String!, JsonNode!>!>!' is deprecated. Deprecated in Java.
> Task :sefariasqlite:compileJvmMainJava NO-SOURCE
> Task :sefariasqlite:jvmMainClasses
> Task :sefariasqlite:jvmJar
> Task :sefariasqlite:generateSefariaSqlite
Picked up JAVA_TOOL_OPTIONS: -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Djavax.net.ssl.trustStoreType=JKS -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=39655 -Dhttp.nonProxyHosts=localhost|127.0.0.1|::1|127.*|0.*|::|169.254.*|api.anthropic.com|api-staging.anthropic.com|api-pr-preview.an
Picked up _JAVA_OPTIONS: -XX:+UnlockDiagnosticVMOptions -XX:DisableIntrinsic=_base64_encodeBlock,_base64_decodeBlock
Info: (SefariaSqlite) No previous build_state at /work/SL/build/seforim.db.buildstate — starting fresh.
```
## machine
```
               total        used        free      shared  buff/cache   available
Mem:           16087        3203        1777          12       11449       12884
/dev/vda        252G   20G   50G  28% /
 08:17:06 up 6 min,  0 user,  load average: 2.39, 1.24, 0.53
```
