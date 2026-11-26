# מה השינוי?

השלמת סעיף 3 של #4490 (סעיפים 1-2 וההתנהגות של `closeForExternalWrite` תחת תור מלא נכנסו ב-#5662): בדיקות לכשל במסלולי ההחלפה והעדכון של הספרייה כשתור הבקרה של ה-worker מלא, ותיקון ממוקד לתקלה שהבדיקות חשפו.

## מה היה שבור

כשתור הבקרה של `DbReadWorker` מלא (ארבע פקודות open/resume ממתינות מאחורי קריאה ארוכה), `closeForExternalWrite` נכשל בלי אישור שחרור, כמתוכנן. אבל השגיאה נזרקה כ-`StateError` רגיל, וההודעות בהורדה מחדש, בייבוא ובעדכון הספרייה משרשרות את השגיאה. לכן המשתמש ראה:

`שגיאה בעדכון הספרייה: Bad state: לא ניתן לשחרר את seforim.db לפני החלפת הספרייה`

כלומר טקסט חריגה גולמי (בניגוד ל-AGENTS.md: "Never show `e.toString()` to the user"), ובלי הנחיה לנסות שוב. בעדכון הספרייה (`LibraryUpdateBloc._errorDetail`) פרט השגיאה היה `Bad state: ...` באותו אופן.

## סיבת השורש

85431f6be ("fix: שחרור חיבורי DB בהחלפת ספרייה") זרק `StateError` עם הודעה בעברית. `StateError.toString()` מוסיף לה `Bad state: `. 4fc0be4e3 הוסיף את `DbReadWorkerNotReleased` כתת-מחלקה של `StateError`, עם אותה התנהגות.

## התיקון

- `LibraryDbNotReleased extends StateError`, ש-`toString()` שלו מחזיר את ההודעה עצמה. `DbReadWorkerNotReleased` יורש ממנו. מי שתופס `StateError` או `DbReadWorkerNotReleased` לא משתנה.
- ההודעה עברה לקטלוג: `LibraryMessages.libraryDbBusy` — "מסד הספרייה בשימוש כרגע ולא ניתן לשחרר אותו. יש לנסות שוב בעוד רגע."
- מדיניות הקיבולת והסירוב לאשר שחרור שלא אומת לא השתנו.

## מדידת ההשהיה (סעיף 3, נקודה 3) וההחלטה

ספר של 200,000 שורות (כ-40MB), 20 ריצות, worker אמיתי:

| מצב | טווח | חציון |
|---|---|---|
| קריאה רגילה, בלי הפרעה | 250-699ms | ~420ms |
| suspend כשהתור פנוי: הקריאה נקטעת אחרי | 35-93ms | ~56ms |
| ארבעה מקומות תפוסים: ה-suspend נדחה (Busy) אחרי | 0-5ms | ~1ms |
| ארבעה מקומות תפוסים: הקריאה מסתיימת אחרי | 252-500ms | ~380ms |

כשהתור מלא הקריאה הארוכה אינה נקטעת: פקודות ה-open ממתינות מאחוריה, וה-`lifecycleState` הדחוי נשלח רק אחריהן. ההשהיה חסומה במשך הקריאה עצמה, והמתקשר מקבל `DbReadWorkerSuspended` בסופה. ה-suspend עצמו נדחה מיד, כך שהחלפת הספרייה נכשלת מהר ובלי כתיבה, והמשתמש יכול לנסות שוב. ההחלטה: ההתנהגות מספקת, ואין שינוי במדיניות הקיבולת.

## בדיקות שנוספו

- `test/empty_library/library_replace_worker_busy_test.dart` (חדש, worker אמיתי, timeout מפורש):
  - הורדה מחדש (`UpdateLibraryRequested`) כשהתור מלא: מצב שגיאה עם הודעה ברורה בלי `Bad state`, אף בקשת הורדה לא נשלחה, ה-DB הישן נשאר, ה-hold של מקור השורות שוחרר. אחרי שהתור התרוקן, אותו אירוע מצליח ומחליף את ה-DB.
  - השגיאה האמיתית מ-`closeForExternalWrite` בתור מלא: `DbReadWorkerNotReleased`, טקסט בלי `Bad state` גם דרך `packageImportErrorMessage` (ייבוא עם גיבוי), וניסיון חוזר מקבל אישור שחרור.
- `test/library_update/library_update_bloc_test.dart`: כשל apply עם `DbReadWorkerNotReleased` מציג את ההודעה עצמה ב-`errorMessage`.
- `test/data_providers/db_read_worker_test.dart`: מדידת ההשהיה שלמעלה, עם בדיקת ההתנהגות (Busy מיידי, הקריאה מסתיימת ב-Suspended, worker קורא שוב אחרי resume).

בעדכון הספרייה ברמת ה-repository (`library_update_repository.dart`, הקריאות ל-`closeForExternalWrite` ב-`_installSqliteTempDirectoryWhenQuiesced` וב-`_applyStepInQueue`) השגיאה עוברת הלאה בלי שינוי ולפני כל כתיבה, ולכן הכיסוי הוא ברמת ה-bloc שמציג אותה.

Fixes #4490

## בדיקות

- הבדיקות החדשות נכשלות על dev (`Bad state: ...` בהודעה) ועוברות עם התיקון.
- `library_replace_worker_busy_test.dart` ‏20/20 ריצות ירוקות; מבחן המדידה 20/20.
- 121 קבצים: `test/empty_library/`, `test/library_update/`, `test/data_providers/` וכל מה שמייבא את `sqlite_data_provider.dart` או `db_read_worker.dart`, ב-`flutter test -j 1`:
  - ענף: 1784 עברו, 8 דולגו, 6 נכשלו.
  - בסיס (dev 4fe1973a4): 1779 עברו, 8 דולגו, 7 נכשלו.
  - 6 הכישלונות זהים בשניהם ונובעים מהרצה כ-root (הרשאות קבצים): ארבעה ב-`library_update_repository_test`, אחד ב-`library_package_import_bloc_test`, אחד ב-`navigation_repository_test`. הכישלון הנוסף בבסיס (`page_shape_super_commentary_wait_test`) עבר בענף.
- `dart analyze` ו-`dart format` נקיים בקבצים שנגעו; `dart tool/ui_lint_cli.dart` בלי הפרות חדשות.
- אין קונפליקט חדש מול PRs פתוחים (`git merge-tree`).

<!-- SUITE -->
