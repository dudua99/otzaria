READY
QA בלתי תלוי ל-prbody/5747-fix. לא נדרשו תיקונים; לא נדחפו קומיטים לענף.
ענף: dudua99/otzaria fix/rtl-line-end-caret-5747, HEAD 921d6574bfdd50ad48ca95e196483936629d6a58 (2 קומיטים מעל cee59520a; merge-tree מול upstream/dev העדכני effecedb8 נקי, לא נדרש מיזוג).
כותרת PR: תיקון issue #5747 — לחיצה בסוף שורה בשדה רב-שורתי משאירה את הסמן בשורה
Closes #5747 (פתוח; אין PR פתוח שנוגע ב-rtl_text_field.dart).
נכשל על הבסיס: rtl_text_field_line_end_tap_test על upstream/dev effecedb8 — 3 מתוך 4 נכשלות (caret y 36 במקום ~15; "שורה ראשונה\nX\nשורה שניה"; שורה מעורבת מתפצלת ל-3). בענף 4/4 עוברות.
שורש: עוקף #1716 (c4a623e72) — snapOffsetOutOfCrlf הופעל רק על הבקר הנקי; התיקון מצמיד גם את הבחירה הגולמית ב-_HardBreakController.value (11 שורות, פונקציה קיימת). שורש ולא עטיפה.
סקירה: offsets מחוץ לטווח/‎-1 לא מושפעים (הבדיקה ב-snapOffsetOutOfCrlf); חצים עוברים על \r\n כאשכול; ביטול/ביצוע חוזר עוברים באותו setter; composing לא משתנה.
בדיקות קשורות (flutter test -j 1): ענף 39 קבצים ‎+701 ‎-0; בסיס 38 קבצים ‎+697 ‎-0.
analyze/format נקיים; ui_lint זהה לבסיס.
קונפליקטים: 56 PRs פתוחים — אין קונפליקט חדש לעומת dev.
החלטות פתוחות: אין. מומלצת בדיקה ידנית קצרה ב-Windows (לחיצה בסוף שורה בטופס הדיווח והקלדה).
