## מה היה שבור

ה-PR מטפל בחלק מהרשימה של #3512, בשלושה פריטים:

- **גודל הגופן ההתחלתי היה 16 במקום 25.** `SettingsState.initial()` הגדיר `fontSize: 16`. בשאר המקומות ברירת המחדל היא 25 (`AppFonts.defaultReadingSize`): באחסון (`SettingsRepository`), בהגדרות לפי ספר ובאיפוס הזום. `SettingsState.initial()` משמש גם כקו הבסיס שמאזין התוספים ב-`MainWindowScreen` משווה אליו. לכן בשינוי ההגדרות הראשון נשלח לתוספים `settings.changed` על `fontSize` גם כשהגודל לא השתנה.
- **"תצוגת ספר בPDF"** נכתב בלי מקף, בשונה משאר המחרוזות שכתוב בהן "ב-PDF".
- **ענף מובייל מת ב-`ShortcutsSettingsTab.build`.** הלשונית מסומנת `desktopOnly`, ומסך ההגדרות לא בוחר בה בטלפון. הבחירה חסומה בכל המסלולים: בתפריט, בחיפוש ובבקשת לשונית מבחוץ (`_isTabAvailable`). לכן ההודעה "קיצורי מקשים זמינים רק בדסקטופ" לא הוצגה אף פעם.

## שורש הבעיה

- הקומיט 8a1418cd8 ("גודל גופן ברירת מחדל - 25") העלה את ברירת המחדל ב-repository ל-25. הוא לא עדכן את `SettingsState.initial()`.
- הקומיט e4450b101 הוסיף את הכותרת בלי מקף.
- מאז a7cafb865 הלשונית מסומנת `desktopOnly`, ולכן אין צורך בבדיקת `Platform` בתוכה.

## התיקון

- ב-`SettingsState.initial()` הערך הוא עכשיו `fontSize: AppFonts.defaultReadingSize`. בהרצה רגילה ה-bloc נבנה מ-`readSettings()`, כך שהמצב ההתחלתי מגיע תמיד מהאחסון. לכן השינוי לא משפיע על הפעלה ראשונה, על איפוס או על מיגרציה. הוא משנה רק את קו הבסיס של מאזין התוספים.
- הכותרת "תצוגת ספר ב-PDF" תוקנה בלשונית העיצוב (בכרטיס ובאינדקס החיפוש) וב-`settings_en.arb`, והקטלוג נוצר מחדש.
- הוסרו ענף המובייל ו-`import 'dart:io'`. הוסרה גם המחרוזת שנשארה בלי שימוש, מה-arb ומהקטלוג.

## מצב שאר הפריטים ב-#3512

- כבר תוקנו ב-dev:
  - הניסוח של הגיבוי האוטומטי ("הגיבוי מתבצע כל…").
  - 26 המקומות שסומנו `[EDITING DISABLED]` (שניהם ב-885eaf7be).
  - `pageShapeBottomFont` כבר לא שדה ב-`SettingsState`. נשארה רק הקריאה שלו לטעינת הגופן (#849), והיא נחוצה.
- נשארו להחלטת המתחזק:
  - `keyGoogleCalendarClientId/ClientSecret`: אין להם צרכן, אבל הם ברשימת הסודות ש-`plugin_settings_access_policy` חוסם. אם נמחק אותם, ערכים ישנים שנשמרו אצל משתמשים ייחשפו לתוספים. לכן צריך קודם להחליט על מיגרציה או על ניקוי.
  - `enableHtmlLinks`: הערך נקרא מהאחסון. גם אם אין מתג בממשק, זה לא מוכיח שהערך תמיד `true`.
  - המתג "הצגת המפרשים בחלונית בצד" (`StatefulBuilder` שקורא את `Settings` ישירות): כדי לתקן אותו צריך לעבור לעדכון משותף דרך ה-bloc. זה שינוי התנהגות נפרד.

Refs #3512

## בדיקות

- בדיקה חדשה: `test/settings/engine/settings_initial_defaults_test.dart`. היא משווה את `SettingsState.initial()` למצב שנטען מאחסון ריק, ובודקת את כותרת "תצוגת ספר ב-PDF". שתי הבדיקות נכשלות על `dev` ועוברות בענף.
- הרצתי `flutter test -j 1` על 325 קבצים: כל `test/settings/`, וכל קובץ שמשתמש ב-`SettingsState.initial`, ב-`DesignSettingsTab`, ב-`ShortcutsSettingsTab`, ב-`settings_screen` או ב-`main_window_screen`.
  - **בענף:** 4300 עברו, 9 דולגו, 2 נכשלו.
  - **ב-dev:** 4297 עברו, 9 דולגו, 5 נכשלו.
  - שני הכשלים בענף נכשלים גם ב-dev, והם תלויי סביבה (הרשאות כתיבה כשהבדיקות רצות כ-root): `orphan_library_service_test` ו-`personal_books_import_service_test`.
  - ב-dev נכשלו בנוסף שתי הבדיקות החדשות ו-`page_shape_super_commentary_wait_test`. הבדיקה האחרונה לא יציבה: היא עוברת כשמריצים אותה לבד.
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים על הקבצים שהשתנו. `generate_settings_l10n` ו-`generate_search_index` מעודכנים. ב-`ui_lint` אין הפרות חדשות.

<!-- SUITE -->
