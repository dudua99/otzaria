## מה היה שבור
בשורה שיש בה הערת שוליים מטבלת `line_note` (למשל ריב"ן על יבמות, otzaria://open/book/8484?index=20), כשציטוט לינקר עובר מטקסט השורה אל גוף ההערה, מספר ההערה הוצג פעמיים: פעם בכחול כחלק מקישור הציטוט, ופעם כסמן ההערה המורם.

## הסיבה
אופסטי הציטוט (`link_anchor`) נמדדים על השורה המלאה, ובה גוף כל הערה ב-charPos שלה — אחרי סמן ההערה. ציטוט שנכנס לגוף ההערה כולל לכן גם את ספרות הסמן, ו-`projectAnchorSpans` (מאז 4c5c7c952, "place link anchors by the full line with its note bodies") משאיר בשורה את החלק `[התחלה, charPos)` — כולל הסמן.
`injectLinkAnchorMarkers` עטף את הסמן בקישור הציטוט, ו-`wrapHtmlRanges` פתח את הקישור מחדש בתוך `<a class="book-note-marker">`. בקישור מקונן ה-parser מוציא את הספרות מהסמן הלחיץ: הגליף שבשורה מקבל את צבע הקישור במקום להישאר שקוף, ושכבת הסימונים המורמים מציירת את הסמן שוב.

## התיקון
ב-`injectLinkAnchorMarkers` טווח ציטוט בשורה מדלג על סמני ההערות שבתוכו (`footnote-marker`, `book-note-marker`, `numbered-note-marker`): הוא מתחלק סביבם ולא עוטף אותם. הציטוט עצמו, והחלק שלו בגוף ההערה, לא משתנים.
הבדיקה הקיימת `בשורה השמורה מוזרק רק החלק שמחוץ להערות` ציפתה לסמן עטוף בקישור — כלומר לתקלה עצמה — ועודכנה.

Closes #5030

## בדיקות
- בדיקה חדשה `test/book_common/utils/note_marker_linker_range_test.dart` במסלול הקורא (addInlineNotePreviewLinks ← injectLinkAnchorMarkers ← processText ← הספאנים ושכבת הסימונים המורמים): סופרת כמה פעמים הסמן נראה. נכשלת על dev (מוצג פעמיים) ועוברת עם התיקון.
- 153 קבצי בדיקה שמייבאים את הקובץ ששונה או את מי שמייבא אותו, `flutter test -j 1`:
  - בענף: 2442 עברו, 2 דולגו, 2 נכשלו
  - ב-dev: 2439 עברו, 2 דולגו, 2 נכשלו
  - שני הכשלים זהים בשניהם ואינם קשורים (plugin_bridge_adapter_test — כתיבת קובץ; page_shape_super_commentary_wait_test). ההפרש של 3 הוא הבדיקות החדשות.
- `dart analyze` ו-`dart format` נקיים; `tool/ui_lint_cli.dart` — אין הפרות חדשות (80 לפני ואחרי).

<!-- SUITE -->
