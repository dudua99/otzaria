# BUILD_INPUTS — combined build + delta for libdata-2611

Baseline = v40 (`build_provenance.json` of `v40-20261123094345`): otzaria `library-links-45147067439-1-28976848e5b0`
(commit `28976848`), ForDB `fordb-sha256-4be7b46c…`, Sefaria `2026-11-23_10-32-45139177019-1`,
SeforimLibrary `c5e2801`, Linker `5c0e2a9`. All patches were made against the **current** upstream heads
(otzaria-library `4bb755f5`, SeforimLibrary `adb91b28`, LinkerToOtzaria `03cf86d0`, toldot `4a9b4d81`).
Apply with `git am patches/<N>/*.patch` on a checkout of that head; each patch also applies to the v40 inputs as below.

## 1. otzaria-library ForDB (#4172, #5826)
```
git -C otzaria-library checkout 4bb755f5   # or the ForDB of v40, see note
git -C otzaria-library am patches/4172/*.patch patches/5826/*.patch
cd otzaria-library && python3 .github/scripts/fordb_archive.py build ../fordb_candidate.zip
```
Use `fordb_candidate.zip` in place of v40's `fordb_latest.zip`. The two patches touch one CSV row each
(`ForDB/sefaria_category_changes.csv` row `"תנ״ך/דרשות ודרושים"`, `ForDB/sefaria_metadata_changes.csv` row
`"תלמוד בבלי>סדר נזיקין","בבא בתרא"`). Note: ForDB at `4bb755f5` may be newer than v40's ForDB; to isolate
these two changes, apply the same two-row edits to v40's extracted ForDB and rebuild the archive.

## 2. otzaria-library books (#5471)
The patch edits 38 files under `ToratEmetToOtzaria/ספרים/אוצריא/תלמוד בבלי/ספרות עזר/ביאור חברותא/`
and `ToratEmetToOtzaria/post_convert_fixes.tsv` (not packaged). In `otzaria_latest.zip` the books are at the
packaged path `אוצריא/תלמוד בבלי/ספרות עזר/ביאור חברותא/חברותא על <מסכת>.txt`. Recipe on the v40 zip:
```
unzip otzaria_latest.zip -d otz            # v40 asset of tag library-links-45147067439-1-28976848e5b0
git -C otzaria-library am patches/5471/*.patch     # on 4bb755f5
for f in otzaria-library/ToratEmetToOtzaria/ספרים/אוצריא/תלמוד\ בבלי/ספרות\ עזר/ביאור\ חברותא/*.txt; do
  cp "$f" "otz/אוצריא/תלמוד בבלי/ספרות עזר/ביאור חברותא/"; done
```
Checked: between v40 (`28976848`) and `4bb755f5` exactly one of the 38 files differs — `חברותא על שבת.txt`, one line
(an unrelated upstream text fix, same line count). Copying the patched files therefore also brings that one line; to isolate
#5471 exactly, run `python3 -I patches/5471/hadran.py <checkout of 28976848>` instead (the same transform the commit made:
316 + 5 lines, line count unchanged) and copy those files. In the 2026-11-23 → now ForDB, `sefaria_metadata_changes.csv`
also differs by 33 lines (other upstream edits) — see the note in step 1.
Re-zip (or repackage with `manual_links_packaging.py package`; `files_manifest.json` hashes are regenerated there).

## 3. SeforimLibrary (#4023)
```
git -C SeforimLibrary checkout adb91b28 && git -C SeforimLibrary am patches/4023/*.patch
./gradlew :sefariasqlite:jvmTest       # not runnable in the prep sandbox (dl.google.com blocked)
```
Build with this code branch (it is v40's code `c5e2801` + later upstream commits up to `adb91b28` + the patch;
to isolate, cherry-pick the 2 commits onto `c5e2801`). Only the Sefaria links phase is affected.

## 4. LinkerToOtzaria (#6075/#5927)
```
git -C LinkerToOtzaria checkout 03cf86d0 && git -C LinkerToOtzaria am patches/6075/*.patch
python3 -m unittest discover -s tests   # 640 OK
```
`engine_src` changes → the incremental driver rebuilds **every** book (full GPU relink). The new
`output_affecting_fingerprint_changes.json` record is from the committed fingerprint
`…engine_src=bbcf4ff94398e7e8…` to the patched one; if other Linker changes are merged first, regenerate the
record (`from` = committed lineage, `to` = HEAD) in the combined branch. If a full relink is not possible,
the minimal scope is book `טור` (Sefaria, id 380): only its LINKER rows change.

## 5. toldot-gedolei-yisrael (#4922, #5593) — not part of seforim.db
```
git -C toldot checkout 4a9b4d81 && git -C toldot am patches/4922/*.patch patches/5593/*.patch
python scripts/link_refs.py && python scripts/validate.py && python scripts/build_site.py
```
Release asset (`dist/biographies.json`, app bundle) is built by the repo's `v*` tag workflow.

## Expected delta vs v40 (to verify)
| table | rows | source |
|---|---|---|
| `category` | id 1468 `heShortDesc`,`heDesc` = `דרשות ודרושים על סדר המקרא.` | #4172 |
| `book` | id 124 `בבא בתרא` `heDesc` = `המסכת עוסקת בעיקר בדיני קרקעות.` | #5826 |
| `line_content` | 321 lines in books 6789–6826 (`חברותא על *`); `book.contentHash` ×38; `totalLines` unchanged | #5471 |
| `link` | −9078772; +1 COMMENTARY 6206368 (שבת קמא:, כח) → 6953288 (רמב"ן קמא:, ב) | #4023 |
| `link_range` / `link_coverage` | +1 range (endLineIndex 3626) / +1 (line 6206369; +1 for heading 35455 only if headings are covered) | #4023 |
| `link` (LINKER, source book 380) | −621 (targets 385: 466, 382: 136, 383: 18, 384: 1) + their `link_anchor`; possible ibid knock-on in the same lines | #6075 |
| everything else | unchanged | |
