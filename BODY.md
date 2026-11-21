## מה היה שבור
משתמש הדביק קישורים ישירים של אוצריא (`otzaria://open/book/…`) במסמך Word, והוסיף את קובץ ה-Word לאוצריא כספר אישי — וכל הקישורים הפכו לטקסט רגיל שאי אפשר ללחוץ עליו. כך גם בקובץ Word שאוצריא עצמה ייצאה (ייצוא Word כותב קישורי מקור מסוג `otzaria://open/book/…`), וכך גם במסמכי ODT.

## סיבת השורש
`safeLinkTarget` מסנן יעדי קישור לפי רשימת היתר (http/https/mailto), וקישורי ספרים של אוצריא (`otzaria://open/book/…`, `otzaria://open/pdf/…`, `book://…`) מותרים רק כשמעבירים `allowBookLinks: true`.
ממיר ה-HTML עושה זאת (4f1d095e8), אבל ממיר ה-Word (תמיכת הקישורים ב-4b8f0fe5f) וממיר ה-ODT (cc646341c) קראו לו בלי הפרמטר — ולכן הקישורים נפסלו. זו אינה רגרסיה; התמיכה פשוט לא הורחבה לפורמטים האלה.

## התיקון
- `docx_to_otzaria.dart`: יעד חיצוני של קישור (OOXML `r:id`, וגם `w:dest` של WordML 2003 / Flat OPC) עובר ב-`allowBookLinks: true`.
- `odt_to_otzaria.dart`: אותו דבר ל-`text:a`.
- גרסאות הממירים עולות (OOXML 16→17, ולכן XML 1016→1017; ODT 7→8) כדי שמסמכים שכבר נפתחו יומרו מחדש ולא יוגשו מהמטמון בלי הקישורים.
- תיעוד `safeLinkTarget` עודכן.

רשימת ההיתר נשארת בטוחה: `javascript:` ושאר פעולות `otzaria://` (למשל `otzaria://open/settings`) עדיין נשארים טקסט רגיל.
אין שינוי חזותי.

מחוץ להיקף: הודעת האבטחה של Word בלחיצה על קישור `otzaria://` בתוך Word נשלטת ע"י Office ולא ע"י אוצריא; קישורי שדה `HYPERLINK` של Word (`w:fldSimple`/`w:instrText`) אינם מומרים כלל — פער נפרד.

Closes #5714

## בדיקות
- בדיקות חדשות: `docx_hyperlinks_test.dart` (קישור ספר/PDF מ-relationship, מ-`w:dest`, פעולת `otzaria://` אחרת נחסמת, וקובץ Word שאוצריא ייצאה נפתח עם קישורי המקור) ו-`odt_to_otzaria_test.dart` (קישור ספר נשמר, הגדרות נחסם). 4 נכשלות על dev ועוברות בענף.
- בדיקות קשורות (23 קבצים: כל מה שמייבא את הקבצים שנגעו + ייצוא Word + html_to_otzaria + html_link_handler):
  - בענף: 784 עברו, 1 נכשלה, 0 דולגו.
  - בבסיס (dev עם קובצי הבדיקה של הענף): 777 עברו, 8 נכשלו (4 החדשות, 3 נעילות הגרסה ב-converter_versions_test שמצפות לגרסאות החדשות, ואותה אחת).
  - הכשל המשותף (`file_sync_document_formats_test.dart: כשל קריאה זמני…`) קיים גם ב-dev ואינו קשור.
- `dart analyze` ו-`dart format` נקיים על הקבצים שנגעו; `tool/ui_lint_cli.dart` — פלט זהה לבסיס.

<!-- SUITE -->
