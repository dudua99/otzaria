## מה חסר
משתמש עם כמה שולחנות עבודה לא יכול לדעת באיזה מהם הוא נמצא בלי לפתוח את דיאלוג ההחלפה. ה-tooltip של כפתור "החלף שולחן עבודה" בשורת הכותרת הציג רק את שם הפעולה והקיצור (כך מאז e8b6e677f).

## השינוי
- ב-tooltip של הכפתור נוסף שם השולחן הפעיל: "החלף שולחן עבודה (Ctrl+K) · נוכחי: עיון". כשמחליפים שולחן, ה-tooltip מתעדכן מיד.
- הקריאה של WorkspaceBloc אופציונלית: `context.select<WorkspaceBloc?, String?>`, אותו דפוס כמו ב-`personal_notes_sidebar.dart`. כשאין WorkspaceBloc בעץ (בדיקות, חלון משני) או שאין שולחן פעיל, ה-tooltip נשאר כמו קודם ולא נזרקת שגיאה. זה מה ששבר את #5528, שנסגר עם 108 כשלים בבדיקות שורת הכותרת.
- `Builder` סביב הכפתור, כדי שהחלפת שולחן תבנה מחדש רק את הכפתור ולא את כל שורת הכותרת.
- מחרוזת חדשה בקטלוג ההגדרות (settings_en.arb + הקטלוג המחולל): "Switch workspace ({shortcut}) · current: {name}".
- לא נוסף טקסט קבוע לשורת הכותרת. דיאלוג ההחלפה כבר מסמן את השולחן הפעיל.

Closes #5501

## בדיקות
- `test/navigation/custom_title_bar_test.dart`, קבוצה 'active workspace name in title-bar tooltip (issue #5501)':
  - ה-tooltip מציג את שם השולחן הפעיל ומתעדכן כשמחליפים שולחן. נכשל על dev לפני השינוי.
  - בלי שולחן פעיל, וגם בלי WorkspaceBloc בכלל: שורת הכותרת נבנית בלי שגיאה וה-tooltip לא השתנה.
- `flutter test -j 1 test/navigation test/release/semantic_release_components_test.dart test/settings/l10n/library_spelling_consistency_test.dart`:
  - בענף: 547 עברו, 1 נכשל, 0 דולגו.
  - בבסיס (upstream/dev): 545 עברו, 1 נכשל, 0 דולגו.
  - הכישלון היחיד זהה בשניהם ולא קשור לשינוי: `navigation_repository_test.dart` "מסד שאינו קריא נחשב ספרייה ריקה". הסביבה רצה כ-root, ולכן הקובץ קריא בכל זאת.
- `dart analyze` ו-`dart format` על הקבצים שנגעתי בהם: נקי. `tool/ui_lint_cli.dart`: אין הפרות חדשות.

<!-- SUITE -->
