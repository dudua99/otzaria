## סיכום (ללא PR)

לא נפתח PR עבור #4317: לא נמצא כשל שאפשר להראות בבדיקה דרך הקוד האמיתי.

### מה נבדק
- שיגור המתקין/המעדכן ב-Windows: `CreateProcessW` עם מחרוזת רחבה (`lib/update/windows_installer_io.dart`), `Process.start`/`Process.run` של Dart, `ShellExecuteW` במתקין — כולם Unicode.
- תוכנית ההחלפה והלוג של `otzaria_updater` נכתבים ונקראים ב-UTF-8.
- ציטוט הארגומנטים (`windowsCommandLine`) תקין לנתיבי הקבצים שמועברים.

### חשד (לא מוכח)
התקנת מנהל ישנה ב-`C:\אוצריא` (מתקין שלפני 9be62e7c7) אין בה `system_install.marker`, ולכן `AppPaths.isWindowsSystemInstall` מחזיר false והאפליקציה משגרת את המתקין עם `/SILENT /CURRENTUSER`. במצב שקט המתקין לא מסלים הרשאות, אף ש-`FindPreviousInstallDir` שלו מסווג את `C:\אוצריא` כדורש מנהל. כשל כתיבה מוסתר ע"י `/SUPPRESSMSGBOXES`.

בנוסף: למתקין המלא לא מועבר `/LOG`, ו-`otzaria-updater.log` קיים רק במסלול העדכון המצומצם — לכן ייתכן שאין למדווח לוג לשלוח.

Refs #4317

## בדיקות
לא בוצעו שינויים בקוד; אין בדיקות להריץ.

<!-- SUITE -->
