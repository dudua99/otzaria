## מה היה שבור

ב-Windows וב-Linux, בתוספים שיש בהם תפריט שנגלל לרוחב, גלילה אופקית בתפריט (בלוח מגע או במסך מגע) גללה את התפריט וגם הזיזה את הכרטיסייה כולה.

## הסיבה

ב-Windows וב-Linux ה-WebView של התוסף מקבל את הגלילה דרך `Listener` ולא מתחרה בזירת המחוות של Flutter. מאז 52c60c068 (מחוות גלילה אופקית למעבר בין טאבים) מזהי החלקת הכרטיסיות (`TrackpadTabSwipeRecognizer` ו-`TouchTabSwipeRecognizer` ב-`TabSwipeDetector`) עוטפים את כל תוכן הכרטיסיות, כולל התוסף. אין מזהה אחר בזירה, ולכן הם זכו בכל גרירה אופקית מעל התוסף, בזמן שהדף עצמו נגלל. 497efb741 טיפל רק בגלילה אנכית.

ב-macOS הבאג לא קורה: מאז 4d3622c16 (#3161) ה-WebView מעביר ל-Flutter רק החלקה שהדף לא השתמש בה.

## התיקון

ב-`buildPluginTabBody` (`lib/plugins/view/plugin_tab_page.dart`), ב-Windows וב-Linux בלבד, ה-WebView עטוף במזהה גרירה אופקית (trackpad ומגע) שלא עושה כלום. הוא עמוק יותר בעץ, ולכן זוכה לפני החלקת הכרטיסיות, בדיוק כמו רכיב Flutter שנגלל לרוחב. הגלילה ממשיכה לעבור לדף כמו קודם. עכבר, גלילה אנכית, macOS, מובייל ומצב HWND לא השתנו.

השלכה: ב-Windows וב-Linux, מעל תוסף, החלקה אופקית כבר לא מעבירה כרטיסייה בלוח מגע ובמסך מגע, גם בתוסף שאין בו תוכן שנגלל לרוחב. Flutter לא יכול לדעת שם מראש אם הדף משתמש בגלילה (ב-macOS הפורק של flutter_inappwebview יודע, ושם ההחלקה נשמרת). מעבר בין כרטיסיות דרך שורת הכרטיסיות והקיצורים נשאר כמו שהיה, וגם החלקה מעל ספרים ו-PDF.

Closes #3640

## בדיקות

- בדיקה חדשה `test/plugins/view/plugin_tab_horizontal_scroll_test.dart`: `TabSwipeDetector` אמיתי ו-`buildPluginTabBody` אמיתי, עם `Listener` במקום ה-WebView. גרירה אופקית ב-trackpad ובאצבע ב-Windows וב-Linux לא מזיזה את ה-PageView, והדף עדיין מקבל את הגלילה. ב-macOS ובמובייל לא נוספת עטיפה. על upstream/dev נכשלות 4 בדיקות, ואחרי התיקון כל 7 עוברות.
- `flutter test -j 1 test/plugins/view test/tabs test/tools/tool_tab_reload_stability_test.dart`: בענף 1252 עברו, 4 דולגו, 0 נכשלו. בבסיס (upstream/dev) 1245 עברו, 4 דולגו, 0 נכשלו (ההפרש הוא 7 הבדיקות החדשות).
- הבדיקה החדשה ו-`tab_swipe_detector_test` עוברות גם על מיזוג עם #5560 (יחד עם `tab_content_vertical_drag_recognizer_test`: 17 עברו).
- `dart analyze` ו-`dart format` נקיים בקבצים שנגעתי בהם. `tool/ui_lint_cli.dart`: 0 הפרות חדשות.

<!-- SUITE -->
