## מה היה שבור

דוח התקיעה (23.6 שניות, 95 תוספים מותקנים, אחרי 5 עדכוני חנות) מראה שכל הדגימות נמצאות ב-`PluginSystemDatabase.getAllInstalledPlugins`, בתוך ריקון אחד של תור ה-microtasks — כלומר מאות קריאות רצופות.

## שורש הבעיה

`getAllInstalledPlugins` הריץ בכל קריאה, ב-isolate של הממשק:
- שאילתה סינכרונית על כל `plugin_installation`, עם שתי תת-שאילתות הרשאה לכל שורה;
- לכל תוסף `jsonDecode` של ה-manifest ושני `DateTime.parse`.

הפונקציה לא נשמרה בשום מקום, והיא נקראת מכל `plugin.listInstalled` ו-`plugin.openOther` בגשר (לכל תוסף, ה-RateLimiter מתיר כ-100 קריאות בשנייה), מ-`LoadPlugins`, מ-`_findSameNameDuplicates` בהתקנה ומ-`getNextUserOrderForNewPlugin`. עם 95 תוספים כל קריאה כבדה, ומאות קריאות ברצף נועלות את הממשק.

אין commit יחיד שגרם לנסיגה: הקריאה הייתה כך מאז הוספת `plugin.listInstalled` (c8beed701) ו-`plugin.openOther` (0ed4ada62), שחשפו אותה לקריאות מכל תוסף; תת-השאילתות נוספו ב-dc485fcf1. הקורא המדויק שחוזר מאות פעמים בזמן עדכוני החנות לא זוהה בוודאות מתוך הדוח — לפי מבנה הקוד הוא מגיע מהגשר (קריאות של תוספים), והתיקון מטפל בכל הקוראים יחד.

## התיקון

הרשימה המפוענחת נשמרת יחד עם החיבור ועם `total_changes()` ו-`data_version` שמולם נקראה. `total_changes` משתנה בכל כתיבה בחיבור של הממשק, ו-`data_version` בכל כתיבה מחיבור אחר לאותו קובץ (למשל ה-isolate של כתיבות KV); כשאחד מהם משתנה, או כשהחיבור נסגר ונפתח מחדש, הרשימה נקראת שוב. קריאה חוזרת בלי שינוי עולה שאילתת pragma אחת בלבד. כל קורא מקבל עותק משלו של הרשימה, כך ששינוי שלה אצל הקורא אינו משפיע על אחרים.

כל הטרנזקציות על החיבור הזה סינכרוניות (SAVEPOINT בלי await באמצע), כך שקריאה לא יכולה לשמור מצב שיבוטל אחר כך.

Closes #4722

## בדיקות

- בדיקה חדשה `test/plugins/storage/plugin_system_database_installed_cache_test.dart` (5 בדיקות): קריאה חוזרת בלי כתיבה אינה מפענחת שוב (נכשלת על dev, עוברת עם התיקון); שינוי הרשימה שהוחזרה אינו משפיע; כל כתיבה (התקנה/עדכון, הרשאה, סדר, הסתרה, מחיקה) נראית מיד; כתיבה מחיבור אחר נראית; אחרי סגירה המסד נקרא מחדש.
- `flutter test -j 1` על `test/plugins`, `test/settings/services`, `test/app_report/app_report_collector_test.dart`, `test/app_report/app_hang_signature_test.dart`, `test/core/sqlite_memory_release_test.dart`, `test/library_update/library_runtime_refresh_service_test.dart`, `test/settings/dialogs/change_location_dialog_test.dart`, `test/tool/perf_probe`:
  - בענף: 4798 עברו, 21 דולגו, 3 נכשלו.
  - על dev: 4793 עברו, 21 דולגו, 3 נכשלו.
  - אותן 3 בדיקות נכשלות בשניהם (בדיקות הרשאות קבצים שאינן תקפות בהרצה כ-root): `plugin_bridge_adapter_test` (כשל באמצע הכתיבה), `personal_books_import_service_test` (תיקייה ללא הרשאת כתיבה), `orphan_library_service_test` (כשל בסריקת ענף).
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים בקבצים שנגעתי בהם; `dart tool/ui_lint_cli.dart` — פלט זהה ל-dev.

<!-- SUITE -->
