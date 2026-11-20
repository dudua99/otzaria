READY
QA בלתי תלוי ל-#5271. ענף: feat/plugin-incoming-links-5271, ראש e75342c25e5631a10db349d3661bf281fb4f1d6d. לא נדרשו קומיטים נוספים.
כותרת PR: תיקון issue #5271 — קישורים נכנסים לתוספים ב-library.getLinks
Closes #5271. ה-issue פתוח, ואין PR פתוח שמטפל בו.
נכשל על הבסיס: הבדיקות החדשות הועתקו ל-upstream/dev. ‏incoming_links_range_test לא מתקמפל, ו-7 מתוך 8 הבדיקות החדשות באדפטר נכשלות. ברירת המחדל עוברת, כצפוי. בענף עוברות כל 68 הבדיקות בשני הקבצים.
סקירת הקוד:
- מצב raw ב-_loadInverseSourceRows עדיין חסום ב-bookId ובחלון, וכולל link_coverage.
- העמודות של הצד האחר (index2, heRef, categoryId, rangeEnd עם panelSide 0) ממופות נכון ל-sourceLine, sourceHeRef, sourceCategoryId ו-sourceLineEnd.
- 'outgoing' זהה לקוד הקודם, ו-direction מאומת.
- plugin_api_catalog אינו מגדיר פרמטרים, ולכן אין בו מה לעדכן.
- קישור-טווח מופיע בכל שורה מכוסה בחלון, כמו בתצוגה. זה לא חדש.
בדיקות (98 נתיבים, -j 1):
- ענף: 5941 עברו, 23 דולגו, 5 נכשלו. בסיס: 5930 עברו, 23 דולגו, 5 נכשלו.
- 5 הכשלונות זהים בשני הצדדים: library_update ×4 (בגלל root) ו-fs mid-write.
analyze ו-format נקיים. ui_lint: אין הפרות חדשות.
קונפליקטים:
- upstream/dev התקדם ל-cf8ab6ece, ו-merge-tree נקי. לא נדרש מיזוג.
- אין קונפליקט חדש מול אף PR פתוח (נבדקו 43; חלקם מוזגו מאז).
החלטות פתוחות (מתועדות ב-BODY):
- getRawLinks לא השתנה.
- קישורי-משתמש ו-external_link לא נכללים בנכנסים.
- ב-'both' קישור הפניה עשוי להופיע פעמיים.
חזותי: אין. מומלץ לנסות פעם אחת על seforim.db אמיתי: getLinks עם direction:'incoming' ו-connectionTypes:['MESORAT_HASHAS'].
