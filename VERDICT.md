READY
משימת כיסוי בדיקות (#4490, milestone 0.9.99, ‏tests only). לא נמצא באג, ולכן אין קומיט תיקון: קומיט אחד של בדיקות בלבד, לא 2 כמו בהוראות הכלליות.
ענף: test/db-worker-lifecycle-recovery-4490, ראש 40d0574b5469c50ce3ebc4fbcdc38aca32ff5299 (קומיט אחד מעל upstream/dev 7f2b6c4ec).
כותרת PR: בדיקות: התאוששות lifecycle של DbReadWorker אחרי #4423 (issue #4490)
Refs #4490 (לא Closes): DbReadWorkerBusy במסלולי refresh/reset בממשק לא כוסה.
כוסה:
- סעיף 1: פקודות אחרי ש-lifecycleState נשלח, עם קריאה ממתינה ובלעדיה.
- סעיף 2: פירוק בזמן תשובה ממתינה + שינוי שנצבר.
- סעיף 3: closeForExternalWrite עם תור בקרה מלא דרך worker אמיתי, ומדידת השהיה עם החלטה מתועדת ב-BODY.
יציבות: 20/20 ריצות עברו. האותות הם checkpoint ו-sentMessageCount, בלי sleep.
בדיקות (3 קבצים):
- ענף: ‎+90
- בסיס: ‎+86
- 0 כשלים ו-0 דילוגים בשניהם.
analyze/format נקיים. אין שינוי UI, ולכן ui_lint לא רלוונטי.
קונפליקטים: merge-tree נקי, ואין קונפליקט חדש מול 42 ה-PR הפתוחים (כולל #3442 שנוגע ב-db_read_worker_test).
החלטה פתוחה: האם להשלים את סעיף refresh/reset ב-PR נפרד.
בדיקה חזותית: לא רלוונטית.
