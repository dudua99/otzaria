READY
ענף: fix/word-import-book-links-5714, ראש fa2c0982173b063d7365bd58b4e9fe89c0e9170a (2 קומיטים מעל upstream/dev acb6759c5).
כותרת PR: תיקון issue #5714 — קישורי אוצריא נשמרים בייבוא Word ו-ODT
סיבה: ממירי Word (4b8f0fe5f) ו-ODT (cc646341c) קראו ל-safeLinkTarget בלי allowBookLinks (בניגוד ל-HTML, 4f1d095e8) — קישורי otzaria://open/book נפסלו.
תיקון: allowBookLinks: true ליעדים חיצוניים ב-docx (r:id, w:dest) וב-ODT; העלאת גרסאות ממיר (OOXML 17, XML 1017, ODT 8) לרענון המטמון. הטביעות בבדיקת הגרסאות לא השתנו (במסמך הדגימה אין קישורי אוצריא).
בטיחות: javascript: ו-otzaria://open/settings עדיין נחסמים (בדיקה).
בדיקות קשורות (21 קבצים): ענף 706 עברו / 1 נכשלה / 0 דולגו; בסיס 702 / 5 (4 חדשות + אותו כשל קיים ב-file_sync_document_formats_test).
analyze/format נקיים; ui_lint זהה לבסיס.
קונפליקטים: dev נקי; 88 PRs פתוחים — אין קונפליקט חדש (9 PRs מתנגשים כבר עם dev, בקבצים אחרים).
החלטות פתוחות: אין. מחוץ להיקף (מוזכר ב-BODY): הודעת האבטחה של Word, שדות HYPERLINK של Word.
בדיקה חזותית: לא נדרשת (ממיר בלבד). מומלץ לבדוק ידנית פעם אחת קובץ docx עם קישור ישיר ולוודא שהלחיצה פותחת את הספר.
