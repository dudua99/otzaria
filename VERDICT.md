READY
QA בלתי תלוי ל-#4466 (פיצ'ר feature-default: הקשר library-book בתפריט ההקשר של ספר בספרייה).
ענף: feat/plugin-library-book-menu-4466, ראש f5a9489f99a7558929f9a9f5949fee85eadacbb8 (3 קומיטים מעל eae19d093).
כותרת PR: תיקון issue #4466 — פריטי תוספים בתפריט ההקשר של ספר בספרייה. ‏Closes #4466.
ה-issue עדיין פתוח (תגובה אחת, של dudua99), ואין PR פתוח שמכסה אותו (search API, 20.11).
קומיט QA שנדחף: f5a9489f9, תיעוד בלבד. ההערה ב-d.ts על ReaderSelection.categoryPath טענה ש-currentRef/currentIndex ב-selection הם null. בפועל הם חסרים ב-selection, ו-null רק באירוע. API_REFERENCE היה מדויק. אין שינוי בקוד.
סקירת הקוד: registry +1 שורה, library_browser +16 שורות, דרך buildPluginContextMenuSection הקיים. categoryPath זהה בצורתו ל-Category.path של library.getTree. פעולה דקלרטיבית רצה דרך dispatchSelectionAction ($selection), כמו בשאר פריטי התפריט. אין רגרסיה כשאין פריטי library-book: הפונקציה מחזירה רשימה ריקה.
כישלון על הבסיס: 5 הבדיקות החדשות נכשלות על eae19d093 (error.unsupported_context) ועוברות בענף (45/0 מול 40/5 בשני הקבצים).
בדיקות (42 קבצים קשורים): ענף 996/1/2 (עברו/נכשלו/דולגו), בסיס 991/1/2. הכישלון זהה בשני הצדדים: plugin_bridge_adapter fs, שנכשל בהרצה כ-root.
analyze ו-format נקיים. פלט ui_lint זהה לבסיס.
קונפליקטים: merge-tree נקי מול upstream/dev העדכני (090d38534, אין בו שינוי בקבצים האלה). מול 48 ה-PR-ים הפתוחים אין קונפליקט חדש. ל-#5634 יש קונפליקט ב-personal_notes_database.dart, והוא קיים גם מול dev ולא קשור לשינוי.
החלטה פתוחה: ההחלטות של Nathaniel-260 לא הוכרעו. הסטייה מ-notes (רק תפריט ההקשר, בלי ⋮) סבירה ומתועדת ב-BODY: ‏BookActionsMenuButton נעלם כשאין פעולה מובנית.
מומלצת בדיקה חזותית מקומית עם תוסף אמיתי: לחיצה ימנית על ספר בעץ. הצילומים בענף qa-shots/4466.
