## מה חסר
משתמש עם כמה שולחנות עבודה לא יכול לדעת באיזה מהם הוא נמצא בלי לפתוח את דיאלוג ההחלפה. ה-tooltip של כפתור "החלף שולחן עבודה" בשורת הכותרת הציג רק את שם הפעולה והקיצור (כך מאז e8b6e677f).

## השינוי
- ב-tooltip של הכפתור נוסף שם השולחן הפעיל: "החלף שולחן עבודה (Ctrl+K) · נוכחי: עיון". כשמחליפים שולחן, ה-tooltip מתעדכן מיד.
- הקריאה של WorkspaceBloc אופציונלית: `context.select<WorkspaceBloc?, String?>`, אותו דפוס כמו ב-`personal_notes_sidebar.dart`. כשאין WorkspaceBloc בעץ (בדיקות, חלון משני) או שאין שולחן פעיל, ה-tooltip נשאר כמו קודם ולא נזרקת שגיאה. זה מה ששבר את #5528, שנסגר עם 108 כשלים בבדיקות שורת הכותרת.
- `Builder` סביב הכפתור, כדי שהחלפת שולחן תבנה מחדש רק את הכפתור ולא את כל שורת הכותרת.
- מחרוזת חדשה בקטלוג ההגדרות (settings_en.arb + הקטלוג המחולל): "Switch workspace ({shortcut}) · current: {name}".
- לא נוסף טקסט קבוע לשורת הכותרת. דיאלוג ההחלפה כבר מסמן את השולחן הפעיל.

## בדיקות
- `test/navigation/custom_title_bar_test.dart`, קבוצה 'active workspace name in title-bar tooltip (issue #5501)':
  - ה-tooltip מציג את שם השולחן הפעיל ומתעדכן כשמחליפים שולחן. נכשל על dev לפני השינוי.
  - בלי שולחן פעיל, וגם בלי WorkspaceBloc בכלל: שורת הכותרת נבנית בלי שגיאה וה-tooltip לא השתנה.
- `flutter test -j 1` על 91 קבצים: כל `test/navigation`, כל `test/settings/l10n`, וכל קובץ שמייבא את `custom_title_bar` / `settings_catalogs` / `workspace_bloc`:
  - בענף: 1506 עברו, 2 נכשלו, 1 דולג.
  - בבסיס (upstream/dev): 1504 עברו, 2 נכשלו, 1 דולג.
  - שני הכישלונות זהים בשני הצדדים ולא קשורים לשינוי. שתי הבדיקות נשענות על הרשאות קבצים (chmod), והסביבה רצה כ-root, שמתעלם מהן:
    - `navigation_repository_test.dart`: "מסד שאינו קריא נחשב ספרייה ריקה".
    - `plugin_bridge_adapter_test.dart`: "כשל באמצע הכתיבה אינו פוגע בקובץ הקיים".
- `dart analyze` ו-`dart format` על הקבצים שנגעתי בהם: נקי. `tool/ui_lint_cli.dart`: אין הפרות חדשות.

<!-- SUITE -->

Closes #5501
