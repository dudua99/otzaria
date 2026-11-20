## מה היה שבור
פותחים מפרש מחלונית הצד (לחיצה על מפרש או על קישור) כשהמפרש כבר פתוח בטאב אחר, אבל בכותרת אחרת. במקום לעבור לטאב הקיים, נפתח טאב כפול. באיתור לעומת זאת הטאב הקיים מתמקד וגולל ליעד.

## הסיבה
`OpenOrFocusTab` מתאים טאב קיים של אותו ספר בלי להתחשב במיקום, ומנווט אותו ליעד, רק כשמגיע `navigateToPositionIfReused: true` (`tabs_bloc.dart`, `_onOpenOrFocusTab`). בלי הדגל נדרשת גם אותה כותרת מיקום, ובכל כותרת אחרת נוצר טאב חדש.

האיתור קיבל את הדגל ב-587eb949c ("איתור: מיקום מפורש גולל טאב פתוח של אותו ספר", #2587). קולבקי הפתיחה של חלונית המפרשים לא קיבלו אותו מעולם:
- `reading_screen.dart`: `TextBookViewerBloc.openBookCallback` ו-`CommentatorsTabScreen.openBookCallback`.
- בספר PDF: `openPreparedTab` מ-`pdf_book_screen.dart` ומ-`pdf_commentators_tab_screen.dart`.

זה לא רגרסיה של קומיט מסוים, אלא מסלול שנשאר מאחור כשהאיתור תוקן.

## התיקון
כמו שהמתחזק הציע ב-issue, גם הפתיחה מהחלונית משתמשת עכשיו במדיניות של האיתור:
- שני הקולבקים ב-`reading_screen.dart` שולחים `navigateToPositionIfReused: true`.
- `openPreparedTab` מקבל פרמטר `navigateToPositionIfReused` (ברירת מחדל `false`) ומעביר אותו ל-`BookOpenCoordinator.openTab`, שכבר תומך בו. חלונית המפרשים של PDF ושל כרטיסיית מפרשי PDF מעבירה `true`. תצוגה מקדימה בספרייה (`book_preview_panel`) לא השתנתה.

התוצאה: מפרש שכבר פתוח בטאב, או בחלונית של תצוגה מפוצלת (`_matchingPaneIn`), מתמקד ונגלל לקטע המבוקש. מפרש שלא פתוח עדיין נפתח בטאב חדש סמוך, כמו קודם.

הפעולה המפורשת "פתח כרטיסיית מפרשים" (`AddTab`) ממשיכה ליצור עותק. אין שינוי חזותי.

Closes #2840

## בדיקות
- בדיקה חדשה: `test/tabs/reading_screen_commentary_open_reuse_test.dart`. היא מרנדרת את `ReadingScreen` האמיתי עם טאב של ספר ושל המפרש שלו, וקוראת ל-`openBookCallback` שהמסך מעביר לחלונית. הבדיקה מוודאת שנשלח `OpenOrFocusTab` עם `navigateToPositionIfReused`.
  - על `dev` היא נכשלת (`Expected: true, Actual: false`), ובענף עוברת.
  - ההתנהגות של `TabsBloc` עם הדגל (מיקוד טאב קיים בכותרת אחרת וניווט ליעד) כבר מכוסה ב-`test/tabs/bloc/tabs_bloc_test.dart`.
- `flutter test -j 1 test/tabs test/utils test/pdf_book test/text_book/view`:
  - בענף: 6169 עברו, 42 דולגו, 1 נכשלה.
  - על `dev` (עם הבדיקה החדשה): 6168 עברו, 42 דולגו, 2 נכשלו.
  - הנפילה היחידה בענף היא `page_shape_super_commentary_wait_test` ("מפרש שמור שאינו ברשימה…"). היא נכשלת באותה צורה גם על `dev`, וידוע שהיא לא יציבה. הנפילה הנוספת על `dev` היא הבדיקה החדשה.
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים. `dart tool/ui_lint_cli.dart`: 0 הפרות חדשות.
- `git merge-tree` מול ה-PRs הפתוחים: אין קונפליקט חדש. ‏#5581 ו-#3036 נוגעים באותם קבצים ומתמזגים נקי.

<!-- SUITE -->
