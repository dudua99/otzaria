READY
QA בלתי תלוי של #4452 (קיצור Ctrl+/ פותח את ההגדרות בלשונית "קיצורים"). ה-issue פתוח, ואף PR פתוח לא מטפל בו.
ענף: feat/open-shortcuts-list-4452, ראש 794daa39ee3bae3b865de7c37f63ce21e14978cf. לא נדחפו קומיטים: לא נמצא מה לתקן.
כותרת PR: תיקון issue #4452 — קיצור Ctrl+/ פותח את רשימת קיצורי המקשים. Closes #4452.
כשל על הבסיס: הבדיקות החדשות לא מתקמפלות על 7f2b6c4ec (settingsController, openShortcutsListKey לא קיימים), ועוברות בענף.
בדיקות (66 קבצים, -j 1): ענף 1293 עברו / 1 דולגה / 0 נכשלו; בסיס 1289 / 1 / 0. ההפרש: 4 הבדיקות החדשות.
analyze ו-format נקיים; ui_lint: 0 הפרות חדשות.
בדקתי בקוד: ctrl+slash לא בשימוש בשום ברירת מחדל, קיצור קשיח או תוסף; openTab לפני NavigateToScreen עובד גם כשמסך ההגדרות עוד לא קיים (takeRequestedTab ב-initState), כמו OpenSettingsTabAction; הביטוי (?<!BACK)SLASH לא נוגע ב-BACKSLASH; Ctrl+numpad-/ מפעיל אותו גם (כינוי קיים ב-key_map).
upstream/dev התקדם (1acfc0d78), אבל merge-tree נקי, ולכן לא נדרש מיזוג.
התנגשויות: 42 PRs פתוחים. אין התנגשות חדשה לעומת upstream/dev.
החלטה פתוחה (כתובה ב-BODY): ברירת מחדל Ctrl+/ מול קיצור אופציונלי בלי ברירת מחדל (palmoni5: "דינמי/אופציונלי"). זה שינוי של שורה אחת.
חזותי: צילומים ב-qa-shots/4452. מומלצת בדיקה קצרה ב-Windows: Ctrl+/ מכל מסך ומתוך דיאלוג פתוח.
