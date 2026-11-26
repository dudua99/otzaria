READY
באג #6066: במצב מנותק תוסף עם הרשאת רשת (ריצת רקע של החנות) עדיין פנה לאינטרנט. שער הרשת והמדיניות של ה-WebView לא בדקו את keyOfflineMode.
ענף: fix/plugin-network-offline-mode-6066, head c675b1bdc59c608a385f0b7608ba290796eb646b (2 קומיטים מעל upstream/dev 4fe1973a4).
כותרת PR: תיקון issue #6066 — במצב מנותק תוספים לא ניגשים לאינטרנט
שורש: חסימת מצב מנותק נעשתה רק בממשק (3b20a2b68, ee2228ccb). evaluatePluginNetworkAccess ו-resolvePluginNetworkPolicy התעלמו ממנו.
תיקון: offlineMode בשער (לפני ההרשאות, חוץ מ-loopback); המדיניות בלי יעדים מרוחקים; notifyChanged בשינוי המצב; error.unavailable בגשר; משפט ב-API_REFERENCE.
החלטות שלי (כתובות ב-BODY): loopback מותר במצב מנותק; Settings לא מאותחל = מחובר; error.unavailable (קוד קיים) במקום קוד חדש.
הנושא משויך ל-palmoni5 (אישור חד-פעמי של הבעלים 26.11). אין PR פתוח עבורו.
לא בדקתי את קוד החנות: ייתכן שהיא מציגה פס גם בכשל. לכן Refs ולא Closes.
אין בדיקת גשר ל-error.unavailable: אין harness של network.* בגשר. המיפוי הוא case אחד ב-switch.
בדיקות test/plugins + test/settings (-j 1): ענף 5486/19/3, בסיס 5483/19/3. 3 הכשלים זהים ונובעים מהרשאות root.
analyze נקי, format נקי, ui_lint זהה לבסיס.
קונפליקטים: אין חדשים. #6065 נקי; #5740/#5688/#2788 מתנגשים כבר עם dev, ללא שינוי.
בדיקה ויזואלית: אין שינוי ויזואלי. מומלץ לבדוק ידנית: להפעיל מצב מנותק עם החנות מותקנת ולוודא שפס העדכונים לא מופיע, ושתוסף loopback (AI מקומי) עדיין עובד.
