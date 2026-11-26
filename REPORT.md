# דוח פתרון קונפליקטים — 26.11

Flutter 3.47.7. מוזג upstream/dev (`4fe1973a4`) לתוך כל ענף בקומיט מיזוג (בלי rebase/force-push).

## 1. feat/at-scope-author-5502-v2 (PR #5681, issue #5502)

- **HEAD חדש:** `7ec1616af81c56ea247cda5601e05b0a56a34f06`
- **קונפליקט:** `lib/search/view/search_dialog.dart`, ב-`_performSemanticSearch`.
- **מה שינה dev** (11dcb5f13, fd4f0a756, b43fbfdf4, 1c517b9fd — "חיפוש חכם גם בתוך ספר, לפי הספרים שיש להם וקטורים"): הפונקציה נבנתה מחדש — ספר נעול (`bookFacet`), טעינה אסינכרונית של הספרים המכוסים (`loadCoveredBookFilePaths`) עם revision, ובדיקת התמיכה עברה לסוף ומשתמשת גם ב-`isCoveredFacet`.
- **מה שינה ה-PR:** במקום `parsedCategory.facets!` — `facetsKeepingAuthors(...)`, כך שספר מחבר בלי וקטורים (אישי/מצורף) נשמט ואינו פוסל את ההיקף.
- **פתרון:** נלקח מבנה dev כמות שהוא. בתוך בלוק הבדיקה (`bookFacet == null`), אחרי חישוב `isCoveredFacet`, הוגדר פרדיקט `isSupported` אחד; אם יש `@` (`parsedCategory?.facets != null`) ההיקף נבנה מחדש מ-`facetsKeepingAuthors(isSupported)` + ממדי `_scopeSelection`, ואז `selection.every(isSupported)` כמו ב-dev. כך סינון ספרי המחבר משתמש גם בבדיקת הכיסוי החדשה של dev. בדיקת הכיסוי (`needsSemanticScopeCoverage`) רצה על ההיקף המלא לפני הסינון — אותה תוצאה, כי כל facet של ספר/קטגוריה מפעיל אותה.
- **בדיקות** (`flutter test test/search test/semantic_search`):
  - ענף: **1769 עברו, 4 דולגו, 1 נכשלה**
  - dev: **1759 עברו, 4 דולגו, 1 נכשלה**
  - הכישלון זהה בשניהם (`semantic_models_test.dart`: "מחיקה שנכשלה באמצע משאירה את סימן הבעלות") — בדיקת הרשאות קבצים שנכשלת כשרצים כ-root בסביבה. ההפרש (+10) הוא בדיקות ה-PR.
  - בדיקות ה-PR בלבד (`semantic_search_dialog_test.dart` + `category_query_parser_test.dart`): 120/120.
- `dart analyze lib test`: 0 בעיות (ענף ו-dev). `dart format`: נקי. `ui_lint`: 640 סה"כ, 0 חדשות (זהה ל-dev).

## 2. feat/commentary-toggle-chevron-2835 (PR #5688, issue #2835)

- **HEAD חדש:** `3cbbe111f391293a8bc0422a0f215d17f7be856e`
- **קונפליקט:** `lib/text_book/view/combined_view/combined_book_screen.dart`. ה-PR עטף את ה-`Listener` של פריט הקריאה ב-`_withCommentaryToggle(...)`, ולכן כל הבלוק (~250 שורות) הוזח; dev הוסיף באותו בלוק `ConstrainedBox` עם `minHeight` לקטע שטרם נטען (`segment?.isLoaded == false`, לפי `lineHeightForBook`) — מכאן הקונפליקט. ב-dev גם שינויים נוספים בקובץ (lineHeight לפי ספר, `KeepSelectionOnWindowBlurFocusNode` שהוצא לקובץ, `openingReadingAnchor`, `_selectionGutter` לפי `kTextColumnMinMargin` ועוד) — כולם התמזגו.
- **פתרון:** נלקחה גרסת dev של הקובץ, ושינויי ה-PR הוחלו עליה מחדש מדיף שמתעלם מרווחים (imports, `_commentaryToggleWidth`, `_commentaryToggleLine`, `crossAxisPadding`, העטיפה ב-`_withCommentaryToggle`, הדילוג ב-`onSingleTap` כשהפתיחה בלחיצה כבויה, והמתודה `_withCommentaryToggle`), ואז `dart format`. נבדק ב-`diff -w` מול dev שההבדלים הם רק שינויי ה-PR, וה-`ConstrainedBox` של dev נשמר בתוך העטיפה.
- **קבצים שהתמזגו אוטומטית ונבדקו:** `settings_bloc/event/repository/state`, `design_settings_tab.dart`, `mock_settings_repository.mocks.dart` — רק התוספות של ה-PR מעל dev (מפתח `key-commentary-opens-on-text-tap`, ברירת מחדל true, איפוס, מתג בהגדרות). `settings_en.arb` השתנה במיזוג → הורץ `dart run tool/generate_settings_l10n.dart`: "Catalog up-to-date" (1878 רשומות) — הקטלוג שהתמזג זהה לפלט המחולל, לא נדרש שינוי.
- **התאמה נוספת:** בדיקת ה-PR (`commentary_toggle_chevron_test.dart`) העבירה `pinLeftPane: false` ל-`TextBookLoaded`; dev הסיר את הפרמטר (d04aa6bef, והסיר אותו מבדיקותיו ב-fb2f4e1e4/ecefec238) — השורה הוסרה גם כאן.
- **בדיקות** (`flutter test test/text_book test/settings`):
  - ענף: **4163 עברו, 3 דולגו, 2 נכשלו**
  - dev: **4157 עברו, 3 דולגו, 3 נכשלו**
  - 2 הכישלונות בענף נכשלים גם ב-dev, שניהם בדיקות הרשאת כתיבה שאינן חלות על root (`personal_books_import_service_test` "תיקיית יעד ללא הרשאת כתיבה", `orphan_library_service_test` "כשל בסריקת ענף"). הכישלון השלישי ב-dev (`page_shape_super_commentary_wait_test`) עבר בענף — נראה flaky. ההפרש: +5 בדיקות ה-PR, +1 הבדיקה ה-flaky.
  - בדיקות ה-PR בלבד: 5/5.
- `dart analyze lib test`: 0 בעיות. `dart format`: נקי בקבצים שנגעו (`test/text_book/toc_filter_test.dart` לא מעוצב — קיים כך גם ב-dev, לא נגעתי). `ui_lint`: 640, 0 חדשות.

## ספקות
- ענף 2: כשהמפרשים מתחת לטקסט, רצועת החץ (32px) נוספת לכל פסקה — כולל הקטע שטרם נטען שעכשיו מקבל `minHeight` מ-dev. לא נבדק ויזואלית שהמציין והחץ מתיישרים יפה בקטע ממתין; לוגית זה רק `Row` עם `Expanded`, ולכן לא צפויה בעיה.
- ענף 1: בחיפוש חכם בלבד עם `@מחבר`, ספר מחבר רשמי שאין לו וקטורים (לפי רשימת הכיסוי של dev) נשמט עכשיו גם הוא במקום לפסול את כל ההיקף — הרחבה טבעית של כוונת ה-PR מעל הכיסוי החדש של dev. אם כל ספרי המחבר לא מכוסים — נשארת השגיאה "היקף לא נתמך" כמו קודם.
