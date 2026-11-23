# PR #5885 — Codex review 23.11

Branch: `feat/track-pdf-books-shamor-zachor-4345-r2-v2` (pushed, no force), head `27abaa70b`.
New commits: `7000cb710` (tests), `ab4da983a` (finding 1), `27abaa70b` (finding 2).

## Finding 1 — rekey overwrites imported progress: FIXED
- Repro: legacy `-1` entry + imported stable-key backup of the same PDF (via `BackupImportMerge.mergeShamorZachor`), then `migrateLegacyPdfBooks`. The imported mark was lost (`rekeyBooks` did `map[to] = value`). Failed on `afaf5ff6d`.
- Winner: the stable/target key wins. Legacy data only fills gaps: per-item marks are unioned; columns = target (or defaults if the target has progress but no custom columns) + legacy-only ids, capped at 8; completion date, column dates and last position come from the legacy key only if the target has none.
- `mergeTrackedPdfBooks` unchanged: it keeps both entries (their identities differ until the file is hashed), and migration then folds the legacy entry into the stable one.

## Finding 2 — 3-sample fingerprint collides: FIXED
- Repro: two 512KB files differing in one byte at 128K → same identity; the second add was skipped. Failed on `afaf5ff6d`.
- Fix: streaming SHA-256 of the whole file in `Isolate.run`, with an in-memory cache keyed by path+size+mtime (once per file version per session). The size pre-filter still limits hashing to files whose size matches a tracked book. Migration is still unawaited after the screen opens (not on app startup) and is idempotent.
- Cost: 200MB synthetic file on a 4-core cloud VM: cold 2.5–2.7 s, cached <1 ms; max main-isolate timer gap 4–57 ms.
- Note: identities hashed by the PR's earlier build (3-sample) don't match the new ones. That only affects PR testers, since nothing has been released.
- Open decision (optional): the cache is not persisted, so after a restart each tracked file is hashed once more on first use. A persistent cache would need a non-backed-up settings key.

## Checks
- test/shamor_zachor: 141 pass.
- shamor_zachor + settings + data_providers (`flutter test -j 1`): branch +1929 ~5 -2, upstream/dev +1913 ~5 -2. The same 2 failures appear on both (write-permission tests that don't work under root: personal_books_import_service copyFiles, orphan_library_service delete).
- `dart analyze` and `dart format --set-exit-if-changed` are clean on touched files. `ui_lint` exits 0 with no entries in touched files.
- Nothing posted on GitHub.
