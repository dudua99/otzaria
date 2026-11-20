NOT READY
סיבה: ברירת המחדל שבהערות (סוג דיווח חמישי AppReportType.library דרך /api/app-reports עם תווית library) אינה ניתנת למימוש בצד הלקוח בלבד — השרת החי דוחה אותה.
ראיות (Otzaria/Otzaria_Website, ענף ברירת המחדל):
- src/lib/app-reports/validation.js: REPORT_TYPES = ['bug','crash','performance','suggestion'] — סוג 'library' יקבל 422.
- src/models/AppReport.js: type enum זהה (Mongoose) — גם דרך אחרת לא תישמר.
- src/lib/app-reports/issue-text.js: התוויות נבנות בשרת מ-type בלבד (issueLabels); אין בחוזה שדה label שהלקוח שולח.
- src/lib/app-reports/products.js: הניתוב לריפו לפי product, והמוצרים היחידים הם otzaria ו-offline-update — אין יעד otzaria-library.
- החוזה המשותף packages/otzaria_report_contract (AppReportType) משמש גם את האתר ואת Otzaria_Offline_update (error_reports_manager/lib/src/port/app_report.dart); שינוי חד-צדדי ייצור דיווחים שנדחים לצמיתות / נתקעים בתור — באג חדש.
חלופה קיימת בלי שינוי שרת: צינור דיווח הטעויות בספר (/api/reportingerrors, report_kind free_text) כבר מגיע לצוות הספרייה (מייל), והחוזה (docs/text-corrections/CONTRACT.md) מתיר free_text בלי מיקום מדויק; line_number ו-current_ref מקבלים ברירת מחדל בשרת. זה מתאים ל"בעיה כללית בספר זה" מתפריט ⋮ של ספר, אבל לבעיה כללית בספרייה (לא בספר) אין book_title — ולא ברור אם זה רצוי.
החלטה נדרשת ממתחזק (palmoni5 שאל את Y-PLONI ב-11.11, אין תשובה):
1) להרחיב את האתר (type/product חדש → otzaria-library) ואז לממש בלקוח את ברירת המחדל; או
2) להשתמש בצינור reportingerrors (free_text) עם ספר/בלי ספר; או
3) לא לממש.
בדיקה: issue #4891 פתוח, תגובה אחת (של palmoni5), אין PR פתוח שמכסה אותו.
לא נדחף ענף קוד (אין commits). שום שינוי לא בוצע.
