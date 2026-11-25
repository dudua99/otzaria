READY
PR #5940 (issue #5905) — ענף feat/select-itur-target-5905
ראש: b5e295bf7 (ללא שינוי). dev שנבדק: c11d5f44f.
סקירת הפורט ל-BookOpenCoordinator.buildTab אחרי #5921: selectLine: hasExplicitLocation בתוצאה רגילה (_prepareRef) ובטאב הטקסט החלופי של בבלי (buildTextTab); selectLine: entry.targetSegment != null במפרש מהתפריט, דרך openBook שהעביר את הפרמטר ל-coordinator.openBook (שכבר תמך בו). buildTab ממיר ל-linkSelectedLine = initialIndex; ב-PDF מתעלמים ממנו; בטאב קיים TabsBloc מפעיל updateLinkSelection. תוצאת ספר-בלבד אינה בוחרת. פתיחת כמה תוצאות עוברת ב-_prepareRef ולכן נבחרת גם היא. הפורט נכון ושלם.
הוכחת כשל על dev: find_ref_open_result_test — dev: +30 -6 (כל 6 הכשלים הם בדיקות/הנחות #5905 החדשות); ענף: כולן עוברות.
בדיקות קשורות (96 קבצים: מייבאי find_ref_dialog / open_book / book_open_coordinator + test/find_ref), ענף+dev ממוזג מול dev: 1888 עברו/5 דולגו/1 נכשל מול 1882/5/1. הכשל זהה בשניהם וקיים מראש (plugin_bridge_adapter_test "כשל באמצע הכתיבה", תלוי סביבת root).
analyze: נקי. format: נקי. ui_lint: 0 חדשות (רק הזזת שורה בדוח).
קונפליקטים: merge-tree מול dev נקי; מול 43 ה-PR הפתוחים — אין קונפליקט חדש; מול #5939 נקי.
סיכונים/הערות: נושא ה-commit באנגלית ("fix(find-ref): ...") בניגוד לכלל נושאים בעברית — לא ניתן לתקן בלי שכתוב היסטוריה; כותרת ה-PR כבר בעברית. בחירת היעד פותחת את המפרשים עליו (לפי הנחיית palmoni5) — מומלצת בדיקה ויזואלית מקומית קצרה.
החלטות פתוחות: אין.
