READY
QA בלתי תלוי לענף fix/plugin-close-tab-in-field-3942-v3. ראש הענף a8ad68d2a98782b5e6962970f83073dc64a3a493, ללא קומיטים חדשים (לא נמצא מה לתקן).
כותרת PR: תיקון issue #3942 — Ctrl+W סוגר את לשונית התוסף גם כשהפוקוס בשדה עריכה. Closes #3942.
בדיקה מחדש: #3942 פתוח; אין PR פתוח שמטפל בו (#4179 ו-#5575 סגורים).
הוכחת כשל: בדיקות ה-issue נכשלות על dev ‏(6), עוברות בענף. בדיקות רצפי #5575 עוברות על dev ונכשלות על סקריפט v2 ‏(#5575) בכל 6 הצירופים — הלשונית נסגרת (key-shortcut-close-tab נשלח).
בדיקות (flutter test -j 1 על test/plugins/view, plugin_host_shortcuts_test, android_startup_fixture_test): ענף 418 עוברות / 4 מדולגות / 0 נכשלות; dev עם הבדיקות החדשות 412 / 4 / 6 נכשלות (ה-6 של ה-issue); dev בלי הבדיקות 406 / 4 / 0.
אימות עצמאי ב-Chromium אמיתי (Playwright, keyboard.press, סקריפט הייצור, 3 שדות × Ctrl/Cmd × 9 תרחישים = 54 לכל גרסה): שני רצפי #5575 (preventDefault ו-stopImmediatePropagation), רצף 2 (keydown פנימי), מאזין window רשום מראש, stopPropagation בשדה, preventDefault ב-capture של document, Ctrl+K — זהים ל-dev. ההבדל היחיד: Ctrl/Cmd+W בשדה שאיש לא טיפל בו סוגר את הלשונית (גם כשמאזין window רק רואה את ההקשה).
שורש: 7d11e0eca (#1336) החריג קיצורים בשדה; 7ea1fe72c (#2203) החזיר רק חיפוש חדש — אומת.
סקירת הקוד: הסקריפט מבצע את ההחלטה ב-setTimeout(0) אחרי סיום ההעברה, מצב לכל אירוע ב-closure, אירוע לא אמיתי/חוזר לא מועבר, ובצד Flutter ה-callback בודק mounted. שאר המסלולים (_forwardHostShortcut) לא השתנו.
analyze/format נקי; ui_lint — פלט זהה לחלוטין ל-dev.
קונפליקטים: merge-tree נקי מול dev (acb6759c5); מול 83 PR פתוחים — אין קונפליקט חדש. 5653 ו-3036 נוגעים באותם קבצים וממוזגים אוטומטית.
החלטות פתוחות (כמו אצל המפיק): stopPropagation בלי preventDefault נחשב טיפול של התוסף (שמרני, כמו dev); המארח לא חוסם את ברירת המחדל בשדה — ב-macOS (WKWebView) כדאי לוודא ידנית ש-Cmd+W בשדה לא מגיע גם לתפריט האפליקציה (התנהגות זו קיימת גם ב-dev).
בדיקה ויזואלית: אין שינוי ויזואלי. מומלצת בדיקה ידנית קצרה ב-Windows וב-Mac: Ctrl/Cmd+W בשדה של תוסף, ותוסף שמטפל בקיצור בעצמו.
