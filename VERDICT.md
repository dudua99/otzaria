READY
הבעיה: וי בצ'יפ נבחר באפשרויות המילה מרחיב אותו ב-16px ומזיז את השאר ב-Wrap.
שורש: fef55e67f החליף תיבות סימון ב-FilterChip (showCheckmark ברירת מחדל true).
התיקון הסופי מקומי: showCheckmark: false רק בצ'יפים של חלונית החיפוש (advanced_search_controls + 3 ב-search_dialog). ה-chipTheme הכללי חזר ל-dev (commit 6577d99f1), כך ששאר המסכים לא משתנים. אין במסמכי העיצוב כלל שמצדיק שינוי גלובלי; יש תקדים מקומי (measurement_converter, app_popup_menu).
נגישות: הבחירה ניכרת במילוי secondaryContainer ובהיעלמות המסגרת; הבדיקה מוודאת semantics isSelected.
ענף: fix/filter-chip-checkmark-5562, head 6577d99f1b8cbfbe5fad2d3de3f26e19a5b5670c (ה-QA הזה לא הוסיף commits).
כותרת PR: תיקון issue #5562 — בחירת צ'יפ לא מזיזה את שאר הצ'יפים
Closes #5562
בדיקות (search+design_system+theme): ענף 1892/4 דולגו/0 נכשלו; dev עם הבדיקה 1892/4/2 (שתיהן הבדיקה החדשה).
analyze/format נקיים; ui_lint_test עובר.
התנגשויות: merge-tree מול dev נקי; אין התנגשות חדשה מול 34 PRs פתוחים (#5249 נוגע ב-search_dialog וממוזג נקי).
Issue פתוח, אין תגובות ואין PR מתחרה.
צילומים: qa-shots/5562-v2 תואמים לתיקון הנוכחי.
החלטה פתוחה: אם mmichaelush ירצה להוריד את הווי בכל האפליקציה, זה שינוי נפרד ב-chipTheme.
בדיקה חזותית מקומית: לא הכרחית; אפשר להציץ בחלונית החיפוש.
