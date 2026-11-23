## חלון שלא מוכן לאבד פוקוס כשעוברים לחלון אוצריא אחר

לא הוכן תיקון: הסיבה נמצאת בקוד ה-runner של Windows (C++) ובמנוע Flutter, ואי אפשר להראות אותה בבדיקה בסביבת Linux. אין בפרויקט בדיקות ל-runner של Windows.

### מה נבדק
- בצד Dart אין שום קוד שמחזיר פוקוס לחלון הראשי כשהוא מאבד אותו. `onWindowBlur` ב-`lib/core/window_listener.dart` ריק. `raiseSelf` / `focus()` נקראים רק בפעולות מפורשות: קבלת כרטיסייה (`in_process_tab_drop.dart` `_raise`), קישור `otzaria://` (`main_window_screen.dart` `_bringWindowToFront`) והצגת החלון בהפעלה (`main.dart` `presentMainWindow`).
- `aa99e077f` (6.9) מדד שמנוע Flutter מחזיר את ההפעלה לחלון הקודם בתוך כ-30ms מהלחיצה. התיקון שם היה שער `WH_CBT`: `Win32Window::ShouldVetoActivation` חוסם הפעלה של חלון אחר במשך 500ms אחרי לחיצת משתמש (`WM_MOUSEACTIVATE` → `NoteUserActivation`).
- `39189725e` (23.10, מחיקת "מודל A") שינה את מבנה החלונות: חלונות משניים הם עכשיו חלונות Dart מהמחלקה `FLUTTER_HOST_WINDOW`. השער נשאר בלי שינוי:
  - `IsOtzariaWindow` מכיר רק את `FLUTTER_RUNNER_WIN32_WINDOW`.
  - `NoteUserActivation` נקרא רק מ-`Win32Window::MessageHandler` (החלון הראשי) ומ-`raiseSelf`.
  - כשיש רק חלון ראשי אחד מהמחלקה הזו, `ShouldVetoActivation` לא יכול להחזיר true. כלומר השער לא עושה כלום, והתסמין המקורי חזר בדיוק בכיוון שדווח: הראשי חוטף בחזרה.

### החשד (לא הוכח)
`windows/runner/win32_window.cpp` (`IsOtzariaWindow`, `ShouldVetoActivation`) ו-`main.cpp` (`ActivationGuardProc`): צריך לרשום לחיצה (`HCBT_ACTIVATE` / `WM_MOUSEACTIVATE`) גם על `FLUTTER_HOST_WINDOW`, ולכלול את המחלקה הזו בבדיקה.

Refs #5743

## בדיקות
לא הורצו: בסביבה הזו אין Windows.

<!-- SUITE -->
