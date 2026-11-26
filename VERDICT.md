READY
סיבה: אזור "הערות על המפרשים המוצגים" (commentary_notes_section.dart) מציג Text בתוך ListTile בלי AppSelectionArea, ולכן אי אפשר לסמן ולהעתיק. מקור הבעיה: 4cca990b9 (#1637).
ענף: fix/commentary-notes-selectable-5989, ראש: 4524d624ac19f477063157b9497600243ed69faf (2 קומיטים מעל upstream/dev 4fe1973a4).
כותרת PR: תיקון issue #5989 — סימון והעתקה בהערות על המפרשים המוצגים
Refs ולא Closes: את חלון הריחוף ואת הערת הצד (PersonalNoteContentView) לא הצלחתי לשחזר. Ctrl+C עם התו 'ב' מעתיק שם כבר על dev, ונוסף לבדיקה כרגרסיה. המדווח עוד לא ענה איזה מקום נכשל.
בדיקות (personal_notes + page_shape + app_selection_area, ‏-j 1): על dev ‏1124 עברו, 2 דולגו. בענף 1127 עברו, 2 דולגו. הבדיקה החדשה נכשלת על dev.
פלייק: page_shape_super_commentary_wait_test תלוי תזמון ונכשל גם על dev כשהוא רץ לבדו. בענף, page_shape לבדו עובר 335/335.
analyze/format: נקי. ui_lint: אין הפרות חדשות.
קונפליקטים: חדש אחד בלבד, מול PR #3036 (טיוטה של mmichaelush, "מרקר מובנה") ב-commentary_notes_section.dart. הסיבה: העטיפה מזיזה את ההזחה של ה-Column, ו-#3036 משנה שורות באותו build.
  כל מיקום אחר מתנגש גם הוא עם #3036, כי הוא נוגע גם ב-page_shape_screen ליד notesFooter וגם ב-personal_notes_sidebar ליד footer. עטיפה של title/subtitle בנפרד נבדקה ונפסלה: SelectableRegion הפנימי בולע את הלחיצה, וההערה לא נפתחת.
  הפתרון של הקונפליקט מכני (הזחה בלבד). #3036 כבר מתנגש עם dev גם בקבצים אחרים.
החלטה פתוחה לרכז: לאשר את הקונפליקט מול הטיוטה #3036.
בדיקה חזותית: אין שינוי במראה. מומלץ לבדוק מקומית ב-Windows: גרירת עכבר על תוכן ההערה באזור ולאחר מכן Ctrl+C (מקלדת עברית), ולוודא שלחיצה על ההערה עדיין פותחת אותה.
  הערה: בבדיקות widget, גרירה שמתחילה מחוץ לאותיות ב-ListTile בכיוון RTL לא יוצרת בחירה, גם ב-SelectionArea נקי של Flutter. גרירה שמתחילה על האותיות עובדת. לכן הבדיקה משתמשת ב-Ctrl+A.
