READY
QA בלתי תלוי לענף fix/multi-author-links-4231 (prbody/4231b-fix). לא נדרשו commits נוספים.
ראש הענף: ab38e25196a985f3a1bb66cd0441200d4836dac6 (2 commits מעל upstream/dev 4fe1973a4, ללא שינוי).
כותרת PR: תיקון issue #4231 — קישור לכל מחבר בספר של כמה מחברים. Closes #4231 (ה-issue פתוח; אין PR פתוח אחר עליו).
כשל על הבסיס: library_multi_author_test.dart הועתק ל-upstream/dev — 1 עברה, 2 נכשלו; בענף עוברות 3/3, ויחד עם library_search_result_links_test — 14/14.
שורש: 1472ca6d0 (`book.author?.trim() == author`) — אומת.
סקירת קוד: כל צרכני selectBookAuthorsMap (רשמי, אישי, מצורף) עוברים דרך authorFromDatabase שמפצל במפריד \u001F ומחבר ל-", " לתצוגה — אין צרכן נוסף שמציג את המחרוזת הגולמית. BookFacetMetadataCache משתמש במפה נפרדת (List<String>), לא מושפע. TextBook.copyWith שומר את authors. PdfBook שנבנה מחדש ב-pdf_book_bloc / HebrewBooks מקבל authors=[author] — אין השפעה על סינון הספרייה.
בדיקות (test/library, data_providers, models, migration, utils, attached_libraries, indexing; -j 1):
- ענף: 5142 עברו, 64 דולגו, 2 נכשלו
- בסיס: 5136 עברו, 64 דולגו, 2 נכשלו
- שתי הנכשלות זהות בשניהם וסביבתיות (wal_fallback_connection_test — root; file_sync_document_formats_test).
dart analyze + format נקיים על כל הקבצים שנגעו; ui_lint זהה לבסיס.
קונפליקטים: merge-tree נקי מול dev; אין קונפליקט חדש מול 41 ה-PR הפתוחים.
החלטות פתוחות: אין.
בדיקה חזותית: צילומים ב-qa-shots/4231-v2; מומלץ מבט מקומי בשורת ספר של שני מחברים (שם ארוך בקישור השני נקטע מוקדם יותר כי כל קישור Flexible).
