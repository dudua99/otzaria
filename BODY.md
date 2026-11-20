## מה היה חסר
בקובץ קישורים בפורמט של אוצריא (`<ספר>_links.json`) לא הייתה דרך לייבא קישור אישי שמסומן בגוף הטקסט ונפתח בלחיצה ישר בספר היעד, כמו קישורי הלינקר הרשמיים:
- `"Conection Type": "linker"` נשמר כמפרש. הוא מופיע בחלונית המפרשים של הספר השני, ובטקסט אין קישור, גם כשיש `start` ו-`end`.
- `reference` מופיע בטקסט, אבל לחיצה עליו פותחת את חלון הקישורים ולא את הספר.

## הסיבה
ההמרה linker ← commentary בייבוא native (008145f0f) מכוונת. palmoni5 הסביר ב-issue שהכלי שמייצר קובצי קישורים לספרים אישיים (צמדי ספר-מפרש) נשען עליה. כתב שם גם שציטוט בטקסט צריך סימון מפורש בקובץ, כדי לא לשבור את קישורי המפרשים הקיימים. סימון כזה לא היה קיים.

## השינוי
- סוג חדש לקובצי `<ספר>_links.json`: ‏`INLINE_LINKER`, או בעברית `"ציטוט בטקסט"`.
- שורה מהסוג הזה חייבת `start` ו-`end` גדול ממנו. שורה בלי טווח כזה נפסלת עם הודעה מפורשת.
- השורה נשמרת ב-user_link כ-`LINKER` עם העוגן. היא לא הופכת למפרש ולא מתהפכת לכיוון בסיס←מפרש. בקורא היא מוצגת כטווח בגוף הטקסט, ולחיצה עליה פותחת את ספר היעד, כמו קישור לינקר רשמי.
- קובצי `linker` ו-`reference` קיימים נקלטים בדיוק כמו קודם.
- לא נדרש שינוי סכמה: לטבלה user_link כבר יש עמודות עוגן.
- נוסף סעיף ל-`docs/personal_databases.md` עם דוגמה.

הבחירה בין סוג חדש לבין דגל: palmoni5 הציע "סוג או דגל חדש". בחרתי בסוג, כי הוא גלוי בקובץ במקום אותו שדה `Conection Type`, ואי אפשר לבלבל אותו עם קובצי `linker` קיימים.

Closes #4308

## בדיקות
- בדיקות חדשות:
  - `user_import_parser_test.dart`: ‏`INLINE_LINKER` ו-"ציטוט בטקסט" נקלטים עם העוגן; שורה בלי `start`/`end`, או עם `end<=start`, נפסלת.
  - `user_content_importer_test.dart`: מקור אישי ויעד רשמי נשמרים כ-`LINKER` עם עוגן 4–9, בלי היפוך.
  - על upstream/dev שתי בדיקות הקליטה נכשלות. בדיקת הפסילה עוברת גם שם, כי שם כל סוג לא מוכר נפסל. בענף כולן עוברות.
- הבדיקה הקיימת "native linker שומר עוגן וקצה טווח במסד" (linker ← commentary) עוברת בלי שינוי.
- `flutter test -j 1` על test/user_content_import, ‏test/models/link_display_heref_test.dart, ‏test/text_book/utils/commentators_context_menu_test.dart ו-test/text_book/view/combined_view:
  - ענף: 547 עוברות, 0 נכשלות.
  - בסיס (upstream/dev): ‏544 עוברות, 0 נכשלות.
- `dart analyze` נקי. `dart format --set-exit-if-changed` נקי. `dart tool/ui_lint_cli.dart` מחזיר פלט זהה לבסיס.
- התנגשויות: `git merge-tree` נקי מול upstream/dev (1acfc0d78), ואין התנגשות חדשה מול אף אחד מ-42 ה-PR הפתוחים. כמה PR נוגעים באותם קבצים, וכולם מתמזגים נקי:
  - ‏#5604: ‏`user_content_importer.dart` ו-`personal_databases.md`.
  - ‏#5615: ‏`user_content_importer.dart`.
  - ‏#5621: ‏`user_import_library.dart`.

<!-- SUITE -->
