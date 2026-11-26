READY
עדכון PR #5646 (טיוטה) לפי notes/2543c.md — החלטת הבעלים 26.11.
ענף: feat/open-books-scope-2543 (ב-fork), ראש 115fded14ee93ce4ca90f45606dea9b167ae0516. דחיפה fast-forward מ-82c34a359, בלי rebase ובלי force.
שלושה קומיטים חדשים מעל הראש הקודם:
- 829b1e37c מיזוג upstream/dev (4fe1973a4). קונפליקט יחיד: settings_catalogs.g.dart (מחולל) — נוצר מחדש ב-generate_settings_l10n. התאמת עוזר הבדיקה ל-SuperListView של dev.
- e460ac3f1 בדיקת אימות: טקסט+PDF באותו id, ושורה בלי כותרת משנה (3 בדיקות חדשות נכשלות לפני התיקון; בדיקת "שני ה-facets" עברה גם לפני כי ההתאמה לפי keyOf בחרה בעודף).
- 115fded14 תיקון: איחוד והתאמה לפי BookIdentity.indexedFilePath (לא keyOf); שורה בלי כותרת משנה, צבע סמל כמו "כל הספרים"/"ספרי יסוד", הסבר תמונת המצב ב-tooltip; openBooks הוא פונקציה שנקראת רק כשהתפריט פתוח.
ממצא אגב: אחרי המיזוג search_dialog_history_scope_test (של dev) נכשל כי הדיאלוג קרא את TabsBloc.state בכל בנייה (mock בלי state) — תוקן בקריאה עצלה; עכשיו עובר.
בדיקות (127 קבצים: כל test/search + המייבאים את search_scope_menu/search_dialog/open_search_books), flutter test -j 1:
- ענף: 1454 עברו, 0 נכשלו, 4 דולגו.
- בסיס upstream/dev 4fe1973a4 + קובץ הבדיקה החדש: 1444 עברו, 1 נכשל (טעינת קובץ הבדיקה — ה-API לא קיים), 4 דולגו.
analyze/format נקיים; ui_lint: 0 חדשות.
קונפליקטים: merge-tree מול כל 53 ה-PR-ים הפתוחים — אין קונפליקט חדש לעומת dev (#6041 מתנגש ב-plugin_registry_repository גם מול dev). #6052 עדיין פתוח — מיזוג נקי.
צילומים: qa-shots/2543c (לפני/אחרי, בהיר+כהה, עם/בלי ספרים פתוחים, 800 רוחב, Rubik).
BODY.md — גוף מעודכן ל-#5646 (Refs #2543, סעיף 1 בלבד). REPLY.md — תגובה קצרה למתחזקים (לפרסום ידני).
פתוח: ה-PR נשאר טיוטה; ההחלטה אם לקבל את הפיצ'ר — של המתחזקים (Y-PLONI הציע לסגור, palmoni5 שאל מה התועלת; REPLY עונה).
מומלץ: בדיקה מקומית קצרה של ה-tooltip בריחוף על השורה ושל טקסט+PDF פתוחים יחד.
