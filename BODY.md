## מה חסר

קישור "עם הדגשה" (?mark / pinpoint) משאיר את השורה מודגשת עד שלוחצים Esc, ואין שום רמז לכך. palmoni5 פתח מחדש את ה-issue כדי להוסיף "הידעת?" בפעם הראשונה שמופיע בתוכנה סימון כזה, כמו שאר טיפי ה"הידעת?".

## מה נעשה

- טיפ חי חדש `LiveTipId.linkHighlightHint`: כותרת "הידעת?", גוף: "הסימון הצהוב מגיע מהקישור שפתחת. לחיצה על Esc מסירה אותו." (עם תרגום ב-settings_en.arb).
- מסך הספר מדווח `linkHighlightShown` כשבמצב הספר מופיעה (או משתנה) `permanentHighlightLine`. הדיווח הוא רק במעבר, לא בכל emit.
- ענף ה-Esc שמנקה את ההדגשה מדווח `linkHighlightCleared`, והטיפ נסגר ונשמר כנפתר. מי שכבר יודע על Esc לא יראה אותו לעולם.
- הטיפ מוצג פעם אחת בלבד (נשמר ב-LiveTipStorage, כמו כל טיפ), ומכבד את כללי התצוגה הקיימים (לא בזמן סיור, טיפ אחד לסשן).
- הטיפ תלוי בהקשר, ולכן אינו ממתין לסף ההפעלות של טיפי "הידעת?" (כמו טיפ המפרשים). החריג מתועד ב-docs/guided_tour_developer_guide.md.
- `desktopOnly`: במובייל אין Esc ואין דרך מגע אחרת לנקות את ההדגשה, ולכן הטיפ לא מוצג שם.

ההדגשה עצמה, הצבע שלה (DD-17) והתנהגות Esc לא השתנו. לא נוספה דהייה אוטומטית (הרעיון המקורי של המדווח לא אומץ).

Closes #4919

## בדיקות

- `test/tour/tour_cubit_test.dart`, קבוצה "טיפ Esc להדגשת קישור (issue #4919)", ארבע בדיקות: מוצג כבר בהפעלה הראשונה; Esc לפני ההצגה פותר אותו לתמיד (גם ב-cubit חדש); Esc בזמן ההצגה סוגר ושומר; במובייל לא מוצג.
- `test/text_book/view/text_book_escape_clears_search_test.dart`: הדגשה מקישור במסך הספר מציגה את הטיפ (Windows), ו-Esc על הדגשת ?mark מסמן את הטיפ כנפתר.
- הבדיקות החדשות נכשלות על upstream/dev, ועוברות על הענף.
- test/tour + test/text_book + test/settings/l10n + test/tabs/reading_screen_tour_targets_test.dart, `flutter test -j 1`:
  - ענף: 3121 עברו, 1 דולגה, 1 נכשלה.
  - בסיס: 3116 עברו, 1 דולגה, 0 נכשלו.
  - הכישלון היחיד, `page_shape_super_commentary_wait_test.dart`, נכשל גם על upstream/dev כשמריצים אותו לבד (תלוי סדר הרצה). אין לו קשר לשינוי.
- `dart analyze` נקי בקבצים שנגעתי בהם; `dart format --set-exit-if-changed` נקי; ui_lint ללא הפרות חדשות.

<!-- SUITE -->
