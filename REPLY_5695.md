תודה, הממצא נכון ושוחזר.

**מה נמצא:** בסגירת הראשי `discardWindowSession` מחק את השורה לפני ש־`beforeMainWindowHides` שמר את רשימת השחזור, ובחלון Dart המחיקה רצה בלי תלות בהצלחת `rememberClosed`. ‏`_saveClosed` בלע את השגיאה, ולכן אחרי כשל כתיבה והפעלה מחדש לא נשארו לא שורה ולא פריט שחזור.

**מה השתנה (96e143353):** ‏`rememberClosed` ו־`beforeMainWindowHides` מחזירים עכשיו אם הסשן נשמר, והשורה נמחקת רק אחרי שמירה מוצלחת, גם בראשי (`loadWindowSession` ← שמירה ← `discardWindowSession`, לפני `suspend` שמנקה את המשבצת) וגם ב־`ViewWindowCloseFlow`. אם השמירה נכשלת השורה נשארת ותשוחזר בהפעלה הבאה. באותה הפעלה Ctrl+Shift+T משחזר ממנה ומוחק אותה (`keptSlot`), כך שהחלון לא נפתח פעמיים.

**בדיקות:** ב־`closed_windows_restart_test.dart` (‏3cf6f5dcd) נוספו שתי בדיקות: ״כשל בשמירת רשימת השחזור אינו מוחק את סשן החלון״, שעוברת דרך `ViewWindowCloseFlow` האמיתי, ו״…אינו מוחק את סשן הראשי״. שתיהן משתמשות במסד שבו `saveClosed` זורק, ושתיהן נכשלו על ראש הענף (`Actual: <null>`). ב־`window_listener_secondary_close_test.dart` הוגדר מסד גם ל־`ViewWindowOpener.instance`: עד עכשיו השמירה שם נכשלה בשקט.
`flutter test test/core test/tabs`: ‏2167 עברו, 8 דולגו, 2 נכשלו. שני הכשלים ב־`app_paths_test` (תיקייה מוגנת מכתיבה) נכשלים גם על upstream/dev, כי הסביבה רצה כ־root. ‏analyze, format ו־ui_lint נקיים.
