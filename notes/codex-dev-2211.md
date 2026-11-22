# Findings that still apply to upstream dev (owner's Codex reviewer, 22.11)

Each finding was posted on an already merged/closed PR; it describes code that is in upstream/dev now. Verify on CURRENT upstream/dev first.

## From PR #5656 (MERGED, by dudua99) — תיקון issue #4919 — טיפ "הידעת?" שמלמד ש-Esc מסיר הדגשה מקישור
comment: https://github.com/Otzaria/otzaria/pull/5656#issuecomment-7079189431

**ממצא לתיקון ב־dev: הטיפ יכול להופיע אחרי שההדגשה כבר נעלמה.** `_linkHighlightSeen` מתאפס רק בעקבות `linkHighlightCleared`, שנשלח במסלול Esc. חיפוש חדש יכול לנקות את `permanentHighlightLine` בלי לשלוח אותו, וגם מעבר לטאב אחר משאיר את הדגל דלוק. אם טיפ אחר דחה את הצגתו, אפשר לקבל טיפ על הסימון הצהוב כשכבר אין סימון. בדקתי שהדגל עדיין קיים ב־`dev`. אנא קשרו את הצגת הטיפ להדגשה בטאב הפעיל, והפרידו זאת מרישום שמשתמש למד את הקיצור.

## From PR #5674 (MERGED, by dudua99) — תיקון issue #4231 — קישורי קטגוריה ומחבר בתוצאות האיתור בספרייה
comment: https://github.com/Otzaria/otzaria/pull/5674#issuecomment-7079193018

**ממצא לתיקון ב־dev: לקישורי המחבר והקטגוריה אין נתיב פוקוס במקלדת.** `_RowLinks` מחווט Enter, רווח ו־Numpad Enter בתוך הקישורים, אבל כל השורה עטופה ב־`ExcludeFocusTraversal`. לכן המקלדת מגיעה לשורת הספר, בעוד שהפעולות שמקבלות את קיצורי המקלדת נשארות מחוץ למסלול. בדקתי שהעטיפה עדיין קיימת ב־`dev`. אנא הוסיפו דרך להגיע לקישורים מתוך השורה, ובדקו הפעלה של קישור מחבר ושל קטגוריה בלי עכבר.

## From PR #5680 (MERGED, by dudua99) — תיקון issue #5271 — קישורים נכנסים לתוספים ב-library.getLinks
comment: https://github.com/Otzaria/otzaria/pull/5680#issuecomment-7079194996

**ממצא לתיקון ב־dev: סינון לפי ספר יכול לבטל את תקרת השליפה של קישורים נכנסים.** ב־`PluginBridgeAdapter` גם רשימת כותרות מדויקות וגם תחיליות מעבירות `limit: null`. ה־provider משתמש ב־`toMapList()` ורק לאחר מכן ה־bridge מסנן ומחיל את תקרת התוצאה. בטווח צפוף זה יכול לטעון הרבה רשומות גם כשהתוסף ביקש ספר יחיד. בדקתי שהמסלול עדיין קיים ב־`dev`. אנא העבירו מסנן שניתן ליישם לשאילתת האחסון, או סרקו במנות עד שנמצאות `remaining + 1` התאמות.

## From PR #1059 (MERGED, by dudua99) — איתור: תת-מחרוזת בשם המסכת מחזירה תוצאות — תיקון הרעבת ההתאמות המוכלות
comment: https://github.com/Otzaria/otzaria/pull/1059#issuecomment-7079239481

**ממצא לתיקון ב־dev: מכסת תת־המחרוזת לא נשמרת כשהרלוונטיות ממלאת את כל התקרה.** אחרי ש־`end` מגיע ל־`_maxResultCap`, רשימת `capped` כבר מלאה, ולכן התנאי `capped.length < _maxResultCap` מונע הוספת התאמה מהזנב. המקרה עדיין קיים ב־`dev`. אנא שמרו מראש מקום מתוך התקרה כשיש התאמות תת־מחרוזת מחוץ לחיתוך, ובדקו התנגשות עם קבוצת רלוונטיות שממלאת את התקרה.

## From PR #2004 (MERGED, by dudua99) — תיקון issue #1978 — חתימה לקריסה נייטיבית מתוך ה-minidump
comment: https://github.com/Otzaria/otzaria/pull/2004#issuecomment-7079304644

**ממצא פרטיות לתיקון ב־dev: דוח קריסה כולל תמונת זיכרון כברירת מחדל.** `AppReportEditing` עדיין מאתחל `includeMinidump = true`. המסך מסביר שהקובץ עשוי להכיל את הטקסט שהיה פתוח, אבל לחיצה רגילה על ״שלח״ תצרף את הקובץ אם המשתמש לא שינה את הסימון. אפשר לשלוח את חתימת הקריסה המחושבת כברירת מחדל ולבקש בחירה מפורשת לצירוף הקובץ הגולמי. אנא בדקו שדיווח חדש משמיט את הקובץ עד שבוחרים לצרף אותו. [תיעוד Microsoft על תוכן minidump](https://learn.microsoft.com/en-us/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_type)

## From PR #2092 (MERGED, by dudua99) — הוראות לסוכנים: בדיקת PRs פתוחים של תורמים אחרים
comment: https://github.com/Otzaria/otzaria/pull/2092#issuecomment-7079338541

**ממצא לתיקון ב־dev: פקודת הסריקה בתיעוד מציגה רק 30 PRים כברירת מחדל.** `AGENTS.md` עדיין מורה על `gh pr list` ללא `--limit`, ובבדיקה הנוכחית יש 58 PRים פתוחים במאגר. לכן אפשר לפספס PR חופף שהוא מוקדם יותר ברשימה. אנא הרחיבו את התקרה או השתמשו בשליפה עם דפדוף, כדי לקיים את הבדיקה על כל ה־PRים הפתוחים. [תיעוד gh pr list](https://cli.github.com/manual/gh_pr_list)

## From PR #2413 (MERGED, by dudua99) — תיקון issue #2381 — רשימת הספרים להסתרה קופאת בגרירת פס הגלילה לסוף
comment: https://github.com/Otzaria/otzaria/pull/2413#issuecomment-7079445853

**ממצא לתיקון ב־dev: ספרים באותו שם יכולים להיות בלתי ניתנים להבחנה בבורר ההסתרה.** `CheckboxListTile` מקצר כותרת ונתיב לשורה אחת, ושני נתיבים ארוכים עם אותה תחילית יכולים להיראות זהים בחלון צר. הבורר אינו חושף את הנתיב המלא לצפייה. כך אפשר לסמן בטעות ספר אחר להסתרה. אנא שמרו את הפריסה בגובה אחיד והוסיפו דרך לראות את הכותרת והנתיב בשלמותם, גם במגע.

## From PR #2620 (MERGED, by dudua99) — ביצועים: כותרות ה-PDF ממוינות פעם אחת לספר במקום בכל מעבר עמוד (4.5ms → 0)
comment: https://github.com/Otzaria/otzaria/pull/2620#issuecomment-7079482006

**ממצא לתיקון ב־dev: מטמון הכותרות יכול להציג מיון ישן מול `headingsMap` מעודכנת.** `PdfHeadings` שומר את המפה שנמסרה בבנאי, והמפה עצמה ניתנת לשינוי גם דרך השדה הציבורי. אחרי קריאה ל־`getSortedHeadings`, שינוי במפה יופיע בחיפוש הישיר אך לא ברשימה שכבר נשמרה. אנא קבעו צילום בלתי ניתן לשינוי בבנאי, או בטלו את המטמון בעת שינוי, והוסיפו בדיקה למפה שמעדכנים אחרי הקריאה הראשונה.

## From PR #2629 (MERGED, by dudua99) — תיקון issue #2536 — הקלדה במצב החכם לא נקלטה עד לחיצה על השדה
comment: https://github.com/Otzaria/otzaria/pull/2629#issuecomment-7079485534

**ממצא לתיקון ב־dev: בקשת המקלדת יכולה להחזיר פוקוס לשדה שהמשתמש כבר עזב.** התנאי `hasPrimaryFocus` נבדק לפני `addPostFrameCallback`, ובתוך הקריאה החוזרת נבדק רק `mounted`. אם פקד אחר קיבל פוקוס או שהמסך עבר לרקע באותו פריים, `EditableTextState.requestKeyboard` יכול לבקש פוקוס בחזרה ולפתוח את המקלדת. אנא בדקו את הפוקוס והמסך בעת ביצוע הקריאה החוזרת, והשאירו את מסלול ה־autofocus המפורש בנפרד. [תיעוד Flutter](https://api.flutter.dev/flutter/widgets/EditableTextState/requestKeyboard.html)

