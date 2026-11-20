READY
QA עצמאי ל-#4490: משימה של בדיקות בלבד. Refs #4490, כי מסלולי refresh/reset עם DbReadWorkerBusy לא כוסו, כפי שהיוצר ציין. ה-issue פתוח, ואין PR פתוח אחר עליו.
ענף: test/db-worker-lifecycle-recovery-4490, ראש 40d0574b5469c50ce3ebc4fbcdc38aca32ff5299 (קומיט אחד מעל 7f2b6c4ec). לא הוספתי קומיטים.
כותרת PR: בדיקות: התאוששות lifecycle של DbReadWorker אחרי #4423 (issue #4490)
אין קומיט תיקון, כי לא נמצא באג. לכן אין "נכשל על dev". במקום זה בדקתי מוטציות בקוד המוצר, וכל אחת מחמש המוטציות הכשילה לפחות בדיקה אחת:
- בלי `_lifecycleRecovery != null` בבדיקת התור המלא: 2 בדיקות נכשלו.
- `mustClose |=` הוחלף ב-`=`: בדיקה 1 נכשלה.
- `_tearDown` לא מכשיל את ההתאוששות הדחויה: בדיקה 1 נכשלה.
- `closeForExternalWrite` מתעלם מ-readWorkerReleased: בדיקה 1 נכשלה.
- כשל בלי reopenAfterExternalWrite: בדיקה 1 נכשלה.
יציבות: 10/10 ריצות של הקבוצה החדשה עברו (ובנוסף 20/20 אצל היוצר). אין sleep לסנכרון. יש polling עם deadline, והשהיה של 20 מ"ש רק לבדיקת היעדר שליחה.
בדיקות: db_read_worker_test, db_read_worker_compressed_test, sqlite_data_provider_write_session_test.
- ענף: 90 עברו, 0 נכשלו, 0 דולגו.
- בסיס 7f2b6c4ec: 86 עברו, 0 נכשלו, 0 דולגו.
analyze ו-format נקיים. אין שינוי UI.
קונפליקטים: הענף מתמזג נקי עם upstream/dev העדכני (1acfc0d78, שלא שינה את data_providers). אין קונפליקט חדש מול 42 ה-PR הפתוחים.
החלטה פתוחה: האם לכסות את refresh/reset עם DbReadWorkerBusy ב-PR נפרד.
בדיקה חזותית: לא רלוונטית.
