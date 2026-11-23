תודה, הממצא נכון ושוחזר.

הפורמט הקודם של `AppReportDraft.toJson` שמר `includeMinidump: true` גם כשהערך הגיע מברירת המחדל, ו־`fromJson` טען אותו כמו שהוא — טיוטה ישנה נפתחה עם צירוף פעיל.

התיקון (9a914dfe1): ההסכמה נשמרת עכשיו במפתח חדש `minidumpOptIn`, והמפתח הישן `includeMinidump` אינו נקרא. טיוטה ישנה נפתחת בלי צירוף עד בחירה חדשה; בחירה מפורשת בפורמט החדש נשמרת.

בדיקה: `test/app_report/app_report_service_test.dart` — «טיוטה ישנה עם includeMinidump=true נפתחת בלי צירוף ה-dump» (כותבת רשומת טיוטה בפורמט הישן ל־`ReportDraftStore` וטוענת דרך `loadDraft`, ואז בודקת שהסכמה חדשה נשמרת). נכשלת לפני התיקון ועוברת אחריו; כל `test/app_report` עובר (413). analyze, format ו־ui_lint נקיים.
