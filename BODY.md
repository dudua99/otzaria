## מה היה שבור
מאז התיקון של #1585, בחירת טקסט בתצוגה הראשית נשמרת כשעוברים לחלון אחר (Alt+Tab ב-Windows). אבל בחלונית המפרשים (כולל ההערות שבה), בחלונית הקישורים ובצורת הדף הבחירה עדיין נמחקה בכל מעבר חלון.

## הסיבה
ב-Windows, כשהחלון מאבד פוקוס, הפוקוס עובר ל-rootScope בזמן שה-lifecycle עדיין `resumed`, ולכן `SelectableRegion` מנקה את הבחירה. התיקון של #1585 (‏33eae9ca0, ושיפורו ב-35cf20810) הוסיף צומת פוקוס שמתעלם מהמצב הזה (`_KeepSelectionOnWindowBlurFocusNode`), אבל רק ל-`SelectionArea` של התצוגה הראשית ב-`combined_book_screen.dart`. שאר אזורי הבחירה בקורא נשארו עם צומת רגיל.

## התיקון
- הצומת הועבר כמו שהוא לקובץ משותף `lib/widgets/misc/keep_selection_focus_node.dart` (`KeepSelectionOnWindowBlurFocusNode`), והתצוגה הראשית משתמשת בו משם.
- חלונית המפרשים (`commentary_list_base.dart`) וההערות שבה (`commentary_list_items.dart`) — צומת שמוחזק ב-State ומשוחרר ב-dispose.
- צורת הדף (`simple_text_viewer.dart`) — `_selectionFocusNode` נוצר עכשיו מהמחלקה הזו. צומת המקלדת (`_resolvedKeyboardFocusNode`) נפרד ולא השתנה.
- חלונית הקישורים (`links_list_view.dart`) — לכל קישור מורחב יש `SelectionArea` משלו, ולכן נוסף `KeepSelectionOnWindowBlurFocus` שמחזיק צומת לכל קישור. המפתח שלו הוא `_selectionRevision`, כך שהצומת מתחדש יחד עם ה-`SelectionArea` כמו קודם. (אותה רשימה משמשת גם בחלונית המפרשים של PDF, ולכן גם שם הבחירה נשמרת. קוד ה-PDF עצמו לא השתנה.)

מעבר פוקוס לרכיב אחר בתוך האפליקציה ממשיך לנקות את הבחירה כרגיל.

Closes #5925

## בדיקות
- בדיקה חדשה `test/text_book/view/selection/keep_selection_on_window_blur_panes_test.dart`, שבנויה כמו בדיקת #1585. היא בודקת את שלוש החלוניות (מפרשים, צורת הדף, קישורים): בוחרים טקסט, מדמים אובדן פוקוס של החלון (`handleViewFocusChanged`) והחזרה אליו, ומוודאים שהבחירה נשארה. אחר כך מעבירים פוקוס לרכיב אחר באפליקציה ומוודאים שהבחירה התנקתה. על dev שלושת המקרים נכשלים, ועל הענף שלושתם עוברים.
- `flutter test -j 1` על 154 קבצים קשורים: selection, page_shape, commentary*, combined_view, widgets/commentary, pdf_commentary*, וכל בדיקה שמייבאת את הקבצים שנגעתי בהם:
  - ענף: ‎1778 עברו, 1 דולג, 0 נכשלו.
  - בסיס (upstream/dev, עם הבדיקה החדשה): ‎1775 עברו, 1 דולג, 3 נכשלו (רק שלוש הבדיקות החדשות).
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים על הקבצים שנגעתי בהם. `dart tool/ui_lint_cli.dart` לא מוסיף הפרות חדשות.

<!-- SUITE -->
