READY
QA בלתי תלוי ל-prbody/4490b-fix (ענף test/db-busy-refresh-reset-4490).
ראש הענף: 0911d1b4f96387ee90231ff3131d0b066c148b2a, בלי קומיטי תיקון מה-QA. upstream/dev לא זז (4fe1973a4).
כותרת PR: תיקון issue #4490 — הודעה ברורה כשמסד הספרייה תפוס בהחלפה ובעדכון
Closes #4490. סעיפים 1-2 נכנסו ב-#5662, והענף משלים את סעיף 3.
הכישלון על הבסיס אומת: 3 הבדיקות נכשלות על dev עם "Bad state: לא ניתן לשחרר את seforim.db..." ועוברות בענף.
סיבת השורש אומתה ב-git log -S. 85431f6be הוסיף את ה-StateError, ו-4fc0be4e3 הוסיף את DbReadWorkerNotReleased.
התיקון מינימלי: תת-מחלקה של StateError שמחזירה את ההודעה עצמה. מי שתופס StateError או DbReadWorkerNotReleased (library_update_repository:1240) לא מושפע.
בדיקות empty_library + library_update + data_providers ב-j 1:
- ענף: 1082 עברו, 7 דולגו, 5 נכשלו.
- בסיס: 1078 עברו, 7 דולגו, 5 נכשלו.
- הכישלונות זהים בשניהם ונובעים מהרצה כ-root.
קובץ הבדיקות החדש עבר 20 מתוך 20 ריצות.
analyze ו-format נקיים. ui_lint זהה לבסיס (92 שורות).
merge-tree מול dev נקי, ואין קונפליקט חדש מול 41 PRs פתוחים.
החלטה פתוחה: נוסח ההודעה LibraryMessages.libraryDbBusy, לשיקול המתחזקים.
בדיקה חזותית: לא נדרשת, כי השתנה רק טקסט הודעת השגיאה.
