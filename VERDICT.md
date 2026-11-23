NOT READY
סיבה: הבאג תלוי ב-Windows ובמנוע Flutter. אין בפרויקט בדיקות ל-runner של Windows, ולכן אי אפשר לכתוב בדיקה שנכשלת על upstream/dev (b68601ad5).
בצד Dart אין לולאה שמחזירה פוקוס לחלון. ב-onWindowBlur אין קוד, ו-focus() / raiseSelf נקראים רק בפעולות מפורשות.
חשד מבוסס היסטוריה:
- aa99e077f הוסיף שער WH_CBT (ShouldVetoActivation) נגד הפעלה חוזרת שהמנוע יוצר.
- 39189725e (מחיקת מודל A) הפך את החלונות המשניים ל-FLUTTER_HOST_WINDOW.
- IsOtzariaWindow מכיר רק את FLUTTER_RUNNER_WIN32_WINDOW, ולחיצה על חלון Dart לא נרשמת ב-NoteUserActivation. לכן השער מת, והראשי חוטף בחזרה כפי שדווח.
תיקון אפשרי (C++): לרשום הפעלה בלחיצה גם לחלונות FLUTTER_HOST_WINDOW (למשל ב-ActivationGuardProc, או ב-subclass של InstallDartViewHooks שמטפל ב-WM_MOUSEACTIVATE), ולכלול את המחלקה ב-IsOtzariaWindow.
נדרש: מפתח עם Windows שישחזר את הבעיה (העברת כרטיסייה לחלון שני ואז לחיצה עליו), ינסה את התיקון ויאמת. לא נדחף ענף תיקון.
