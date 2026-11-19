READY
סיבה: getAllInstalledPlugins הריץ select מלא + פענוח manifest לכל תוסף בכל קריאה ב-UI; נשמר עכשיו עם ביטול לפי total_changes/data_version.
ענף: fix/installed-plugins-cache-4722, head 7179ecc1608dbe1cdbd4fd9a416e7e6d170b11a1 (2 commits מעל upstream/dev 4d4e7011b).
כותרת PR: תיקון issue #4722 — רשימת התוספים המותקנים נקראת מהמסד רק אחרי שינוי
שורש: אין נסיגה בודדת; חשיפה דרך plugin.listInstalled (c8beed701) ו-plugin.openOther (0ed4ada62), תת-שאילתות מ-dc485fcf1.
בדיקת אימות: נכשלת על dev, עוברת בענף.
בדיקות קשורות: ענף 4798 עברו/21 דולגו/3 נכשלו; dev 4793/21/3 — אותן 3 כשלונות (הרשאות קבצים תחת root), ההפרש = 5 הבדיקות החדשות.
analyze/format נקיים; ui_lint זהה ל-dev.
קונפליקטים: 27 PR פתוחים נבדקו ב-merge-tree — אין קונפליקט חדש; אף אחד לא נוגע ב-plugin_system_database.dart.
החלטה פתוחה: הקורא שחוזר מאות פעמים בזמן עדכוני חנות לא זוהה בוודאות (כנראה plugin.listInstalled מתוסף החנות); התיקון מכסה את כל הקוראים. palmoni5 ביקש לזהות את הקורא — כדאי לציין זאת בדיון.
ביטול מטמון: גם כתיבות KV מה-isolate מבטלות אותו (data_version) — שמרני ונכון, אך פחות יעיל אם תוסף כותב KV בין כל קריאה.
בדיקה ויזואלית: לא נדרשת (אין שינוי ממשק).
