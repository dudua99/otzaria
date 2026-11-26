READY
QA בלתי תלוי ל-#6066. ענף: fix/plugin-network-offline-mode-6066, head f326cf22420d0cb2bd5f84d54dbd91e8c7d079c6 (3 קומיטים מעל upstream/dev 4fe1973a4).
כותרת PR: תיקון issue #6066 — במצב מנותק תוספים לא ניגשים לאינטרנט · Refs #6066 (הפס מוצג על ידי תוסף החנות; את הקוד שלה לא בדקנו).
אימות: בבדיקה החדשה 2 מקרים נכשלים על dev (החסימה), ו-loopback עובר בשניהם. כולם עוברים בענף.
השורש נכון: evaluatePluginNetworkAccess/resolvePluginNetworkPolicy (3b20a2b68) לא בדקו את מצב מנותק; החסימה הייתה רק בממשק (ee2228ccb). השער הוא נקודת ההכרעה היחידה (גשר, WebView, פעולות דקלרטיביות), ולכן זה תיקון שורש.
קריאת הקוד: loopback נשמר גם במדיניות (accessGranted בתקופת המעבר), כמו בשער. ה-switch בגשר שלם (analyze נקי). מצב מנותק נכתב רק דרך SettingsBloc. סנכרון הגדרות מהתקן אחר (background_sync_initializer) לא שולח notifyChanged; השער עצמו קורא את ההגדרה בכל בקשה, כך שרק CSP של WebView שכבר פתוח מתעדכן בפתיחה הבאה. זה זניח.
קומיט QA: f326cf224 — בדיקה ש-UpdateOfflineMode שולח PluginNetworkPolicy.changes (חסרה. נכשלת על dev).
בדיקות test/plugins + test/settings (-j 1): ענף 5487/19 דולגו/3 נכשלו; בסיס 5483/19/3. 3 הכשלים זהים ונובעים מהרשאות root.
analyze/format נקיים; ui_lint זהה לבסיס; merge-tree מול dev נקי; אין קונפליקט חדש מול 41 PR פתוחים.
החלטות פתוחות (כתובות ב-BODY): loopback מותר במצב מנותק; Settings לא מאותחל נחשב מחובר; error.unavailable ולא קוד חדש. הנושא משויך ל-palmoni5 (אישור חד-פעמי של הבעלים 26.11), ואין לו PR פתוח.
בדיקה ויזואלית: אין שינוי ויזואלי. מומלץ לבדוק ידנית: מצב מנותק עם החנות מותקנת, לוודא שאין פס עדכונים ושתוסף AI מקומי עדיין עובד.
