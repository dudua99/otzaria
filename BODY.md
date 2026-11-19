## מה היה שבור
בהגדרות ← תצוגת הטקסט, מתחת להגדרה "שאר שמות הקודש", הופיע התיאור "אלהים, שדי, צבאות ועוד — בספרים שבהם השמות מסומנים", כלומר שמות הקודש עצמם נכתבו במפורש בממשק.

## שורש הבעיה
התיאור נכתב כך כשההגדרה נוספה, ב-43917b327 ("שמות הקודש מהמסד…", issue #1985). המחרוזת נמצאת ב-`lib/text_display/view/text_display_profile_editor.dart`, ומשמשת גם כמפתח ב-`settings_en.arb`.

## התיקון
התיאור הוחלף בכינויים, כפי שהוצע בדיון: "אלקים, ש-די, צבקות ועוד — בספרים שבהם השמות מסומנים".
- `text_display_profile_editor.dart`: שורה אחת.
- `settings_en.arb`: עודכן המפתח. התרגום לאנגלית ("Elokim, Tzevakos and more…") כבר היה בכינויים ולא השתנה.
- `settings_catalogs.g.dart`: חולל מחדש (`dart run tool/generate_settings_l10n.dart`).

במקומות אחרים שמציגים את ההגדרה (ייצוא, קיצורי דרך דינמיים, הדפסה) מופיעה רק הכותרת, בלי התיאור, ולכן אין בהם צורך בשינוי.

Closes #3518

## בדיקות
- בדיקה חדשה ב-`test/settings/tabs/text_display_settings_section_test.dart`: התיאור לא כולל את השמות המפורשים וכן כולל "אלקים, ש-די, צבקות". הבדיקה נכשלת על dev ועוברת אחרי התיקון.
- `flutter test -j 1 test/settings/l10n test/settings/tabs test/text_display`:
  - בענף: 262 עברו, 0 נכשלו, 0 דולגו.
  - ב-dev: 261 עברו, 0 נכשלו, 0 דולגו. ההפרש הוא הבדיקה החדשה.
- `dart analyze` על הקבצים ששונו: נקי. `dart format --set-exit-if-changed`: נקי.
- `dart tool/ui_lint_cli.dart`: אותן הפרות כמו ב-dev, בלי הפרות חדשות.
- מול כל ה-PR-ים הפתוחים (`git merge-tree`): אין התנגשות חדשה לעומת dev.

<!-- SUITE -->
