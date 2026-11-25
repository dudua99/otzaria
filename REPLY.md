## מענה לסיבות הסגירה

תודה על הסקירה. התיקון נכתב מחדש לפי הכיוון שנתת: מיפוי לוגי, בלי לגעת בקוד הסריקה, בדגל extended או בזיווג הלחיצות של ה-engine.

1. **סימון extended ב-runner משנה את זהות המקש הפיזי** (Numpad8 והחץ הייעודי הופכים שניהם ל-0xE048): השינוי בוטל לגמרי (`b8183b2b7`). `shift_key_normalizer.cpp/.h` ובדיקות ה-C++ שנוספו להם חזרו בדיוק למצב dev, ו-`git diff upstream/dev` על `windows/` ועל `test/windows/` ריק.
   בדיקה: `ספרון 8 וחץ למעלה הייעודי נשארים שני מקשים פיזיים נפרדים`. בלחיצה חופפת יש שני מקשים פיזיים, ושחרור של אחד לא משחרר את השני.

2. **`GetKeyState(VK_NUMLOCK)` שנבדק בכל הודעה יכול לזווג לחיצה ושחרור שונים, והמקש נתקע**: ההחלטה מתקבלת רק ב-KeyDown ונשמרת לפי המקש הפיזי. Repeat ו-Up מקבלים את המקש הלוגי שנשמר ולא בודקים את NumLock שוב.
   בדיקה: `שחרור אחרי החלפת NumLock מזווג למקש שנבחר בלחיצה`. התרחיש: לחיצה בלי NumLock, אחריה החלפת NumLock, ואז שחרור. שני האירועים הם `arrowUp`, ואין מקש לחוץ שנשאר. הבדיקה נכשלת גם על גרסה שבודקת NumLock מחדש בשחרור.
   הגלילה הרציפה תלויה בשחרור, ולכן נוספה גם הבדיקה `החזקת ספרון 2/8 בקורא גוללת ברצף כמו החצים ונעצרת בשחרור`, על `ProgressiveScroll` אמיתי.

3. **המיפוי הלוגי** נמצא במקום מרכזי אחד, `lib/shortcuts/numpad_navigation_keys.dart`. הקוד עוטף את `PlatformDispatcher.onKeyData` ומחליף רק את `logical`, וגם זה רק כש-`HardwareKeyboard.lockModesEnabled` לא מכיל `numLock`. המיפוי: 7→Home, 8→↑, 9→PgUp, 4→←, 6→→, 1→End, 2→↓, 3→PgDn, 0→Insert, נקודה→Delete. המקש הפיזי לא משתנה.
   העטיפה רצה לפני `HardwareKeyboard` והפוקוס. לכן כל מקום שמשווה ל-`arrowUp`/`home`/`end` עובד בלי שינוי: הקורא, `simple_text_viewer`, PDF, `ShortcutHelper` וה-`ScrollIntent` של Flutter. המיפוי פעיל רק ב-Windows.
   כש-NumLock דולק אין שום שינוי, וגם Ctrl+ספרון עובר לטאב כרגיל (נבדק).

## בדיקות
- 8 בדיקות חדשות ב-`test/shortcuts/numpad_navigation_keys_test.dart`. האירועים נשלחים דרך `onKeyData` ואחריהם הודעת raw, כמו שה-engine שולח. בלי התיקון 6 מהן נכשלות. שתי בדיקות השמירה עוברות בכל מקרה: NumLock דולק, ומחוץ ל-Windows.
- בדיקות קשורות (`test/shortcuts`, `progressive_scrolling*`, `reader_page_keys`, וכל הבדיקות שמייבאות את `main.dart`), עם `flutter test -j 1`: בענף 350 עברו, 0 נכשלו ו-0 דולגו. ב-dev 342 עברו, 0 נכשלו ו-0 דולגו.
- `dart analyze` ו-`dart format` נקיים. `ui_lint`: 0 הפרות חדשות. אין התנגשות מול dev ומול PRים פתוחים (#4790 נוגע ב-`main.dart` ומתמזג נקי).

**נקודה להחלטה:** כש-NumLock כבוי, Ctrl+ספרון הופך ל-Ctrl+מקש ניווט, כמו בשאר Windows. למשל Ctrl+ספרון 1 הוא Ctrl+End ולא מעבר לטאב 1. כש-NumLock דולק, מעבר הטאבים עם הספרון לא השתנה.
