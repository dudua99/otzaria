## מה היה איטי
בזמן קריאה עם חלונית תוכן העניינים פתוחה, כל פעם שהגלילה בספר חוצה כותרת (או כשבוחרים שורה בכותרת אחרת) — כל השורות הגלויות בעץ (כ-43 בחלונית רגילה) נבנו מחדש עם כל תת-העץ שלהן (Material, InkWell, Focus וכו'), אף שרק הסימון של שתי שורות משתנה: זו שהייתה פעילה וזו שנעשתה פעילה.

## הסיבה
ב-`lib/text_book/view/toc_navigator_screen.dart` ה-`buildWhen` של ה-BlocBuilder של העץ כלל את `_activeTocIndex(previous) != _activeTocIndex(current)` (מאז bd662b47f, שצמצם את הבנייה לגלילה שמשנה כותרת — צעד נכון, אבל כל שינוי כותרת עדיין בנה את כל הרשימה). הסימון חושב בכל שורה מתוך `activeIndex` שהועבר מה-builder.
זו אותה תבנית שתוקנה בעבר בחיפוש בתוך הספר (`text_book_search_screen.dart` מחזיק את הבחירה ב-ValueNotifier), ובתוכן העניינים זה לא נעשה.

## התיקון
- השורה המסומנת (`_highlightedEntryIndex ?? הכותרת הפעילה הגלויה`, כולל המיפוי לאב גלוי כשהפתיחה האוטומטית כבויה) נשמרת ב-`ValueNotifier<int?>`.
- `_activeTocIndex` הוסר מה-`buildWhen`; ה-BlocListener (שכבר מאזין לשינוי השורה הנבחרת / הגלויה) מעדכן את ה-notifier. גם ה-builder מעדכן אותו, מה-state הנוכחי של ה-bloc (ה-state של ה-BlocBuilder נשאר ישן כשהכותרת זזה בלי build — למשל כשהפתיחה האוטומטית פותחת ענף).
- כל שורה עטופה ב-ValueListenableBuilder שמחזיר את אותו מופע של `NavTreeTile` כל עוד הסימון שלה לא השתנה, כך ש-Flutter מדלג עליה.
- הדפדוף בחיצים בתוצאות איתור הכותרת מעדכן את ה-notifier במקום `setState` על כל העץ.

אין שינוי בהתנהגות או במראה: פתיחה אוטומטית של הענף הפעיל, כיווץ ידני (#4433, #4550), גלילה לכותרת הפעילה, איתור ושמות קדושים — ללא שינוי.

## מדידה
`flutter test` (debug), `debugOnRebuildDirtyWidget`, עץ של 60 סימנים × 10 סעיפים, חלונית 400×800, 6 מעברי כותרת:
- לפני: 1549–1552 בניות של וידג'טים לכל מעבר כותרת; frame של כ-76–93 ms.
- אחרי: 82–86 בניות לכל מעבר (‎-94%); frame של כ-8.5–11 ms.

תבניות דומות שלא נגעתי בהן: `alt_toc_sidebar_view.dart` ותצוגת ה-outline של PDF.

Refs #1692

## בדיקות
- בדיקה חדשה ב-`toc_navigator_screen_test.dart`: מעבר כותרת פעילה בונה מחדש לכל היותר 2 שורות (על dev: ‏35), ובדיוק שורה אחת מסומנת — הכותרת החדשה. נכשלת על dev ועוברת כאן.
- קבצי הבדיקה של תוכן העניינים וכל מה שמייבא את הקובץ (`toc_navigator_screen`, `toc_navigator_expansion_menu`, `toc_navigator_holy_names`, `toc_navigator_internals`, `text_book_nav_panel_preserved`, `text_book_screen_actions`, `ref_helper`, `adaptive_side_pane`, `test/perf`): בענף 226 עברו, 0 נכשלו, 0 דולגו; ב-dev ‏225 עברו, 1 נכשל (הבדיקה החדשה).
- כל `test/text_book`: בענף 2998 עברו, 1 דולג, 1 נכשל; ב-dev ‏2998 עברו, 1 דולג, 1 נכשל. ב-dev נכשלה הבדיקה החדשה; בענף נכשלה `page_shape_super_commentary_wait_test` ("מפרש שמור שאינו ברשימה..."), שאינה תלויה בתוכן העניינים ונכשלת לסירוגין גם על dev כשמריצים אותה לבד (בדיקה תלויה בתזמון).
- `dart analyze` ו-`dart format` על הקבצים ששונו: נקיים. `tool/ui_lint`: הפלט זהה ל-dev.

<!-- SUITE -->
