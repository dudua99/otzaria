READY
QA בלתי תלוי ל-perf3 (ענף perf/toc-row-rebuilds-perf3, ראש 3f623d64c1f077a44b05795ee30b990f2ca702b9, ללא קומיטים חדשים מה-QA).
כותרת ה-PR: ביצועים: מעבר הכותרת הפעילה בתוכן העניינים בונה מחדש רק את השורות שסימונן השתנה
Refs #1692 (לא Closes).
הוכחת כישלון: הבדיקה החדשה על upstream/dev (f358119ef) נכשלת: 35 בניות של NavTreeTile, כשהמותר הוא עד 2. בענף היא עוברת.
שורש: bd662b47f הוסיף את _activeTocIndex ל-buildWhen. זה אומת ב-git log -S.
סקירת הדיף: כל מקום שמשנה את _highlightedEntryIndex או את _expanded עובר דרך setState, וה-builder מסנכרן, או דרך ה-notifier (_moveHighlight). כל שינוי של selectedIndex, של השורה הגלויה הראשונה או של tableOfContents מגיע ל-listener או ל-builder. ה-notifier מתעדכן בזמן build, ומי שמאזין לו הם רק צאצאים של ה-BlocBuilder, ולכן זה מותר.
בדקתי במקרה קצה שחץ בחיפוש מסמן את השורה שכבר מסומנת: frame עדיין מתוזמן, ולכן הגלילה לשורה לא מתעכבת.
בדיקות test/text_book ו-test/perf (‏-j 1): בענף 3010 עברו, 1 דולג, 1 נכשל; ב-dev ‏3009 עברו, 1 דולג, 2 נכשלו. הכישלון המשותף הוא page_shape_super_commentary_wait_test, שנכשל לסירוגין גם לבד.
analyze ו-format נקיים. ui_lint: 92 שורות פלט, זהה ל-dev.
קונפליקטים: הענף מתמזג נקי עם upstream/dev f358119ef. אף PR פתוח (נסרקו כל ה-refs/pull מ-5300 והלאה) לא נוגע ב-toc_navigator_screen*. 20 PRs פתוחים ידועים נבדקו ב-merge-tree, ואין קונפליקט חדש.
החלטות פתוחות: אין.
בדיקה חזותית: אין שינוי חזותי. מומלצת בדיקה מקומית קצרה של גלילה עם החלונית פתוחה ושל חיצים באיתור כותרת.
