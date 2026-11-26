## issue #6001 — סמן ההקלדה לא עובר לתיבת האיתור כשפותחים אותה באמצע הקלדה בתוסף

**לא הוכן PR.** אי אפשר להוכיח את התקלה בבדיקה של Dart: המסלול החשוד נייטיבי (Win32 + WebView2), ואפשר למדוד אותו רק בווינדוס אמיתי.

### מה נבדק (upstream/dev 4fe1973a4)
1. **מסלול הקיצור.** `_forwardHostShortcut` (`lib/plugins/view/plugin_sdk_scripts.dart`) לא מעביר את `key-shortcut-open-find-ref` כשהמוקד בשדה עריכה. זה מכוון (#2203): בשדה עריכה מועברים רק הקיצורים הקבועים (`fixed:`) וחיפוש חדש. לכן כשמקלידים ב-`<input>` של התוסף, `returnKeyboardToFlutterWhenItOwnsIt` (#3759, 24b898b80) לא נקרא בכלל. ברירת המחדל לאיתור היא Ctrl+O. אם Ctrl+G פתח את האיתור אצל המדווח, כנראה שהתוסף פתח אותו בעצמו, או שהשדה לא זוהה כשדה עריכה (iframe, עורך מותאם).
2. **מסלול הקליק (פתיחה ידנית).** `_handleFindRefOpen` (`main_window_screen.dart`) לא מחזיר את המקלדת הנייטיבית בעצמו. הוא סומך על Flutter: `_ViewState._scopeFocusChangeListener` (`widgets/view.dart`) קורא ל-`requestViewFocusChange` רק אם המנוע דיווח קודם `ViewFocusState.unfocused`, כלומר רק אם FLUTTERVIEW קיבל `WM_KILLFOCUS`. ב-`flutter_window.cc` של 3.47.7 אין טיפול ב-`WM_MOUSEACTIVATE` ואין `SetFocus` בלחיצה, כך שקליק על כפתור של Flutter לא מזיז בעצמו את פוקוס Win32 מחלון הקלט של WebView2. אם `_viewHasFocus` נשאר true, למשל כי הפוקוס עבר ל-WebView בלי ש-FLUTTERVIEW החזיק בו קודם, הבקשה לא נשלחת וההקשות ממשיכות להגיע ל-WebView.

### מה צריך למדוד בווינדוס
בשני תרחישים: (א) הקלדה ב-`<input>` של תוסף ואז קליק על "איתור" בסרגל; (ב) קליק על אזור בדף התוסף שאינו שדה ואז קליק על "איתור". בכל אחד לרשום ביומן ברגע פתיחת הדיאלוג את מחלקת החלון של `GetFocus()`, ואם התקבל `didChangeViewFocus(unfocused)` לפני כן.

### כיוון לתיקון אחרי המדידה
להחזיר את המקלדת ל-FLUTTERVIEW בכל פעם ש-UI של Flutter לוקח אותה, ולא רק אחרי קיצור שהועבר. אפשרות אחת: לקרוא ל-`returnKeyboardToFlutterWhenItOwnsIt` גם מ-`_handleFindRefOpen` ומשאר פתיחות הדיאלוגים. אפשרות שנייה: מאזין כללי שמופעל כש-`flutterOwnsKeyboardNow()` נעשה true בזמן ש-`GetFocus()` נמצא תחת חלון מארח של WebView.

Refs #6001

## בדיקות
לא נכתב קוד. עדיין אין בדיקה שנכשלת על upstream/dev, כי אי אפשר לדמות את פוקוס Win32 בבדיקת widget.

<!-- SUITE -->
