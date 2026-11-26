## מה היה שבור
מאז שהמעבר לקטע הבא/הקודם (חיצים, כפתורי הקטע, Alt+חץ) גם בוחר את היעד (#3708), נקודת המוצא נשארה שורת ראש התצוגה. כשקטע באמצע המסך כבר היה נבחר, הלחיצה הראשונה בחרה את הקטע שאחרי ראש התצוגה — והבחירה קפצה לראש המסך במקום לעבור לקטע הבא אחרי הנבחר.

## סיבת השורש
9c79c5f14 ("עיון: מעבר לקטע הבא או הקודם בוחר אותו (#3708)") הוסיף `UpdateSelectedIndex(target)` ב-`_scrollByLines`, אבל השאיר `current = widget.tab.index` — מיקום הגלילה (השורה העליונה), לא הקטע הנבחר. לפני השינוי לא נבחר דבר, ולכן התחלה ממיקום הגלילה הייתה נכונה.

## התיקון
ב-`_scrollByLines` (`lib/text_book/view/text_book_screen.dart`): נקודת המוצא היא `state.selectedIndex` כשהקטע הנבחר נמצא בין השורות הגלויות (`tab.lines.position.value.visibleLines`), ואחרת ממיקום הקריאה כמו קודם.
- קטע נבחר שגללו הרחק ממנו אינו מושך את הקורא חזרה אליו — ממשיכים ממה שעל המסך. זה אותו כלל שכבר קיים בתצוגת צורת הדף (`simple_text_viewer`, חיצים למעלה/למטה).
- לחיצות רצופות: הבחירה והמיקום מתעדכנים ליעד מיד, ולכן ממשיכים ממנו גם לפני שהגלילה נחתה.
- בחירה מרובה (Ctrl+לחיצה): משתמשים ב-`selectedIndex` בלבד. מסלול התוסף (`PluginTextReaderRegistry`) לא השתנה.

Closes #6022

## בדיקות
- בדיקה חדשה ב-`test/text_book/view/text_book_screen_actions_test.dart`: ראש התצוגה בשורה 0 וקטע 3 נבחר — "הקטע הקודם" בוחר 2 (ב-dev: לא כלום); קטע 10 נבחר — "הקטע הבא" בוחר 11; קטע נבחר מחוץ למסך — ממשיכים ממיקום הקריאה. נכשלת על dev ועוברת עם התיקון.
- `flutter test -j 1 test/shortcuts/ test/text_book/view/` ועוד 8 קבצי בדיקה שמייבאים את `text_book_screen.dart` (`test/tabs/reading_screen_*`, `pdf_toolbar_book_title_test`, `view_switch_reuses_open_tab_test`, `design_system_hot_paths_perf_test`):
  - ענף: 2311 עברו, 0 נכשלו, 0 דולגו.
  - בסיס (upstream/dev 4fe1973a4): 2310 עברו, 0 נכשלו, 0 דולגו. ההפרש הוא הבדיקה החדשה.
  - כולל #5904 (`prev_segment_keeps_selection_test`, `side_arrow_navigation_test`) ובדיקת #3708.
- `dart analyze` ו-`dart format` על הקבצים שנגעו — נקי; `dart tool/ui_lint_cli.dart` — זהה לבסיס.

<!-- SUITE -->
