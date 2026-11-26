READY
QA בלתי תלוי. לא נדרשו קומיטים נוספים. הענף לא שונה.
ענף: fix/hebrewbooks-download-after-dialog-close-5983, ראש 05b3a0d29085f72af9249e8b9d8bf68ea624274d
כותרת PR: תיקון issue #5983 — הורדת היברובוקס מוצעת לשמירה גם אחרי סגירת הדיאלוג
Closes #5983 (ה-issue פתוח, בלי תגובות ובלי PR פתוח שמכסה אותו, נבדק 26.11)
שורש: אומת ב-git show 416efe7e7: השומר `if (!mounted) return;` נוסף לפני saveFileWithExtension כדי להעביר context.
התיקון הוא בשורש ומינימלי: שורה אחת נמחקה ושורה אחת שונתה. saveFileWithExtension כבר נופלת ל-navigatorKey, כולל אימות סיסמת סייפר.
הוכחת כשל בבסיס: הבדיקה מהענף הועתקה ל-worktree של upstream/dev (4fe1973a4) ונכשלה שם (+127 ~3 -1). בענף היא עוברת.
בדיקות (hebrew_book_download, hebrew_books_download_service, library_multi_select_open, save_file_with_extension, -j 1): בענף 128 עברו, 3 דולגו, 0 נכשלו. בבסיס 127 עברו, 3 דולגו, 1 נכשל (הבדיקה החדשה).
analyze ו-format נקיים. פלט ui_lint זהה לבסיס.
קונפליקטים: merge-tree מול upstream/dev נקי. אף אחד מ-41 ה-PR הפתוחים לא נוגע בקבצים.
רגרסיות: ה-setState וה-snack כבר מוגנים (mounted / UiSnack גלובלי). כשהדיאלוג פתוח ההתנהגות זהה לקודם.
החלטות פתוחות: אין.
בדיקה חזותית: אין שינוי חזותי. מומלץ לבדוק ידנית ב-Windows: לסגור את הדיאלוג באמצע ההורדה בלי תיקייה מוגדרת, ולוודא שנפתח "שמירה בשם".
