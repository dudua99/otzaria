READY
QA עצמאי ל-#2306 (ענף feat/per-book-commentary-line-height-2306), head 4eec98f62878322ff9936e4714930fa24e72a99c.
כותרת PR: תיקון issue #2306 — גודל גופן המפרשים ומרווח השורות נשמרים לכל ספר בנפרד
Closes #2306 (ה-issue פתוח; אין PR פתוח אחר עליו).
קומיט QA שנדחף: 4eec98f62 — מרווח השורות של הספר לא הגיע לטקסט המפרשים עצמו (CommentaryContent נשאר על הכללי, רק הערות-אישיות קיבלו את של הספר) ולא לאומדן גובה פסקאות שלא נטענו (UnloadedParagraphPlaceholder) — תוקן בפרמטר lineHeight אופציונלי; בנוסף הפונקציה commentatorsFontSizeOf הוכנסה בין תיעוד savePerBookDisplaySettings לפונקציה — הועברה מעליו.
הוכחת כשל על dev: per_book_reading_metrics_test.dart לא מתקמפל על upstream/dev (אין lineHeight/commentatorsFontSize/book), עובר בענף (5).
סוויטה (settings, text_book, text_display, tabs/models, shortcuts, custom_title_bar, library/view, widgets/commentary, laaz wiring, pdf_book):
  ענף 6306/4/5 (עברו/נכשלו/דולגו); upstream/dev 6314/4/5 (dev התקדם). 3 כשלים קבועים זהים בשני הצדדים (root/סביבה); הרביעי בכל צד תזמוני ועבר בהרצה חוזרת.
analyze נקי, format נקי, ui_lint 0 חדשות. merge-tree מול dev נקי; אין התנגשות חדשה מול 66 PRs פתוחים.
החלטות פתוחות (כמו אצל המפיק):
- Y-PLONI ביקש "להחיל גם בצורת הדף": מרווח השורות חל בצורת הדף; גודל המפרשים בצורת הדף הוא הגדרה ייעודית נפרדת (#3244) ונשאר כללי — אולי ירצו שדה שלישי.
- מפרשי PDF נשארים על ההגדרה הכללית (אין ספר מקור טקסטואלי).
- כיבוי המתג לא מאפס ספרים פתוחים עד פתיחה מחדש.
מומלצת בדיקה מקומית: שני ספרים פתוחים, שינוי מרווח/גודל מפרשים באחד, פתיחה מחדש, איפוס, כיבוי המתג.
