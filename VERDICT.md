READY
QA בלתי תלוי ל-#4439 (Ctrl+Enter שולח את "דיווח מהתוכנה"). לא נדרשו תיקונים, לא נדחפו קומיטים.
ענף: feat/app-report-ctrl-enter-4439, ראש 620003e05 (ללא שינוי), מעל upstream/dev 7f2b6c4ec (עדכני נכון ל-20.11 ~09:00 UTC).
כותרת ה-PR: תיקון issue #4439 — Ctrl+Enter שולח את הדיווח מהתוכנה
Closes #4439. ה-issue פתוח (milestone 0.9.99), אין PR פתוח שמזכיר אותו או נוגע ב-app_report_dialog.dart.
נכשל על הבסיס: הבדיקה החדשה על dev ‏+1 −4, בענף ‏+5.
חבילה קשורה (35 נתיבים: test/app_report, dialog_keyboard_contract_test, כל מי שמייבא app_report_dialog.dart או shortcut_helper.dart), flutter test -j 1:
  ענף 1289 עברו / 0 נכשלו / 0 דולגו; בסיס 1285 / 4 / 0 — ארבעת הכשלונות הם רק הבדיקות החדשות.
סקירה: _sendAction אחד לכפתור ולקיצור (null כש-isSending / לא נטען / draftLoad, בדיוק כשהכפתור כבוי או מוסתר); גם ה-bloc חוסם שליחה במצבים האלה. CallbackShortcuts הוא אב של כל השדות. ב-macOS ctrl ממופה ל-meta דרך activatorsFromShortcut. Enter רגיל ללא שינוי (DD-08).
analyze + format נקיים; ui_lint זהה לבסיס.
קונפליקטים: merge-tree מול upstream/dev נקי; 42 PRs פתוחים — אין קונפליקט חדש.
החלטות פתוחות: אין (דיאלוג ניהול הדיווחים לא נכלל — מחוץ להיקף).
חזותי: רק tooltip "CTRL + Enter" בריחוף על "שלח". צילומי לפני/אחרי (בהיר/כהה, גופנים אמיתיים) ב-qa-shots/4439. בדיקה מקומית לא נדרשת; כדאי לנסות פעם ב-macOS (Cmd+Enter).
