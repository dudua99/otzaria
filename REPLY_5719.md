@Y-PLONI תודה, צדקת בשתי הנקודות. תוקן בקומיט dce057c69:

1. **הקיצור חזותי בלבד.** הכותרת המוצגת עדיין מתחילה ב"…", אבל בחירה והעתקה (Ctrl+C, תפריט "העתק" וגם הדבקה ל-Word) מחזירות את הכותרת המלאה: "…" מוחלף בחלק שהושמט. בחירה חלקית בתוך החלק הגלוי לא משתנה.
2. **חיתוך רק בגבול כותרת.** החלוקה נעשית לפי שרשרת הכותרות האמיתית מתוכן העניינים (`headingPathFromTocList`) ולא לפי ", ". לכן פסיק בתוך כותרת (למשל פסקת Word שסומנה ככותרת) לא נחשב נקודת חיתוך. אם אין מקום לכותרת העמוקה יחד עם "…, ", היא מוצגת לבדה ונחתכת מסופה. אם השרשרת לא תואמת לכותרת, אין קיצור מההתחלה (כמו לפני ה-PR).

**בדיקות** (`flutter test -j 1` על 32 קבצים שמייבאים את ref_helper / text_book_screen / app_selection_area):
- עכשיו: 335/335 עברו. בראש ה-PR הקודם: 332/332.
- נוספו 3 בדיקות:
  - העתקת כותרת מקוצרת מחזירה את הכותרת המלאה.
  - בבדיקה ווידג'ט, כותרת עמוקה עם פסיק לא נחצית.
  - בבדיקת יחידה, פסיק בתוך כותרת אינו נקודת חיתוך.
- שתי בדיקות הווידג'ט נכשלות על הקוד הקודם: `'…, סעיף יג'` במקום הכותרת המלאה, ו-`'…, ובעלי חי'`.
- `dart analyze` ו-`dart format` נקיים. ui_lint בלי הפרות חדשות.

**צילומים** (לפני → אחרי):
- כותרת עמוקה עם פסיק, 880px: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/before/comma_heading_w880.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/after/comma_heading_w880.png)
- אותו מצב עם בחירה: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/before/comma_heading_w880_selected.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/after/comma_heading_w880_selected.png)
- כותרת רגילה, 820px. התצוגה זהה, רק ההעתקה השתנתה: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/before/long_w820_selected.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/5712-cr/qa-shots/5712-cr/after/long_w820_selected.png)
