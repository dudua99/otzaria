## מה היה חסר
אחרי עדכון נתוני החיפוש החכם נשאר על הדיסק, ליד סט הוקטורים החדש, גם הסט הקודם (#2467). המנוע שומר את הדור הקודם כגיבוי עד ההתקנה הבאה, ומאז otzaria_search_engine 7.5.3 (שכבר מוצמד ב-dev) הוא מספק `retirePreviousSemanticGeneration` כדי לוותר עליו אחרי שהדור החי נפתח. התוכנה מעולם לא קראה לו (`grep -rn retirePrevious lib` ריק ב-dev).

## השינוי
- `SemanticEngineBackend.retirePreviousGeneration(vectorsDir)` – מתודה חדשה בממשק; המתאם `OnnxSemanticEngineAdapter` קורא ל-`retirePreviousSemanticGeneration` ומחזיר `retired`, עם מיפוי השגיאות הרגיל (`_guard`). `UnavailableSemanticEngineBackend` מחזיר "לא זמין".
- `SemanticSearchRepository._open`: אחרי פתיחה מוצלחת, כשהסט **לא** נפתח מהגיבוי (`recoveredFromPrevious == false`), נמחק הדור הקודם ברקע:
  - פעם אחת לכל דור בהרצה (פתיחה חוזרת של אותו דור לא קוראת שוב; דור חדש – כן).
  - רץ במשבצת של האיחוד (`_compaction`), ולכן התקנה, מחיקת נתונים והעברת ספרייה כבר ממתינות לו דרך `_stopCompaction`, ואין ריצה בזמן העברה או איחוד.
  - `VectorsBusy` (התקנה/איחוד תופסים את הסט) – בלי כשל, והפתיחה הבאה מנסה שוב. כשל אחר – נרשם ביומן בלבד; לא נוגע ב-`_lastFailure` ולא במצב שבממשק.
  - אחרי מחיקה מוצלחת `_vectors` מתרענן (גודל על הדיסק). מטמון "הספרים המכוסים" לא מתבטל, כי הדור החי לא משתנה (וחישובו סורק את כל האינדקס).
- לא רץ בעליית התוכנה: רק מנתיב הפתיחה, שהוא עצל (חיפוש או `ensureOpen`).

Closes #2467

## בדיקות
- בדיקה חדשה `test/semantic_search/semantic_retire_previous_test.dart` (4 מקרים: קריאה אחת לכל דור עם תיקיית הוקטורים של הפתיחה; לא נקרא כשהפתיחה נפלה לגיבוי; סט תפוס – הממשק נשאר "מוכן" והפתיחה הבאה מנסה שוב; כשל אחר – נרשם בלבד והחיפוש ממשיך). 3 מהם נכשלים ב-dev; המקרה של הגיבוי הוא שמירה מפני רגרסיה.
- בדיקת מתאם חדשה ב-`onnx_semantic_engine_adapter_test.dart` (העברת התיקייה ומיפוי `vectorsBusy`).
- `flutter test test/semantic_search/ -j 1`:
  - ענף: 554 עברו, 1 נכשל, 0 דולגו.
  - בסיס (upstream/dev 4fe1973a4): 549 עברו, 1 נכשל, 0 דולגו.
  - הכשל זהה בשניהם ונובע מהסביבה: `semantic_models_test.dart` "מחיקה שנכשלה באמצע משאירה את סימן הבעלות" מצפה ל-FileSystemException מהרשאות, וב-CI המקומי הבדיקות רצו כ-root.
- `flutter analyze` – אין בעיות. `dart format` נקי; `dart tool/ui_lint_cli.dart` – פלט זהה לבסיס.
- PR פתוחים שנוגעים באותם קבצים: #6065 (revert של #6059) – מתמזג בלי קונפליקט עם השינוי הזה; #4790 – מתנגש כבר עם dev עצמו באותם קבצים, ללא קונפליקט חדש.

<!-- SUITE -->
