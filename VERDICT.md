READY
QA בלתי תלוי ל-#5220. ענף fix/personal-book-link-bounds-5220, ראש 55574006b29dec9e881d716a2b4eeb796bdf52ef. לא נדחפו קומיטים חדשים, לא נדרש תיקון.
כותרת PR: תיקון issue #5220 — בדיקת גבולות שורות בקישור לספר מתיקייה אישית
Closes #5220. ה-issue פתוח, יש בו תגובה אחת (palmoni5 מ-16.11), ואין PR פתוח שמכסה אותו.
בדיקת ההכשל: בדיקת "שורה 40" נכשלת על upstream/dev 9aea09eba (Bad state: No element, כי הקישור נשמר בלי שגיאה) ועוברת בענף.
שורש: נכון. 3b41a37af הוסיף את התנאי totalLines > 0, ו-insertExternalContentBook רושם 0 לספר אישי. book.totalLines לא נכתב, כפי שההערות דורשות.
ספירת השורות: אותו טקסט (readFileBackedBookText) ואותו פיצול ב-\n כמו בקורא (text_book_bloc, page_shape_screen). המאתר משמש רק את ייבוא הקישורים (user_content_importer / user_import_library), ולכן אין השפעה על פתיחת ספרים.
בדיקות (user_content_import + find_ref_title_heading + custom_folders_import_files + read_file_backed_book_text): בענף 321/0/0, בבסיס 318/0/0.
analyze ו-format נקיים. ui_lint: 80 בענף ו-80 בבסיס, בלי הפרות חדשות.
קונפליקטים: merge-tree מול upstream/dev נקי. מול 48 ה-PR הפתוחים אין קונפליקט חדש.
עלות, מדידה חוזרת שלי: txt של 20K שורות 11–30ms. docx של 2K פסקאות 35–49ms (ריצה קרה 288ms). docx של 20K פסקאות 211–287ms.
החלטה פתוחה: palmoni5 כתב "רק אם זול". docx ענק עובר את רף ה-100ms שבהערות, אבל זה קורה פעם אחת לספר ורק בזמן ייבוא, וגם מחמם את מטמון הקורא. המספרים כתובים בגוף ה-PR כדי שהוא יחליט.
הערות קטנות, לא חוסמות: לא נוספו בדיקות לטווח הסיום (sourceLineNumberEnd) ולמטמון, כי שתיהן משתמשות באותו totalLines. ה-catch תופס רק Exception.
ויזואלי: אין. אין צורך בבדיקה מקומית.
