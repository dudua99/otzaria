# follow-up #5858 — קיצורים קבועים מול קיצורים מותאמים

**VERDICT: READY**

ענף: `fix/followup-5858` · HEAD: `f12635ee38fc58af9e1606926375ee588df429e8` (2 קומיטים מעל upstream/dev `c400e543f`)
כותרת PR: תיקון issue #5819 — קיצור של הספר על מקש קבוע מפעיל גם את הקיצור הקבוע

## אילו מקשים
כל המקשים בכרטיס (Ctrl+Tab, Ctrl+Shift+Tab, Ctrl+1–8, Ctrl+9, F11, Esc) — אבל **רק מול קיצורים של מסך הספר** (הגדלה/הקטנה/איפוס טקסט, הדפסה, סימניה, הערה, חיפוש בספר, דיווח טעות, PDF/טקסט, העתקת קישורים, פקודות תוספים בספר).
- Ctrl+Tab / Ctrl+Shift+Tab — `lib/shortcuts/keyboard_shortcuts.dart:681`
- Ctrl+1..9 — `lib/shortcuts/keyboard_shortcuts.dart:702`
- F11 — `lib/shortcuts/keyboard_shortcuts.dart:717`
- Esc (יציאה ממסך מלא) — `lib/shortcuts/keyboard_shortcuts.dart:727`, ובקורא במסך מלא דרך `:150`
- קיצורי הספר — `lib/text_book/view/text_book_screen.dart:1062` (`KeyboardListener`) → `_handleGlobalKeyEvent` `:2682`

סדר הטיפול: early handler (קיצורים דינמיים) → עץ הפוקוס (CallbackShortcuts של PDF/כלים, KeyboardListener של הספר, FocusScope של KeyboardShortcuts) → late handler (`:84`). בתוך `_handleKeyEvent` הקבועים נבדקים **אחרי** כל הקיצורים המותאמים, ולכן קיצור גלובלי, דינמי, PDF או של כלי על אותו מקש גובר (נבדק: ctrl+tab/ctrl+2/ctrl+9/f11/escape על "איתור" — הפעולה רצה, הקבוע לא). **אין לחסום את המקשים האלה בעורך.**
החריג: `KeyboardListener` של הספר מחזיר תמיד ignored ומשליך את ה-`true` של `_handleGlobalKeyEvent`, ולכן המקש ממשיך ל-late handler והקבוע **רץ גם הוא**: הגדלת טקסט על Ctrl+2 → גם מעבר לכרטיסייה 2; על F11 → גם מסך מלא; על Esc במסך מלא → גם יציאה.

## שורש
`_handleGlobalKeyEvent` מחזיר bool "טופל" (מאז 74b8d2ae4/2a82cd9a0), אבל עטוף ב-`KeyboardListener` שאינו יכול לעצור אירוע. נעשה לבאג כשנוספו הקבועים: Ctrl+Tab/F11 (fcde0d0e7), Ctrl+1..9 (d943d9c7a, שמתעד במפורש שקיצור מותאם צריך לקבל קדימות).

## תיקון
`KeyboardListener` → `Focus` עם אותו FocusNode, שמחזיר `handled` כשהספר טיפל במקש. לא שונה סדר הטיפול הגלובלי ולא נחסם דבר בעורך (חסימה הייתה פוסלת שימושים תקינים במקשים שבהם המשתמש כבר גובר). בבדיקת #3619 עודכן ה-finder מ-KeyboardListener ל-Focus.

## בדיקות
- בדיקה חדשה (5 מקרים): נכשלת 5/5 על upstream/dev, עוברת 5/5 בענף.
- test/shortcuts, test/text_book, test/settings/tabs, test/tabs + 5 קבצים קשורים (`flutter test -j 1`):
  - ענף: 4178 עברו, 1 דולג, 0 נכשלו
  - upstream/dev: 4172 עברו, 1 דולג, 1 נכשל
  - ההפרש: 5 בדיקות חדשות + `page_shape_super_commentary_wait_test` שהוא flaky בשני הצדדים (3 הרצות: base נכשל 2/3, ענף נכשל 2/3) ואינו קשור.
- dart analyze: נקי · dart format: נקי · ui_lint: פלט זהה ל-base.
- התנגשויות: 78 PR פתוחים, 11 מתנגשים גם מול base וגם מול הענף עם אותם קבצים — אין התנגשות חדשה.

## לשיקול
- שינוי התנהגות מכוון: Esc בקורא במסך מלא כשיש הדגשת חיפוש מנקה רק את ההדגשה (לחיצה שנייה יוצאת), כפי שהיה לפני e0fc9b7ad.
- הערות ישנות שמזכירות "ה-KeyboardListener של הספר" (`simple_text_viewer.dart`, `keyboard_shortcuts.dart:382`) לא עודכנו כדי לשמור על diff קטן.
- אין שינוי חזותי.
