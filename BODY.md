(אין גוף PR — NOT READY, ראו VERDICT.md)
סיבה: אי אפשר לאמת בסביבת הענן את מבנה הנתונים שהפיצ'ר נשען עליו. ההערות (notes/2737.md) מחייבות לבדוק קודם את פורמט line.heRef של המשניות ב-DB אמיתי (v36 ומעלה), ולעצור אם הוא לא אמין.
- ה-DB לא זמין כאן. הפרוקסי חוסם את github.com/Otzaria/SeforimLibrary/releases (403). גם add_repo ל-Otzaria/SeforimLibrary נדחה (אין הרשאה).
- גם דף ה-issue ב-github.com חסום (403), ו-REST API של Otzaria/otzaria חסום בסשן. לכן לא ראיתי את הדוגמאות של Y-PLONI ("57 heRef של משניות בברכות").
- במאגר עצמו אין fixture עם heRef של משנה. יש רק "משנה ברורה" ו"משנה תורה", שאינם רלוונטיים.
- השינוי ממיר התקדמות שמורה של משתמשים: האינדקסים נשמרים לפי absoluteIndex. מימוש "עיוור" של זיהוי גבולות המשניות ושל ההגירה עלול לשבש סימונים קיימים. לכן לא מימשתי ולא דחפתי ענף.
מצב ה-issue: פתוח, ואין PR (חיפוש 20.11).
מה צריך כדי לבצע (ריצה הבאה או מחשב עם הספרייה):
1. מה-DB המקומי: SELECT l.lineIndex, l.heRef FROM line l JOIN book b ON b.id=l.bookId WHERE b.title='משנה ברכות' ORDER BY l.lineIndex LIMIT 80; וגם את tocEntry של אותו ספר (lineId, level, text).
2. אותו דבר ל"משנה שבת" ו"משנה אבות", כדי לראות אם הפורמט אחיד.
3. להוסיף את הפלט ל-notes/2737.md ולהחזיר את 2737 לתור. אז אפשר לממש לפי ה-sketch: זיהוי לפי heRef בתוך טווח הפרק, builder משותף לשני מסלולי הטעינה, והגירה חד-פעמית עם גיבוי.
קבצים רלוונטיים: lib/tools/shamor_zachor/models/book_model.dart (_buildLearnableItemsFromSections), services/shamor_zachor_bootstrap_worker.dart (שאילתת tocEntry ב-~L204), providers/shamor_zachor_data_provider.dart, providers/shamor_zachor_progress_provider.dart.
