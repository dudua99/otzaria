# מצאי כינויי ספרים — upstream/dev (acb6759c5), לקראת ריפקטור #5599

סטטוס: טיוטה ראשונה — מתעדכן תוך כדי עבודה.

## מקורות הכינויים (data)

| מקור | איפה נטען | הערות |
|---|---|---|
| טבלת `book_acronym` בקטלוג הרשמי (seforim.db) | `FindRefDbIsolate` → `'bookAcronymCache'` → `buildAcronymCacheData` (lib/data/cache/acronym_cache_data.dart) → `AcronymsCache` | מנורמל ב-`normalizeForFindRefMatch`, אינדקס ביגרמים, `quotedWordsByBookId` |
| `book_acronym` במסד מצורף | `AcronymsCache.readAttachedAcronyms` (isolate) → `attachedAcronymsOf(slug)` | נרמול משוכפל (לולאה נפרדת מ-buildAcronymCacheData); בלי ביגרמים ובלי quotedWords; מסד בלי הטבלה (`AttachedLibraryCapability.acronyms` כבוי) = אפס כינויים |
| ספרים אישיים (`UserBookSource`), תיקיות קבצים, PDF מהדיסק, ספרי תוספים, קטלוגים חיצוניים (אוצר החכמה/היברובוקס) | — | אין כינויים כלל (`acronymsFor` מחזיר null) |
| SeforimAcronymizer (`data/acronymizer.sql`) | צינור הספרייה, מחוץ לריפו | בונה את `book_acronym`; פערים בו אפשר לתקן רק בנתונים |

## כללים ורשימות קשיחות בקוד

| כלל / רשימה | מקום ב-dev | שימוש |
|---|---|---|
| מילת קישור "על" בין מילים (#5611, palmoni5) | `bookNameAcronymForm` — lib/find_ref/book_name_match.dart | איתור מקורות בלבד |
| "מסכת" כמילת קישור (#5620/#5609, palmoni5) | `bookNameTractateAcronymForm`, `isTractateWord` — book_name_match.dart | איתור מקורות: מטמון + `FindRefRankQuery._titleWordMatches` (find_ref_ranking.dart) |
| שכבות גיבוי: כינוי בלי "על" / בלי "מסכת", ומשנה לפי "מסכת X" בקטלוג ישן | `_QueryScan.addConnectorAlias/addTractateAlias/select`, `_matchBook` — reference_books_cache.dart | איתור מקורות בלבד |
| ה"א הידיעה לפני ראשי תיבות של חכמים (`sagesTakingDefiniteArticle`) | book_name_match.dart | איתור מקורות, רשימות (list_search_match `_tokenMatches`) |
| כתיב מלא/חסר, וו/יי | book_name_match.dart | איתור מקורות, רשימות |
| החלפת סוגה שו"ת↔תשובות (`_genrePrefixes`) | find_ref_repository.dart | איתור מקורות; החלפת שאילתה, לא כינוי |
| מילים בגרשיים (`quotedWordsOf`) | book_name_match.dart + `AcronymsCache.quotedWordsForBook` | איתור מקורות; **רק לקטלוג הרשמי** |
| זנב כינוי כחלק פנימי (`_acronymSectionTokens`, `_spelledOutSection`) | find_ref_repository.dart | `_spelledOutSection` קורא **רק** כינויים רשמיים |

## צרכנים

| צרכן | קובץ | מקור הכינויים היום | חסר |
|---|---|---|---|
| איתור מקורות — קטלוג רשמי | reference_books_cache.dart `BookTitleIndex._official` | `AcronymsCache.getAcronymsForBook` + `candidatesFor` | כינויים שנגזרים מהכותרת |
| איתור מקורות — מסד מצורף | find_ref_repository.dart `_loadAttachedBooks` → `_SecondaryIndex` → `BookTitleIndex` | `attachedAcronymsOf` (מפה גולמית) | מסד בלי `book_acronym` — כלום; בלי ביגרמים; בלי quotedWords |
| איתור מקורות — מסד אישי/PDF | `_SecondaryIndex.build` בלי כינויים | — | הכול |
| חיפוש כותרות בספרייה / `BookMatchKind.acronym` | data_repository.dart `buildBookSearchEntry` | `AcronymsCache.acronymsFor(source,id)` | אישיים/חיצוניים; כללים |
| צמצום `@שם` בחיפוש | search/utils/category_query_parser.dart `_BookCandidate.acronyms` | `acronymsFor` | כנ"ל |
| חיפוש ברשימות היסטוריה/סימניות | bookmarks/utils/bookmark_search_aliases.dart → list_search_match.dart | `acronymsFor` | כנ"ל |
| חיפוש כרטיסיות פתוחות | navigation/view/tab_search_menu.dart | — (`title.contains`) | לא משתמש בכינויים כלל |
| book_title_search_diagnostics.dart | שלבי המתנה בלבד (`acronyms`, `attachedAcronyms`) | — | אין לוגיקת כינויים |
| תוספים (library.findBooks) | plugin_bridge_adapter.dart → `DataRepository.findBooks` | יורש מחיפוש הספרייה | `word.acronyms`/`dictionary` הם מילון ראשי תיבות כללי — לא כינויי ספרים, מחוץ לתחום |

## מה לא בתחום
- מילון ראשי-התיבות הכללי (tools/acronyms_dictionary, `assets/search_acronyms.json`, DictionaryLookupRepository) — מילים, לא שמות ספרים.
