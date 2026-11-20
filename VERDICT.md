READY
QA בלתי תלוי ל-prbody/2435-fix (פיצ'ר לפי ההחלטה של Y-PLONI מ-3.11).
ענף: feat/light-page-dark-mode-2435, ראש e02f95e1add7e30d32bb024bc5e04838c1ec2679.
- נוסף קומיט QA אחד: e02f95e1a (מוק: updateLightReaderPageInDarkMode ב-MockSettingsRepository). זה פותר את ההחלטה הפתוחה שהמפיק ציין.
- כותרת ה-PR: תיקון issue #2435 — דף הספר בהיר גם במצב כהה
Closes #2435. ה-issue פתוח ואין בו פעילות מאז 3.11. אין PR פתוח שמכסה אותו.
כשל בבסיס, על upstream/dev 9aea09eb:
- light_reader_page_test לא מתקמפל.
- ב-pdf_dark_mode_follows_theme_test נכשלו שתי בדיקות: היפוך נמצא 2 פעמים במקום 5, ו-mainContent לא עטוף.
קוד:
- כשההגדרה כבויה, ReaderPageTheme.of מחזיר את Theme.of(context). העטיפה ReaderPageScope מוסיפה Theme זהה, ReaderSurfaceScope (שכבר עוטף את reading_screen), צבע שקוף ו-Material שקוף. אין לזה השפעה נראית.
- TextBookViewerBloc נבנה רק ב-reading_screen.
- Material השקוף בתוך ColoredBox מבטיח שאפקטי ה-ink לא יוסתרו.
בדיקות קשורות (419 קבצים, -j 1):
- בענף: +5387 ~2 -2.
- בבסיס: +5382 ~2 -5.
- כישלונות הענף הם תת-קבוצה של כישלונות הבסיס (הרשאות, ריצה כ-root).
- ענף ממוזג עם dev: theme, ‏pdf_book ו-settings/l10n, ‏1377 עברו ו-0 נכשלו.
analyze ו-format נקיים. הקטלוג שנוצר מחדש זהה. ui_lint של הענף הממוזג זהה ל-dev.
התנגשויות: מול dev נקי. אין התנגשות חדשה מול 51 PRs פתוחים, כולל #5670 ו-#5581.
הערה: הבדיקות של החיבור ל-App ול-text_book_screen הן בדיקות מקור (grep), כמו בבדיקת ה-PDF הקיימת. ההתנהגות עצמה נבדקת על רתמה מקבילה.
החלטות פתוחות:
- חלונית המפרשים שליד PDF והרקע סביב עמודי ה-PDF נשארים כהים.
- WebView של תוספים לא כלול.
בדיקה חזותית: עברתי על הצילומים ב-qa-shots/2435. הדף בהיר והסרגל העליון כהה. ב-PDF אין צילום.
מומלצת בדיקה מקומית: PDF כולל דפדוף בתצוגת ספר, חלונית מפרשים מפוצלת, קריאה רציפה, וגם ידית חלונית הניווט בקצה הדף, שנצבעת בהירה.
