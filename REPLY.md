## מענה לסיבות הסגירה

תודה על הסקירה. התיקון נכתב מחדש לפי הכיוון שנתת:

1. **סימון extended ב-runner משנה את זהות המקש הפיזי** — בוטל לגמרי (commit `b8183b2b7`): `shift_key_normalizer.cpp/.h` ובדיקותיו חזרו בדיוק למצב dev. שום דבר ב-runner לא נוגע עוד בקוד הסריקה או בדגל extended. בדיקה: `ספרון 8 וחץ למעלה הייעודי נשארים שני מקשים פיזיים נפרדים` — לחיצה חופפת על שניהם משאירה שני מקשים פיזיים, ושחרור אחד לא משחרר את השני.

2. **בדיקת NumLock מחדש בכל הודעה עלולה לזווג לחיצה ושחרור שונים** — ההחלטה מתקבלת רק ב-KeyDown ונשמרת לפי המקש הפיזי; Repeat ו-Up מקבלים את המקש הלוגי שנשמר ולא בודקים NumLock שוב. בדיקה: `שחרור אחרי החלפת NumLock מזווג למקש שנבחר בלחיצה` — לחיצה בלי NumLock, החלפת NumLock, שחרור → שני האירועים `arrowUp` ואין מקש תקוע.

3. **המיפוי הלוגי** — מקום מרכזי אחד (`lib/shortcuts/numpad_navigation_keys.dart`) עוטף את `PlatformDispatcher.onKeyData` ומחליף רק את `logical` כש-`HardwareKeyboard.lockModesEnabled` לא מכיל `numLock`: 7→Home, 8→↑, 9→PgUp, 4→←, 6→→, 1→End, 2→↓, 3→PgDn, 0→Insert, נקודה→Delete. כיוון שזה לפני `HardwareKeyboard` והפוקוס, כל מקום שמשווה ל-`arrowUp`/`home`/`end` (הקורא, `simple_text_viewer`, PDF, `ShortcutHelper`, ה-`ScrollIntent` של Flutter) עובד בלי לגעת בו. עם NumLock דולק אין שינוי, גם Ctrl+ספרון למעבר טאב (נבדק). Windows בלבד.

נקודה להחלטה: בלי NumLock, Ctrl+ספרון 1 הופך ל-Ctrl+End (כמו בשאר Windows) ולא מעבר לטאב 1. מעבר טאב עם הספרון עובד כרגיל כש-NumLock דולק.
