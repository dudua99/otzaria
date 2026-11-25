## מה היה שבור
ב-Windows, כש-NumLock כבוי, מקשי הספרון (8/2/4/6 חצים, 7/1 Home/End, 9/3 PgUp/PgDn, 0 Insert, נקודה Delete) לא עשו כלום בקורא, ב-PDF, ברשימות ובשדות טקסט.

## הסיבה
ה-engine של Flutter ב-Windows גוזר את המקש **הלוגי** של מקשי הספרון מקוד הסריקה (`scanCodeToLogicalMap` ב-`keyboard_key_embedder_handler`), ולכן גם בלי NumLock האפליקציה מקבלת `numpad8`/`numpad7` במקום `arrowUp`/`home`. כל ההתאמות באפליקציה (`text_book_screen.dart`, `simple_text_viewer.dart`, קורא ה-PDF, `ShortcutHelper`, וה-`ScrollIntent` המובנים של Flutter) משוות ל-`arrowUp`/`home`/`end` וכו', ולכן לא חלות. אין commit שגרם לזה — זה המצב מאז ומעולם.

## התיקון
- **בוטל** השינוי הקודם ב-runner (`shift_key_normalizer.cpp/.h` ובדיקותיו חזרו למצב dev): סימון extended שינה את זהות המקש הפיזי.
- מקום מרכזי אחד, `lib/shortcuts/numpad_navigation_keys.dart`, עוטף את `PlatformDispatcher.onKeyData` (מותקן ב-`main.dart` מיד אחרי אתחול ה-binding) ומחליף **רק את המקש הלוגי** של מקשי הספרון למקש הניווט כש-NumLock כבוי (`HardwareKeyboard.instance.lockModesEnabled`).
- המקש הפיזי, קוד הסריקה, extended וזיווג הלחיצות של ה-engine לא משתנים. ההחלטה מתקבלת בלחיצה (down) ונשמרת לפי המקש הפיזי, כך שחזרה ושחרור מקבלים את אותו מקש לוגי גם אם NumLock הוחלף באמצע — אין מקש תקוע.
- כיוון שהמיפוי לפני `HardwareKeyboard`, הפוקוס וה-Shortcuts, כל מקום שמשווה ל-`arrowUp`/`home`/`end` מקבל אותו בלי שינוי בקוד שלו.
- Windows בלבד. עם NumLock דולק — בלי שינוי (גם Ctrl+ספרון למעבר טאב).

Closes #5934

## בדיקות
`test/shortcuts/numpad_navigation_keys_test.dart` (8 בדיקות, האירועים נשלחים דרך `PlatformDispatcher.onKeyData` + הודעת ה-raw, כמו ה-engine):
- ספרון 8 בלי NumLock: לחיצה/חזרה/שחרור נמסרים כ-`arrowUp`, המקש הפיזי נשאר `numpad8`, ואחרי השחרור אין מקשים לחוצים.
- כל עשרת מקשי הספרון ממופים למקשי הניווט.
- ספרון 3 גולל `ListView` כמו PageDown.
- NumLock דולק: הספרות (וגם Ctrl+ספרון 1) לא משתנות.
- שחרור אחרי החלפת NumLock מזווג למקש הלוגי של הלחיצה.
- ספרון 8 והחץ הייעודי נשארים שני מקשים פיזיים נפרדים בלחיצה חופפת.
- החזקת ספרון 2/8 בקורא (`ProgressiveScroll`) גוללת ברצף כמו החצים ונעצרת בשחרור.
- מחוץ ל-Windows אין מיפוי.

בלי התיקון 6 מתוך 8 נכשלות (שתי בדיקות השמירה — NumLock דולק ומחוץ ל-Windows — עוברות).
קבצים קשורים (`test/shortcuts`, `test/widgets/progressive_scrolling*`, `test/text_book/view/reader_page_keys_test.dart` וכל הבדיקות שמייבאות את `main.dart`), `flutter test -j 1`: בענף 350 עברו / 0 נכשלו / 0 דולגו; ב-dev 342 / 0 / 0 (ההפרש — 8 הבדיקות החדשות).
`dart analyze` ו-`dart format` נקיים; `ui_lint`: 0 הפרות חדשות.

PRs פתוחים שנוגעים באותם תחומים: #4790 (`main.dart`), #5740, #5676, #3036 (`lib/shortcuts`) — כולם מתמזגים בלי קונפליקט חדש.

<!-- SUITE -->
