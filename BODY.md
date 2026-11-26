## מה היה שבור
במצב מנותק עדיין הופיע פס "יש עדכונים לתוספים" (#6066). בדיקת העדכונים של אוצריא עצמה כבר חסומה במצב מנותק (`PluginUpdateCheckService.updatesAllowed`), כך שהפס מגיע מתוסף (חנות התוספים) שרץ ברקע, פונה בעצמו לרשת דרך `network.*`, ומציג הודעה משלו.

## הסיבה
מצב מנותק חסם תוספי רשת רק בנקודות הכניסה של הממשק (`blockedInOfflineMode` – 3b20a2b68, ee2228ccb): הסתרת כרטיסיות וכלים. שער הרשת היחיד של התוספים, `evaluatePluginNetworkAccess` (משמש את `network.*` בגשר, את שער הבקשות של ה-WebView ואת הפעולות הדקלרטיביות), ומדיניות ה-WebView `resolvePluginNetworkPolicy` (CSP/WebKit) לא בדקו את מצב מנותק בכלל. לכן ריצת רקע של תוסף עם הרשאת רשת המשיכה לגשת לאינטרנט.

## התיקון
- `evaluatePluginNetworkAccess`: ליעד באינטרנט במצב מנותק מוחזר `PluginNetworkDecision.offlineMode`, לפני בדיקת ההרשאות. כך גם `isPluginNetworkAccessAllowed` (שער ה-WebView, קפיצות הורדה) חוסם.
- `resolvePluginNetworkPolicy`: במצב מנותק אין יעדים מרוחקים במדיניות. יעדי loopback נשארים.
- `SettingsBloc`: שינוי מצב מנותק שולח `PluginNetworkPolicy.notifyChanged()`, כדי ש-WebView פתוחים (גם של ריצת רקע) ירעננו את החסימה מיד.
- גשר ה-RPC: `network.*` במצב מנותק זורק `error.unavailable` עם הסבר בעברית. זה קוד קיים ומתועד ("ה-API קיים אך אינו זמין בהקשר הנוכחי"); נוסף משפט בסעיף `network.*` ב-`docs/plugin-sdk/API_REFERENCE.md`.

החלטות:
- **loopback נשאר מותר** במצב מנותק: שירות מקומי (למשל מודל AI מקומי) אינו אינטרנט.
- קריאת ההגדרה נכשלת לכיוון "מחובר" רק כש-Settings לא אותחל (בדיקות). באפליקציה Settings מאותחל לפני כל תוסף.
- תוסף שהמשתמש כיבה את הרשאת הרשת שלו נשאר זמין במצב מנותק כמו קודם (ee2228ccb); השער דוחה אותו ממילא.
- לא נגעתי ב-`PluginUpdateCheckService` (כבר תקין) ולא בקוד החנות (מאגר נפרד). כדאי שגם החנות תוותר בשקט על `error.unavailable`.

Refs #6066 (הפס עצמו מוצג על ידי התוסף; עכשיו בדיקת הרשת שלו נכשלת במצב מנותק, אבל לא בדקתי את קוד החנות כדי לוודא שהיא לא מציגה פס גם בכשל).

## בדיקות
- בדיקה חדשה `test/plugins/services/plugin_network_offline_mode_test.dart`: יעד באינטרנט עם הרשאה – מותר כשמחובר, חסום במצב מנותק; loopback נשאר מותר; מדיניות ה-WebView בלי יעדים מרוחקים במצב מנותק. שתי הראשונות נכשלות ב-dev.
- `flutter test test/plugins/ test/settings/ -j 1`:
  - ענף: 5486 עברו, 19 דולגו, 3 נכשלו.
  - בסיס (upstream/dev 4fe1973a4): 5483 עברו, 19 דולגו, 3 נכשלו.
  - 3 הכשלים זהים בשניהם ונובעים מהסביבה (בדיקות הרשאות קבצים שלא נכשלות כשרצים כ-root): `plugin_bridge_adapter_test` "כשל באמצע הכתיבה", `personal_books_import_service_test` "תיקיית יעד ללא הרשאת כתיבה", `orphan_library_service_test` "כשל בסריקת ענף".
- `flutter analyze` – אין בעיות. `dart format` נקי; `dart tool/ui_lint_cli.dart` – פלט זהה לבסיס.
- PR פתוחים שנוגעים באותם קבצים: #6065 – מתמזג נקי; #5740, #5688, #2788 – מתנגשים כבר עם dev, אותם קבצים ואותו מספר סימנים, ללא קונפליקט חדש.

<!-- SUITE -->
