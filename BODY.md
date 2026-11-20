## מה היה חסר

בתפריט היקף החיפוש בספרייה לא הייתה דרך לחפש רק בספרים הפתוחים בכרטיסיות (סעיף 1 ב-issue; לפי Y-PLONI ב-03.11 ו-palmoni5 ב-16.11: לאסוף ספרים מ-TabsBloc, כולל חלוניות מפוצלות, בלי כפילויות, רק ספרים שאפשר לחפש בהם, ובחירה ריקה לא תהפוך לחיפוש בכל הספרייה).

## הסיבה

זו לא רגרסיה, האפשרות פשוט לא הייתה קיימת. `git log -S "ספרים פתוחים"` ו-`-S openBooks` על `lib/search` לא מוצאים מימוש קודם. `SearchScopeMenuButton` (`lib/search/view/search_scope_menu.dart`) קיבל רק את הבחירה ואת `excludeUserBooks`, ולא ידע אילו ספרים פתוחים.

## השינוי

- `lib/search/utils/open_search_books.dart` – הפונקציה `openSearchableBooks` עוברת על כל החלוניות (`leafPanes`, כולל טאב מפוצל) ב-`TabsBloc` של החלון הנוכחי. היא אוספת `TextBookTab`, וגם `PdfBookTab` כשאינדוקס PDF פעיל. נכנסים רק ספרים ש-`IndexingRepository.isIndexableBook` מאשר, וספר אישי רק כשספרים אישיים באינדקס. כפילויות מוסרות לפי `BookIdentity`.
- `search_dialog.dart` – מעביר את הרשימה לכפתור ההיקף (`openBooks`).
- `search_scope_menu.dart` – שורה חדשה "ספרים פתוחים" אחרי "ספרי יסוד", עם האייקון `OtzariaIcons.book_open_medium_24_regular`:
  - לחיצה בוחרת את ה-facets של הספרים מהעץ הגלוי. ההתאמה היא לפי זהות הספר, כך שגם ספר ששוחזר בכרטיסייה בלי קטגוריה נמצא. ממדי תקופה ומחבר נשמרים.
  - הבחירה היא תמונת מצב ברגע הלחיצה. כך כתוב בשורת המשנה: "בחירה חד־פעמית של הספרים הפתוחים". אפשר לשמור אותה כהיקף שמור כמו כל בחירה אחרת.
  - כשאין ספרים פתוחים השורה מושבתת, עם tooltip "אין ספרים פתוחים".
  - כשאף ספר פתוח לא נמצא בעץ שמחפשים בו, הבחירה לא משתנה (בחירה ריקה פירושה כל הספרייה) ומוצגת הודעה (`LibraryMessages.openBooksNotSearchable`).
  - בחיפוש החכם (`semantic_mode_panel`) לא מועבר `openBooks`, ולכן השורה לא מופיעה שם.
- המחרוזות עוברות דרך `settingsText` ונוספו ל-`settings_en.arb`. הקטלוג נוצר מחדש.

סעיף 2 ב-issue (ברירת מחדל לקרבה, כולל "באותה פסקה") כבר ממומש. סעיף 3 (קפיצת התפריט) לא שוחזר, וכדי לבדוק אותו צריך מהמדווח סרטון וגודל חלון/קנה מידה. לכן ה-PR סוגר רק את סעיף 1.

Refs #2543

## בדיקות

- `test/search/search_scope_menu_open_books_test.dart`, קבוצת 'scope: open books (issue #2543)', 6 בדיקות: שני טאבים, חלונית מפוצלת עם ספר שלישי וספר כפול נותנים 3 facets בדיוק והממד נשמר; בלי ספרים פתוחים השורה מושבתת עם tooltip; ספר אישי מוחרג כשאינו באינדקס; PDF מוחרג כשאינדוקס PDF כבוי; ספר פתוח שאינו בר חיפוש לא הופך לחיפוש בכל הספרייה. על dev הבדיקה נכשלת (ה-API והשורה לא קיימים).
- `flutter test -j 1` על 81 קובצי בדיקה קשורים: כל קובץ שמייבא את הקבצים שנגעו בהם (`search_scope_menu`, ‏`search_dialog`, ‏`library_messages`, ‏`settings_catalogs`/l10n), ועוד `scope_tree`, ‏`search_dimension_filters`, ‏`search_facet_filtering_dimension_scope`, ‏`semantic_search_dialog`, ‏`ui_lint_test`, ‏`small_screens_overflow` ו-`keyboard_shortcuts`:
  - ענף: 1510 עברו, 0 נכשלו, 0 דולגו (כולל 6 הבדיקות החדשות).
  - בסיס (upstream/dev ‏7f2b6c4ec): 1504 עברו, 0 נכשלו, 0 דולגו.
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים על הקבצים שנגעתי בהם. `dart tool/ui_lint_cli.dart`: 0 הפרות חדשות.
- מיזוג מול PR-ים פתוחים: אין קונפליקט חדש, חוץ מ-#5612 בקובץ המחולל `settings_catalogs.g.dart`. שני ה-PR-ים מוסיפים שם שורות סמוכות, והפתרון הוא להריץ שוב `dart run tool/generate_settings_l10n.dart`. ‏#5249 ו-#5600 מתמזגים בלי קונפליקט.
- בדיקה חזותית: צילומי לפני/אחרי של התפריט ברוחב 360, בהיר וכהה, עם גופן Rubik ואייקונים אמיתיים. השורה החדשה מופיעה בין "ספרי יסוד" ל"תקופה", ובמצב מושבת היא אפורה. שאר התפריט לא השתנה.

<!-- SUITE -->
