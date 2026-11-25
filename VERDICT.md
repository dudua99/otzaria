READY
ראש הענף: 84dddabed1ff042ebbde012f95b707713fd32d1a (fix/commentary-load-retry-5744-v2)
כותרת ה-PR (ללא שינוי): תיקון issue #5744 — מפרש שנכשל בטעינה בצורת הדף נטען שוב · Closes #5744
"לפני" = 61bb27ed3, הקוד הקודם של ה-PR ממוזג עם dev העדכני.

נקודה 1 (גלישה בטור תחתון נמוך): page_shape_commentary_load_failure_small_column_test.dart
  לפני: נכשלת ("RenderFlex overflowed by 44 pixels"). אחרי: עוברת.
  התיקון: Flex אופקי בתוך FittedBox מתחת ל-120 פיקסלים, ועמודה בתוך SingleChildScrollView מעל זה. אין רכיב חדש.
נקודה 2 (כשל SQLite נבלע והטור מוסתר): page_shape_commentary_db_read_error_test.dart, בדיקה 1, על מסד אמיתי בלי טבלת line
  לפני: נכשלת (הטור מוסתר). אחרי: עוברת (הודעה ו"נסה שוב"). בנוסף נבדק ש-getBookTextFromDb עדיין מחזירה null לשאר הקוראים.
  התיקון: throwReadErrors (ברירת מחדל false) ב-getBookTextRangeFromDb, ו-true בקריאה הראשונה של צורת הדף.
מפרש חסר באמת: אותו קובץ, בדיקה 2. עוברת לפני ואחרי, ההתנהגות לא השתנתה.

ספירות (138 קבצים קשורים, -j 1): ענף 1833/5/6 (עוברות/מדולגות/נכשלות), dev (135 קבצים) 1829/5/6.
  אותן 6 כשלונות בשני הצדדים, והן תלויות בסביבת root (library_update_repository x4, navigation_repository x1, page_shape_super_commentary_wait x1).
analyze ו-format נקיים. ui_lint: 0 הפרות חדשות, הדוח זהה ל-dev.
merge-tree: נקי מול dev. מול PRs 5740, 5777, 5821, 5823, 5865, 5876 אין התנגשות חדשה.
  רשימת ה-PRs היא קירוב: refs של PRs שלא מוזגו, עם commit מ-45 הימים האחרונים, שנוגעים באותם קבצים. ה-API של upstream חסום בסשן.
מגבלה: לא ניתן היה לקרוא את תגובת הסגירה ואת issue #5744 עצמם, כי GitHub API ודף ה-PR של Otzaria/otzaria חסומים בסשן. העבודה נעשתה לפי הסיכום ב-notes/rework-2511.md.
החלטות פתוחות:
  (א) getBookTextFromDb ו-DatabaseLibraryProvider.getBookText לא שונו, כדי לא ליצור התנגשות חדשה עם #5876 שכותב את getBookText מחדש.
      נשאר מקרה קצה אחד: הספר הראשי לא נטען תוך 5 שניות, ואז הקריאה המלאה עדיין בולעת כשל. אפשר להוסיף את הפרמטר ל-getBookLines אחרי #5876.
  (ב) DESIGN_SYSTEM ממליץ על OtzariaErrorState למצב שגיאה. נשארתי עם הטקסט והכפתור הקיימים לפי "בלי מושגי UI חדשים", ו-ui_lint לא מתריע.
מומלץ לבדוק גם ויזואלית: טור תחתון נמוך עם מפרש שנכשל.
