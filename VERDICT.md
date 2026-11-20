READY
פיצ'ר (feature-default, milestone 0.9.99): פתיחת סימניה מדגישה לרגע את השורה שלה. palmoni5: "לא בטוח שכדאי". לא הוחלט, ולכן מומשה ברירת המחדל מ-notes: ההדגשה הרגעית הקיימת (HighlightLine), לא הסימון הצהוב הקבוע. זה כתוב ב-BODY.
ענף: feat/bookmark-open-highlight-4455, ראש 0e4a77bf467d9cbb25e5ef622349e43754491b15 (2 קומיטים מעל upstream/dev 1acfc0d78).
כותרת PR: תיקון issue #4455 — פתיחת סימניה מדגישה לרגע את השורה שלה. Closes #4455.
כשל על dev: בדיקת ה-bloc נכשלת (ההדגשה לא מגיעה), ושלוש האחרות לא מתקמפלות (highlightLineOnOpen).
בדיקות (bookmarks, tabs, text_book, history, personal_notes, utils/navigation; -j 1): ענף 4736 עברו / 5 דולגו / 1 נכשלה; בסיס 4733 / 5 / 0.
הכשל: page_shape_super_commentary_wait_test, תלוי תזמון. הוא עובר לבד בענף פעמיים, ונכשל זהה גם על הבסיס בהרצת test/text_book/view/page_shape/ (בשניהם 332 עברו, 1 נכשלה).
analyze/format נקיים; ui_lint: 0 הפרות חדשות.
התנגשויות: merge-tree מול 36 PRs פתוחים — אין התנגשות חדשה.
תופעת לוואי מכוונת: HighlightLine לספר שעוד נטען מוחל בסיום הטעינה, במקום להיזרק (משפר גם את פתיחת הערה אישית).
החלטות פתוחות: סוג ההדגשה (רגעית מול קבועה), ובקבוצה רק הספר הראשי מודגש. היסטוריה ו"ספרים אחרונים" לא השתנו.
חזותי: אין רכיב או צבע חדש (AppSurfaces.highlightedLineBackground הקיים), ולכן לא צולם. מומלץ להציץ ב-Windows: לפתוח סימניה לספר סגור ולספר פתוח.
