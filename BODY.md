## מה היה שבור
בקורא הטקסט, מקשי לוח הספרות כש-NumLock כבוי (8/2 = חצים, 7/1 = Home/End, 9/3 = PageUp/PageDown) לא עשו דבר, בעוד שהמקשים הראשיים עובדים.

## הסיבה
מנוע Flutter ב-Windows מזהה את מקשי לוח הספרות לפי קוד הסריקה (`scanCodeToLogicalMap_` ב-`engine/src/flutter/shell/platform/windows/flutter_key_map.g.cc`, נבדק מול Flutter 3.47.7) ומדווח `numpad8`/`numpad2`/`numpad7`/... גם כש-NumLock כבוי. ההבדל היחיד הוא שאין להם תו (אין WM_CHAR).
המטפלים בקורא משווים את המקש הלוגי ל-`arrowUp`/`arrowDown`/`home`/`end`/`pageUp`/`pageDown` בלבד:
- `ProgressiveScroll._handleKeyEvent` (חצים ו-PageUp/PageDown, נוסף ב-0b07a7b88 #3272)
- `_handleGlobalKeyEvent` ב-`text_book_screen.dart` (Home/End, 57d7ccf2b)

זו לא רגרסיה: הטיפול נכתב מלכתחילה על המקש הראשי בלבד.

## התיקון
פונקציה אחת, `navigationKeyOf` (`lib/shortcuts/numpad_navigation.dart`): מקש לוח ספרות **בלי תו ובלי Ctrl/Alt/Meta** נחשב למקש הניווט שהוא מסמן; בכל מקרה אחר מוחזר המקש המקורי. שני המטפלים שלמעלה משתמשים בה במקום `event.logicalKey`.
- NumLock דולק (יש תו) — ספרה, כמו היום.
- Ctrl+ספרה בלוח הספרות (גם בלי NumLock, אז אין תו) — ממשיך לעבור ללשונית; לא נגעתי במפת הספרות.
- שדות טקסט — ללא שינוי.

לא כלול (אפשר בהמשך באותה פונקציה): תצוגת צורת הדף (`simple_text_viewer.dart`) וקורא ה-PDF.

Closes #5212

## בדיקות
- `reader_page_keys_test`: numpad3/numpad9 בלי תו גוללים עמוד כמו PageDown/PageUp, numpad2 גולל למטה, ו-numpad3 עם התו '3' (NumLock דולק) לא גולל — נכשלה על dev (0 במקום 480 פיקסלים).
- `text_book_screen_actions_test`: numpad1/numpad7 בלי תו קופצים לסוף/תחילת הספר — נכשלה על dev.
- `flutter test -j 1 test/shortcuts/ test/widgets/ test/text_book/view/`: ענף: 4231 עברו, 1 דולגה, 1 נכשלה; בסיס (upstream/dev 4fe1973a4): 4227 עברו, 1 דולגה, 1 נכשלה. הכישלון היחיד זהה בשניהם וקיים מראש (`page_shape_super_commentary_wait_test`: "מפרש שמור שאינו ברשימה... אינו נתקע בטעינה אינסופית"), ואינו קשור לשינוי.
- `dart analyze` ו-`dart format` נקיים על הקבצים שנגעתי בהם; `ui_lint_cli` — אין הפרות חדשות.

<!-- SUITE -->
