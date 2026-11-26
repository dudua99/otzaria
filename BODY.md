## מה היה שבור
בקורא: בוחרים בעכבר כמה מילים בתוך שורה אחת ולוחצים Shift+חץ למטה. הבחירה מהעכבר נעלמת, ובמקומה נבחרת שארית השורה. כשהבחירה מהעכבר תופסת יותר משורה אחת, Shift+למטה עובד כמו שצריך. אותו דבר קורה ב-Shift+End וב-Ctrl+Shift+End, וגם ב-Shift+למעלה מבחירה של שורה אחת.

## שורש הבעיה
ב-`SelectableRegion` של Flutter, הרחבה לפי שורות (Shift+למטה/למעלה, Shift+Home/End, Ctrl+Shift+Home/End) מזיזה את הקצה שמגדיל את הבחירה (`_determineIsAdjustingSelectionEnd`). את הקצה הזה Flutter קובע לפי Y. כששני הקצוות באותה שורה, הוא מכריע לפי X ומניח LTR. ב-RTL זה הקצה ההפוך: אחרי גרירה רגילה מימין לשמאל, Shift+למטה מזיז את *תחילת* הבחירה לשורה הבאה, והבחירה המקורית הולכת לאיבוד. בבחירה רב-שורתית ההכרעה לפי Y נכונה, ולכן שם זה עבד.

זה לא רגרסיה. `RtlSelectionShortcuts` (7f37e6ba3) מתקן את כיוון Shift+ימין/שמאל ב-RTL, אבל את המקשים האלה לא יירט מעולם.

## התיקון
`lib/widgets/text/rtl_selection_shortcuts.dart`: מיירטים Shift+למטה/למעלה (וגם Shift+Home/End ו-Ctrl+Shift+Home/End בפלטפורמות של Ctrl). התיקון פועל רק כשיש בחירה של שורה אחת ב-SelectableRegion. במקרה הזה נועלים את הקצה הנכון בצעד תו פנימה וחזרה, אותו priming שכבר משמש בחיצים האופקיים, תחת `rtlSelectionPriming`. אחר כך המקש משוחרר לברירת המחדל של Flutter, והיא מבצעת את ההרחבה עצמה. בשדות קלט, בבחירה רב-שורתית וב-LTR לא נוגעים בכלום. ב-macOS לא נרשמים Home/End, כי שם הם גוללים.

Closes #6048

## בדיקות
- שלוש בדיקות חדשות ב-`test/widgets/text/rtl_selection_shortcuts_test.dart` (שלוש שורות Text נפרדות ב-SelectableRegion, גרירת עכבר אמיתית): Shift+למטה ואז Shift+למעלה, Shift+End ו-Ctrl+Shift+End (Windows), ו-Shift+למעלה מהשורה השנייה. שלושתן נכשלות על upstream/dev ועוברות עם התיקון.
- `flutter test -j 1 test/shortcuts/ test/widgets/text/ test/text_book/view/` ועוד כל הבדיקות שמייבאות את `rtl_selection_shortcuts`/`app_selection_area`:
  - ענף: 2501 עברו, 0 נכשלו, 0 דולגו.
  - בסיס (upstream/dev 4fe1973a4): 2498 עברו, 0 נכשלו, 0 דולגו. ההפרש הוא שלוש הבדיקות החדשות.
- `dart analyze` ו-`dart format --set-exit-if-changed` על הקבצים שנגעתי בהם: נקי. `dart tool/ui_lint_cli.dart`: 80 ממצאים בענף וגם בבסיס, אין חדשים.

<!-- SUITE -->
