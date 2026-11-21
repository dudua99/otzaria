READY
QA בלתי תלוי ל-fix/word-import-book-links-5714. ראש הענף: fa2c0982173b063d7365bd58b4e9fe89c0e9170a (ללא שינוי, לא נדרשו קומיטים נוספים; 2 קומיטים מעל upstream/dev acb6759c5 = dev הנוכחי).
כותרת PR: תיקון issue #5714 — קישורי אוצריא נשמרים בייבוא Word ו-ODT
Closes #5714. ה-issue פתוח, 0 תגובות, אין PR פתוח אחר שמטפל בו.
תיקון שורש: safeLinkTarget נקרא בלי allowBookLinks בממירי Word (4b8f0fe5f) ו-ODT (cc646341c), בניגוד ל-HTML (4f1d095e8) — אומת. 3 שורות קוד + העלאת גרסאות ממיר (נחוץ לפסילת המטמון).
רשימת ההיתר נשארת בטוחה: isOtzariaBookLink מתיר רק open/book ו-open/pdf; עוגנים (w:anchor/w:bookmark) לא שונו. צד הקורא (HtmlLinkHandler.handleLink) כבר מטפל ב-otzaria://open/book.
כשל על הבסיס: 4 הבדיקות החדשות נכשלות על dev ועוברות בענף.
בדיקות קשורות (23 קבצים): ענף 784 עברו / 1 נכשלה / 0 דולגו; בסיס 777 / 8 / 0 (4 חדשות + 3 נעילות גרסה + אותו כשל קיים ב-file_sync_document_formats_test).
dart analyze + format נקיים; ui_lint זהה לבסיס.
קונפליקטים: מול dev נקי; 88 PRs פתוחים — אין קונפליקט חדש (9 מתנגשים כבר עם dev).
הערה קלה: הייבוא של package:pdf בבדיקה מופרד בשורה ריקה — קוסמטי, format מקבל.
החלטות פתוחות: אין. בדיקה חזותית: לא נדרשת; מומלץ פעם אחת ידנית לפתוח docx עם קישור otzaria://open/book וללחוץ.
