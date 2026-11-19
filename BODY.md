## מה היה שבור

ניקוי חלקי של רשימת #3512. בחלק הזה יש שלושה פריטים:

- **גודל גופן התחלתי 16 במקום 25.** `SettingsState.initial()` הגדיר `fontSize: 16`, אבל ברירת המחדל באחסון (`SettingsRepository`), בהגדרות לפי ספר ובאיפוס הזום היא 25 (`AppFonts.defaultReadingSize`). `SettingsState.initial()` הוא גם קו הבסיס שמאזין התוספים ב-`MainWindowScreen` משווה אליו. לכן בשינוי ההגדרות הראשון נשלח לתוספים `settings.changed` על `fontSize` (וגם על גודל תוצאות החיפוש, שנגזר ממנו), אף שהגודל לא השתנה.
- **"תצוגת ספר בPDF"** בלי מקף, בניגוד לשאר המחרוזות ("ב-PDF").
- **ענף מובייל מת ב-`ShortcutsSettingsTab.build`.** הלשונית מוגדרת `desktopOnly` ולא נבנית בטלפון, כך שההודעה "קיצורי מקשים זמינים רק בדסקטופ" לא הוצגה אף פעם.

## שורש הבעיה

- 8a1418cd8 ("גודל גופן ברירת מחדל - 25") העלה את ברירת המחדל ב-repository מ-16 ל-25, אבל לא עדכן את `SettingsState.initial()`. גם 223d82297 השאיר את הערך כמו שהוא.
- e4450b101 הוסיף את הכותרת בלי מקף.
- מאז a7cafb865 הלשונית מסומנת `desktopOnly`, ולכן הבדיקה של `Platform` בתוכה כבר לא נחוצה.

## התיקון

- ב-`SettingsState.initial()`: `fontSize: AppFonts.defaultReadingSize` במקום 16.
- "תצוגת ספר ב-PDF": התיקון נעשה בלשונית העיצוב (בכותרת ובאינדקס החיפוש) וב-`settings_en.arb`, והקטלוג נוצר מחדש.
- הוסרו ענף המובייל, `import 'dart:io'` והמחרוזת שהפכה ליתומה, גם מה-arb וגם מהקטלוג.

סה"כ בקוד: 5 שורות נוספו ו-14 נמחקו.

## מה לא נכלל (בכוונה)

- `keyGoogleCalendarClientId/ClientSecret`: אין להם צרכן, אבל הם ברשימת הסודות החסומים של `plugin_settings_access_policy`. אם אמחק אותם, ערכים ישנים שנשארו אצל משתמשים יהיו פתוחים לקריאה על ידי תוספים. לכן צריך קודם להחליט על מיגרציה או ניקוי.
- `enableHtmlLinks`: הערך נקרא מהאחסון, ולפי ההערה בדיון היעדר מתג לא מוכיח שהוא תמיד `true`.
- `pageShapeBottomFont`: משמש לטעינת הגופן, ולכן לא נמחק.
- המתג "הצגת המפרשים בחלונית בצד" (`StatefulBuilder` שקורא את `Settings` ישירות): צריך להעביר אותו לעדכון משותף דרך ה-bloc. זה שינוי התנהגותי נפרד.
- 26 המקומות עם `[EDITING DISABLED]`.

Refs #3512

## בדיקות

- בדיקה חדשה: `test/settings/engine/settings_initial_defaults_test.dart`. היא משווה את `SettingsState.initial()` למצב שנטען מאחסון ריק, ובודקת את כותרת "תצוגת ספר ב-PDF". שתי הבדיקות נכשלות על `dev` ועוברות בענף.
- `flutter test -j 1` על `test/settings/` ועל 214 קבצי בדיקה נוספים שמשתמשים ב-`SettingsState.initial`, ב-`DesignSettingsTab` או ב-`ShortcutsSettingsTab`:
  - **בענף:** 3883 עברו, 9 דולגו, 2 נכשלו.
  - **ב-dev:** 3880 עברו, 9 דולגו, 5 נכשלו.
  - שני הכשלים שבענף מופיעים גם ב-dev, והם תלויי סביבה: `orphan_library_service_test` ו-`personal_books_import_service_test` (הרשאות כתיבה כשהבדיקות רצות כ-root).
  - ב-dev נכשלו בנוסף שתי הבדיקות החדשות, ו-`page_shape_super_commentary_wait_test` (לא יציב, עבר בענף).
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים על הקבצים שהשתנו.
- `ui_lint`: אין הפרות חדשות.

<!-- SUITE -->
