## מה היה שבור
בשורה שיש בה הערת שוליים מטבלת `line_note` (למשל ריב"ן על יבמות, otzaria://open/book/8484?index=20), כשציטוט לינקר עובר מטקסט השורה אל גוף ההערה, מספר ההערה הוצג פעמיים: פעם בכחול כחלק מקישור הציטוט, ופעם כסמן ההערה המורם.

## הסיבה
אופסטי הציטוט (`link_anchor`) נמדדים על השורה המלאה, ובה גוף כל הערה ב-charPos שלה — אחרי סמן ההערה. ציטוט שנכנס לגוף ההערה כולל לכן גם את ספרות הסמן, ו-`projectAnchorSpans` (מאז 4c5c7c952, "place link anchors by the full line with its note bodies") משאיר בשורה את החלק `[התחלה, charPos)` — כולל הסמן.
`injectLinkAnchorMarkers` עטף את הסמן בקישור הציטוט, ו-`wrapHtmlRanges` פתח את הקישור מחדש בתוך `<a class="book-note-marker">`. בקישור מקונן הספרות יוצאות מהסמן הלחיץ: הגליף שבשורה מקבל את צבע הקישור במקום להישאר שקוף, ושכבת הסימונים המורמים מציירת את הסמן שוב.

## התיקון
ב-`injectLinkAnchorMarkers` טווח ציטוט בשורה מדלג על סמני ההערות שבתוכו (`footnote-marker`, `book-note-marker`, `numbered-note-marker`): הוא מתחלק סביבם ולא עוטף אותם. הציטוט עצמו, והחלק שלו בגוף ההערה, לא משתנים; `wrapHtmlRanges` ושאר הקוראים שלו (הדגשות, הערות אישיות) לא שונו.
הבדיקה הקיימת `בשורה השמורה מוזרק רק החלק שמחוץ להערות` (מ-4c5c7c952) ציפתה לסמן עטוף בקישור — תיעוד של התקלה עצמה, לא התנהגות מכוונת — ועודכנה.

| לפני | אחרי |
|---|---|
| ![לפני](https://raw.githubusercontent.com/dudua99/otzaria/qa-shots/5030/before.png) | ![אחרי](https://raw.githubusercontent.com/dudua99/otzaria/qa-shots/5030/after.png) |

Closes #5030

## בדיקות
- בדיקה חדשה `test/book_common/utils/note_marker_linker_range_test.dart` במסלול הקורא (addInlineNotePreviewLinks ← injectLinkAnchorMarkers ← processText ← הספאנים ושכבת הסימונים המורמים): סופרת כמה פעמים הסמן נראה. על dev שתיים מהשלוש נכשלות (הסמן נראה פעמיים); עם התיקון כולן עוברות.
- 163 קבצי בדיקה שמייבאים את הקובץ ששונה או את מי שמייבא אותו, `flutter test -j 1`:
  - הענף ממוזג עם dev: 2594 עברו, 2 דולגו, 2 נכשלו
  - dev: 2592 עברו, 2 דולגו, 1 נכשל
  - כשל משותף: `plugin_bridge_adapter_test` (כתיבת קובץ, תלוי סביבה). `page_shape_super_commentary_wait_test` נכשל גם על dev כשמריצים אותו לבד (3 מתוך 3) — תלוי תזמון, לא קשור. ההפרש: +3 הבדיקות החדשות, −1 הבדיקה התלויה בתזמון.
- `dart analyze` ו-`dart format` נקיים; `tool/ui_lint_cli.dart` — 0 הפרות חדשות (653 לפני ואחרי).

<!-- SUITE -->
