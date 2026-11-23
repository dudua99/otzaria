READY
QA בלתי תלוי ל-fix/commentators-tab-restore-position-5798 — לא נדרשו תיקונים, לא נדחפו קומיטים.
ראש הענף: fe49dcce00e096471e58bba00738d7acbbbb1b5d (2 קומיטים מעל dev).
כותרת PR: תיקון issue #5798 — כרטיסיית מפרשי PDF שומרת את הכותרת שאליה נווט בה
Closes #5798 (הסוגיה פתוחה, 0 תגובות, אין PR פתוח אחר עליה).
הוכחת כישלון על dev (5a12c2325): הבדיקה החדשה נכשלת — ref = 'מפרשים | משנה ברכות משנה ב' במקום 'משנה ז'; בענף עוברת.
שורש: נכון — הכותרת שנבחרה חיה רק ב-_selectedHeadingIdx, בעוד toJson/bookmarkFromReadingTab קוראים את sourceTab (מאז d791d0275; 7a8ff8fa9 תיקן רק טקסט).
סקירה: כל יוצרי PdfCommentatorsTab (of/fromJson/tabFromBookmark) נותנים sourceTab פרטי — הכתיבה ל-currentTitle/pageNumber לא מזיזה את טאב ה-PDF הראשי. מפתחות הכותרות ייחודיים (Map), לכן החזרה המוקדמת בסנכרון בטוחה. השחזור והסנכרון כותבים ל-_headingIdx ישירות ולא נרשמים חזרה.
בדיקות (pdf_book, tabs, bookmarks, navigation, workspace_split_tabs, payload_roundtrip, app_report_collector; -j 1):
  ענף: 2620 עברו, 1 דולג, 1 נכשל | dev (עם הבדיקה החדשה): 2619 עברו, 1 דולג, 2 נכשלו
  הכישלון המשותף: checkLibraryIsEmpty באנדרואיד (#1483) — סביבת root, קיים גם ב-dev.
analyze/format נקיים בקבצים שנגעו; ui_lint — 80 שורות זהות לענף ול-dev.
קונפליקטים: merge-tree נקי מול dev הנוכחי (dev התקדם 3 קומיטים, לא נוגעים בקבצים); אין קונפליקט חדש מול 83 PRs פתוחים.
החלטה פתוחה: שמירה ברמת כותרת בלבד (לא פסקה).
בדיקה חזותית מקומית מומלצת בקצרה: כותרת הכרטיסייה ברצועה מתעדכנת לכותרת הנוכחית בניווט (PDF עם ספר טקסט מקביל, ניווט, סגירה ופתיחה).
