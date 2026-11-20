# #5599 follow-up: refactor that unifies book aliases in one place

Type: REFACTOR + behaviour (owner request 20.11). Issue #5599 is CLOSED (palmoni5 fixed the specific רשב"א/"על" bug in #5611 and the "מסכת" connector in #5620). palmoni5 wrote to dudua99 in the forum thread: "I took the specific bug about the Rashba. You can still open something more comprehensive." The project owner wants exactly that comprehensive version.

## Owner's requirement
One place that owns ALL book-name alias logic (acronyms from the DB, connector words, rule-derived aliases, collective names, normalization), so that:
- every consumer uses it: find-ref (איתור מקורות), library title search / `BookMatchKind.acronym`, search `@scope` (category_query_parser), list search keys (list_search_match: tabs, history, bookmarks via bookmark_search_aliases), book_title_search_diagnostics, and any other place found in the inventory;
- books from an EXTERNAL / attached DB (attached libraries, `AcronymsCache.attachedAcronymsOf`, DBs without a `book_acronym` table — see AttachedLibraryProbe capability `acronyms`), personal/file-system books and plugin-provided books get the same rule-derived aliases, not only books from the official DB;
- "go over all the alias lists": inventory every alias source and hard-coded list (DB `book_acronym` table and how it is built — SeforimAcronymizer / acronymizer.sql in the library pipeline if reachable; hard-coded connector/prefix lists in lib/find_ref/book_name_match.dart, find_ref_ranking.dart, reference_books_cache.dart, category_query_parser.dart, list_search_match.dart, tractate/sefer name tables, etc.), and fold them into the single module. Report which data-side gaps remain (aliases that only a library-data change can fix) instead of hacking around them.

## Starting points (verify on upstream/dev)
- lib/data/cache/acronyms_cache.dart + acronym_cache_data.dart (book_acronym table cache; attachedAcronymsOf).
- lib/find_ref/book_name_match.dart (bookNameAcronymForm, palmoni5's "על"/"מסכת" connector handling — keep his merged behaviour exactly), lib/find_ref/repository/reference_books_cache.dart, find_ref_ranking.dart, find_ref_db_isolate.dart (isolate! the module must be usable there: pure Dart, no Flutter imports).
- lib/search/utils/category_query_parser.dart (literalTierOf with acronyms), lib/library/models/library_match_filter.dart, lib/widgets/lists/list_search_match.dart, lib/bookmarks/utils/bookmark_search_aliases.dart, lib/data/repository/book_title_search_diagnostics.dart, lib/data/repository/data_repository.dart.
- Our earlier work: branch `feat/find-ref-connector-words-5599` commit 91a63ab86 (lib/find_ref/book_name_alias_rules.dart: connector words, title-without-connectors as alias, collective "פירוש המשניות"/"פיה"מ" for "רמב"ם על משנה", literal alias beats rule-derived alias) and, if it exists, `feat/find-ref-alias-rules-5599-v2` / prbody/5599v2-fix. Reuse ideas/code; this refactor SUPERSEDES them.

## Rules (AGENTS.md wins)
- One implementation, callers migrated in the same PR, no competing old path left behind (DESIGN_SYSTEM §3 spirit / AGENTS "Bug fix ≠ adding code"; remove the duplicated lists).
- Startup path: no new await before first frame; caches stay lazy; isolate-safe.
- Performance: alias derivation per book computed once and cached; measure typing latency in find-ref / library search before vs after on a large synthetic catalog (≥15k books, ≥14k aliases) and report numbers; no regression.
- Behaviour parity: every existing find_ref / search / library / list-search test must pass unchanged unless the change is an intended improvement, which must be listed explicitly in the PR body.
- Plugin API: if plugins see aliases (library.* API), keep the contract or document it in docs/plugin-sdk.

## Tests
- Contract tests for the module (normalization, connectors על/מסכת/ב/גמ'/ד"ה etc. as found, title-without-connectors, collective names, literal-beats-derived, external DB book without acronym table gets rule aliases).
- Failing-on-dev tests: the forum cases — "רשב"א בק" finds "רשב"א על בבא קמא"; "פירוש המשניות" / "פיה"מ ברכות" finds "רמב"ם על משנה ברכות"; an attached-DB book without book_acronym is found by its rule-derived alias in find-ref AND in library search AND in @scope; same alias resolves identically in all consumers.
- Coverage stats (in BODY): how many official-DB alias entries containing "על" now have a connector-free equivalent (forum baseline: 10,006 of 13,980 had none), per consumer.

## Output
Branch `refactor/book-aliases-5599` from upstream/dev, 2 commits (tests, then refactor). Result branch `prbody/5599r-fix`: VERDICT.md (READY / NOT READY), BODY.md in Hebrew, title "ריפקטור: כינויי ספרים במקום אחד — איתור מקורות, חיפוש, ספרייה ומאגרים חיצוניים (המשך ל-#5599)", `Refs #5599`, explicit credit to palmoni5 (#5611, #5620), inventory table (source → where it lived → where it lives now), list of intended behaviour changes with before/after examples, performance numbers, and remaining data-side gaps.
