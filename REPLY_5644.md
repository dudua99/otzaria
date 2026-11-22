@Bshlomecha @Nathaniel-260 תודה. עודכן בקומיט 0ac3d1322:

- **ניסוח:** הוחל הנוסח הראשון שהציע Bshlomecha: "מיזוג לעץ הספרייה הכללי" / "בנפרד ב׳ספרים אישיים׳". גם האנגלית עודכנה (Merge Into the Main Library Tree / Separately in "Personal Seforim"), והקטלוג נוצר מחדש במחולל.
- **עיצוב (לבקשת Nathaniel-260):**
  - הוסרה שורת ההסבר שמתחת לכותרת, וגם הטולטיפ הנוסף.
  - הבורר חזר לצד הכותרת, כמו בשורת "צירוף מסד" שמעליו.
  - הבורר יורד מתחת לכותרת רק כשהתוויות המלאות לא משאירות לה מקום. ההחלטה נעשית לפי מדידה, כולל הגדלת טקסט, ולא לפי רוחב קבוע.
  - בטלפון התווית המלאה נשברת לשתי שורות ולא נחתכת.

**בדיקות** (`flutter test -j 1` על 44 קבצים: attached_libraries והקבצים שמייבאים את הפאנל, לשונית הספרייה או קטלוג ההגדרות):
- עכשיו: 694/694 עברו. בראש ה-PR הקודם: 693/693.
- הבדיקות עודכנו:
  - התוויות החדשות מוצגות ואין שורת הסבר.
  - ברוחב גדול הבורר לצד הכותרת.
  - ב-360px הבורר מתחת לכותרת, עם התוויות המלאות ובלי גלישה.
- `dart analyze` ו-`dart format` נקיים. ui_lint בלי הפרות חדשות.

**צילומים** (לפני → אחרי):
- 1000px: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/before/light_w1000_x1.0.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/after/light_w1000_x1.0.png), כהה: [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/after/dark_w1000_x1.0.png)
- 760px: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/before/light_w760_x1.0.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/after/light_w760_x1.0.png)
- 360px בהגדלה 1.3: [לפני](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/before/light_w360_x1.3.png) → [אחרי](https://github.com/dudua99/otzaria/raw/qa-shots/2387-cr/qa-shots/2387-cr/after/light_w360_x1.3.png)
