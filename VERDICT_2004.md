READY (החלטה פתוחה למתחזק: opt-in במקום opt-out לצירוף ה-minidump)
- ענף `fix/followup-2004`, ראש f2afa6652 (ללא שינוי ב-QA). כותרת: "תיקון המשך ל-#2004 — קובץ הקריסה (minidump) מצורף רק בבחירה מפורשת". ‏Refs #1978.
- הממצא קיים ב-dev ‏057aa1ba7 (`includeMinidump = true` ב-state, בטיוטה וב-fromJson).
- הבדיקה המעודכנת נכשלת על dev ועוברת בענף; היא בודקת גם שהחתימה נשלחת ושבחירה מפורשת מצרפת.
- סקירה: הסרת `!form.includeMinidump` מ-`_hasMeaningfulContent` נכונה — `form.minidump != null` כבר מכסה כל טופס שיש בו dump. אין קוראים נוספים לברירת המחדל (שני הדיאלוגים מעבירים את ה-state). טיוטה ישנה ששמרה true במפורש תמשיך לצרף — מקובל.
- test/app_report + test/reports על dev+ענף: ‏537 עברו, 0 נכשלו; על dev: ‏537/0 (בדיקה קיימת עודכנה).
- analyze/format נקיים; ui_lint ‏80 = 80. merge-tree נקי; אין PR פתוח שנוגע בקבצים.
- BODY: מדויק, ללא שינוי (הספירות שבו נמדדו על בסיס קודם, effecedb8).
