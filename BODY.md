## מה היה שבור
צביטה בשתי אצבעות בלוח מגע (Windows) בתוך תוסף העבירה לפעמים לטאב אחר במקום להישאר בתוסף. מספיקה סטייה אופקית קלה של מרכז הצביטה.

## שורש הבעיה
`TrackpadTabSwipeRecognizer` (יורש של `HorizontalDragGestureRecognizer`) מחשב רק את התזוזה (`pan`) של `PointerPanZoomUpdateEvent` ומתעלם מה-`scale`. בספרים `TouchPinchScaleRecognizer` מתחרה בזירה ומנצח את הצביטה, אבל מעל WebView של תוסף אין מתחרה, ולכן הצביטה נחשבה להחלקה בין טאבים.
ההחלקה בלוח מגע נוספה ב-52c60c068 („מחוות גלילה אופקית, למעבר בין טאבים”) בלי הבחנה בצביטה, וב-497efb741 היא הועברה ל-`TrackpadTabSwipeRecognizer`.

## התיקון
- `lib/tabs/utils/trackpad_tab_swipe_recognizer.dart`: לפני שההחלקה זוכה, `scale` שחורג מסף הרעש דוחה אותה (`GestureDisposition.rejected`). אחרי שההחלקה כבר זכתה היא לא נקטעת.
- הסף זהה לסף של `TouchPinchScaleRecognizer` (0.001, רעש DirectManipulation בגלילה), ולכן הקבוע שם נעשה ציבורי (`trackpadScaleSlop`). כך מה שנחשב צביטה שם לא ייחשב החלקה כאן.

העברת ה-scale ל-JS של התוסף ב-Windows נמצאת בפורק של flutter_inappwebview, מחוץ למאגר הזה. התיקון כאן מבטיח רק שהצביטה לא תעביר טאב.

Closes #3972

## בדיקות
- `test/tabs/reading_screen_move_tab_state_test.dart`: נוספו 2 בדיקות מעל משטח שמדמה WebView. בראשונה, צביטה (scale 1.3) עם סטייה אופקית של 150px לא מעבירה טאב (נכשלה לפני התיקון). בשנייה, החלקה עם רעש scale של 1.0005 עדיין מעבירה טאב.
- הרצה (`flutter test -j 1`) של test/tabs, test/plugins, test/text_book, test/pdf_book/pdf_input_gestures_test.dart ו-test/widgets/misc/touch_pinch_scale_recognizer_test.dart, על הענף ממוזג עם dev העדכני:
  - בענף: 7940 עברו, 18 דולגו, 2 נכשלו.
  - ב-dev: 7938 עברו, 18 דולגו, 2 נכשלו. אלה אותן 2 בדיקות שנכשלות גם בלי השינוי (plugin_bridge_adapter_test, page_shape_super_commentary_wait_test).
- הסף נבדק גם בתרחישים נוספים (לא נכללו בקוד): החלקה עם רעש scale מתחלף של ±0.0009 ו-scale שווה בדיוק 1 (כמו ב-macOS) מעבירות טאב; צביטה איטית בצעדים של 3px וצביטה פנימה (scale קטן מ-1) לא מעבירות.
- #5560 כבר מוזג ל-dev, והענף מתמזג איתו נקי.
- `dart analyze` ו-`dart format` נקיים, ו-ui_lint ללא הפרות חדשות.

<!-- SUITE -->
