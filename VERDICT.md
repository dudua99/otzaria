IN PROGRESS (builds running; provisional finding below)

# uniform-titles-3209: full build + delta vs v40

Branch under test: dudua99/otzaria-library `names/uniform-titles-3209` @ 9f6a441d (5 commits on Otzaria/otzaria-library main f4b89786).

## Inputs (exact v40 inputs, from v40-20261123094345/build_provenance.json)

| input | value | verified |
|---|---|---|
| SeforimLibrary source_commit | c5e2801083e820374e4457b81845a451f3be2244 (+ submodule SeforimMagicIndexer a5a0245b) | checked out |
| Sefaria export | 2026-11-23_10-32-45139177019-1, archive sha256 1226ae7c…f87c, release_metadata sha256 dedbf438…7c6dc | sha256 OK; lineage pairing OK |
| Otzaria library | library-links-45147067439-1-28976848e5b0, otzaria_latest.zip sha256 580bfa03…2be4 | sha256 OK |
| ForDB v1 | fordb-sha256-4be7b46c…3faf10 | sha256 OK; rebuilding its contents with fordb_archive.py reproduces 4be7b46c exactly |
| ForDB v2 | v40 ForDB + `git diff f4b89786..names/uniform-titles-3209 -- ForDB` (README.md is not shipped) -> sha256 **677f0e93c82d7616bea54235e0bdfc99bdb7a4b036229b8cdd870ca2bacb013a** | every hunk applied (book_info.csv with -4/-8 line offsets because main moved since v40; no hand edits) |
| Otzaria v2 tree | v40 otzaria_latest.zip extracted + 133 R100 moves at packaged paths (`<root>/ספרים/אוצריא/X` -> `אוצריא/X`) + metadata.json diff (4 titles) + SourcesBooks.csv diff + links auto-fix (below) + files_manifest.json regenerated (133 keys moved, hashes of changed files) | all 133 sources found, no destination pre-existed, moved-file hashes unchanged |

## Links auto-fix (what main CI will do after merge)

`validate_fordb_book_names.py --fix --rename-base f4b89786` on a sparse checkout of the branch (Sefaria index served from the pinned export's table_of_contents.json because sefaria.org is not reachable from this machine):

- 5 file renames detected and aligned:
  - חדושי הרי מיגאש על בבא מציעא -> חידושי הר״י מיגאש על בבא מציעא (no links file)
  - חדושי רעא על תלמוד בבלי -> חידושי רע״א על תלמוד בבלי (no links file)
  - חוות דעת חדושים -> חוות דעת חידושים: `MoreBooks/links/חוות דעת חדושים_links.json` renamed; 338 path_2/heRef_2 rewrites in `שולחן ערוך, יורה דעה_links.json`
  - חידושי הראה על עבודה זרה -> חידושי הרא״ה על עבודה זרה (spelling only): `KSK/links/…_links.json` renamed
- **The validator exits 1 (the auto-fix job fails):**
  `ForDB/sefaria_category_changes.csv` row 1243: `"תלמוד בבלי/ראשונים/חדושי הרא״ה"` — the category «חדושי הרא״ה» is renamed to «חידושי הרא״ה» by this branch's category_renames.csv, so the path must use the new name. The validator says the build will fail on it (SeedAllMetadata). Not fixed by the branch. The v2 build below will confirm or refute this.

## Environment deviations (same for v1 and v2, so they cancel in the delta)

- JDK: Oracle JDK 25.0.5.1 (download.oracle.com). Temurin is not reachable (api.adoptium.net and github.com/adoptium blocked by the proxy).
- Google Maven (dl.google.com) is blocked: the Android plugin and androidx compose-runtime cannot resolve. Locally removed the Android targets from build.gradle.kts / core / dao and replaced the compileOnly `androidx.compose.runtime.Stable` annotation with a local stub. JVM generator code is unchanged.
- `:packaging:downloadLexicalDb` excluded (api.github.com for kdroidFilter is blocked; lexical.db is not part of seforim.db).
- Acronymizer DB: `api.github.com`/release assets of Otzaria/SeforimAcronymizer are blocked, so `:otzariasqlite:downloadAcronymizer` cannot fetch "latest". The release that was latest when v40 was built is tag `20261119.68` (next release is 20261125); rebuilt it from that tag's `data/acronymizer.sql` (7324 books / 37736 acronyms / 43928 links, sha256 2893cd1b…12c8) and placed it at `generator/otzariasqlite/build/acronymizer/acronymizer.db`, which the task uses as-is.
- `textimages.sefaria.org` is blocked: Sefaria images are not embedded (identical on both sides).
- Heaps: generatorHeap=10g, Gradle 2g, --max-workers=2 (4 cores / 15 GB).

## Status

- [ ] v1 build
- [ ] v2 build (seeded with v1 buildstate)
- [ ] compressLineContent both
- [ ] producePatchAndVerify
- [ ] per-table counts
