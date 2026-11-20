READY
QA בלתי תלוי ל-#4229 (ברירת מחדל c: כפתור "חזרה לעיון" בסרגל הספרייה + Esc מחוץ לשדה טקסט).
ענף: feat/library-return-to-book-4229, ראש 1a77bf08baec9a9d0fe06d2f9ddeafd76c12eb84 (ללא קומיטי QA — לא נמצא מה לתקן).
כותרת ה-PR: תיקון issue #4229 — כפתור "חזרה לעיון" בסרגל הספרייה
Closes #4229. ה-issue פתוח, בלי תגובות, ואין PR פתוח אחר שמכסה אותו.
שלושה קומיטים (בדיקה, מימוש, הסתרה מתחת ל-600) — אפשר squash במיזוג.
כשל בבסיס: הבדיקות הועתקו ל-upstream/dev 9aea09eba — 2 מתוך 3 נכשלות, השלישית (בלי כרטיסיות) עוברת כמצופה.
בדיקות קשורות (library, navigation, settings/l10n, design_system, perf, focus_repository_library_home, simple_text_viewer, plugin_install_decision):
ענף ממוזג עם dev 9aea09eba: ‎+1986 ~1 -1. בסיס 9aea09eba: ‎+1983 ~1 -1. הכישלון זהה (navigation_repository_test, ריצה כ-root).
analyze ו-format נקיים; ui_lint זהה לבסיס (80 הפרות בשניהם).
upstream/dev התקדם ב-25 קומיטים; merge-tree נקי, ולכן לא נוסף קומיט מיזוג.
מול 48 ה-PRs הפתוחים: אין התנגשות חדשה (נבדק על הענף ממוזג עם dev).
סקירת קוד: Esc ממוקם אחרי ביטול בחירה מרובה (handler גלובלי) ואחרי החזרת התצוגה המקדימה; פועל רק כשהפוקוס בספרייה, כלומר במסך הספרייה. LibraryBrowser נבנה רק ב-main_window_screen, ולכן אין הקשר אחר שבו Esc ינווט בטעות.
החלטה פתוחה: אפשרות (b), ספרייה צפה, נשארה להכרעת המתחזקים/העיצוב.
בדיקה חזותית: מומלץ לבדוק מקומית. בצילומים ב-qa-shots/4229 התווית מוצגת כריבועים, כי BarButton מצייר תווית בלי fontFamily, והטקסט מצויר בגופן המובנה של flutter_tester (מתועד ב-test/support/golden_fonts.dart). אותה מגבלה חלה על כל תוויות BarButton, ולכן זו לא בעיה באפליקציה.
