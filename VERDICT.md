READY
QA בלתי תלוי ל-#5905 (פתיחה מאיתור בוחרת את קטע היעד, לפי הנחיית palmoni5).
ענף: feat/select-itur-target-5905 @ dce7ad68712210f575bac06088dce3cdcea4a353 — ללא שינויים מה-QA (לא נדחפו קומיטים).
כותרת PR: תיקון issue #5905 — פתיחה מאיתור בוחרת את קטע היעד
Closes #5905. ה-issue עדיין פתוח, אין PR פתוח אחר שמכסה אותו.
כישלון על הבסיס: 4 בדיקות נכשלות על upstream/dev b68601ad5 (תוצאה עם מיקום, שורה 0, מפרש עם יעד, טאב בבלי חלופי), וכל 30 הבדיקות בקובץ עוברות בענף.
שורש: openBook לא העבירה selectLine ל-BookOpenCoordinator, והאיתור לא ביקש בחירה. התיקון משתמש במנגנון הקיים (linkSelectedLine → SelectLineWhenVisible). 5 שורות, אין דרך קצרה יותר.
#5904: הבחירה מתבצעת רק אחרי שהגלילה נחתה והשורה נראית (_onSelectionEvent בודק position.isTarget ו-visibleLines), ולכן _onScroll לא מנקה אותה.
PDF: OpenedTab.fromBook מתעלם מ-linkSelectedLine ל-PdfBook, ולכן אין השפעה. טאב שכבר פתוח: tabs_bloc קורא ל-updateLinkSelection.
בדיקות (97 קבצים, flutter test -j 1): ענף ‎+1872 ~5 -1, בסיס ‎+1867 ~5 -1. הכישלון היחיד זהה בשניהם (plugin_bridge_adapter, ריצה כ-root).
analyze ו-format נקיים. ui_lint: 80 מול 80, זהה מלבד מספרי שורות.
merge-tree מול upstream/dev נקי. נבדקו 71 PR פתוחים, ואין קונפליקט חדש.
החלטה פתוחה: גם מפרש מתפריט המפרשים באיתור בוחר את קטע היעד שלו. זה סביר ועקבי, אבל לא נאמר במפורש בהנחיה.
בדיקות היחידה בודקות את linkSelectedLine בטאב. הבחירה עצמה בתצוגה מכוסה על ידי deep_link_select_test הקיים.
מומלצת בדיקה מקומית קצרה: "משלי כד, כו" ו-Enter, בתצוגה רגילה ובמשולבת. לוודא שהפס מופיע והמפרשים עוברים.
