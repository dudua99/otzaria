READY
פיצ'ר #5271 (מיילסטון 0.9.99, משויך ל-dudua99): direction ב-library.getLinks — 'outgoing' (ברירת מחדל, ללא שינוי) / 'incoming' / 'both'.
ה-issue פתוח, אין PR פתוח שמזכיר אותו.
ענף: feat/plugin-incoming-links-5271, ראש e75342c25e5631a10db349d3661bf281fb4f1d6d (2 קומיטים מעל upstream/dev 7f2b6c4ec: בדיקה ← מימוש).
כותרת ה-PR: תיקון issue #5271 — קישורים נכנסים לתוספים ב-library.getLinks
המימוש: מצב raw ב-_loadInverseSourceRows (בלי שכתוב ל-SOURCE, בלי סינון סוגים, צד מדוכא וקישור בתוך הספר; עדיין חסום ב-bookId+חלון), דרך getLinksForBookRange(incoming: true) ו-TextBookRepository.getIncomingLinksInRange החדשה. getBookLinksInRange והתצוגה לא השתנו. תיעוד: API_REFERENCE, d.ts, README.
החלטות שלא הוכרעו (מפורטות ב-BODY): getRawLinks לא שונה (ה-issue ביקש getLinks); קישורי-משתמש ו-external_link לא בנכנסים; ב-'both' הפניה שמוצגת גם בצד השני עשויה להופיע פעמיים (מתועד); ממומש בלי סינון link_suppressed_side בנכנסים.
נכשל על הבסיס: הקובץ החדש incoming_links_range_test לא מתקמפל (אין incoming); בקבוצת האדפטר 7 מתוך 8 הבדיקות החדשות נכשלות. בענף: כולן עוברות.
חבילה קשורה (97 נתיבים): ענף 5928 עברו / 6 נכשלו / 23 דולגו; בסיס 5918 / 14 / 23. 6 הכשלונות זהים בבסיס (library_update ×4 כ-root, fs write, page_shape_super_commentary_wait).
analyze/format נקי; ui_lint זהה לבסיס.
קונפליקטים: merge-tree מול dev נקי; 43 PRs פתוחים — אין קונפליקט חדש. חופפים בקבצים: #5628, #5396, #5551, #3442 (ל-#3442 קונפליקט קיים גם מול dev).
חזותי: אין. בדיקה מקומית לא נדרשת; כדאי לנסות פעם getLinks(direction:'incoming', connectionTypes:['MESORAT_HASHAS']) על seforim.db אמיתי.
