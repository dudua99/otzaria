READY

**ענף:** feat/switch-install-mode-all-users — ראש `f60034cd776a7a0fc34ea909df9a03c0c8f75240`
**כותרת PR:** התקנה: העברת אוצריא לכל המשתמשים או למשתמש הנוכחי בלבד · **Refs:** https://otzaria.org/forum/topic/3173 (בקשה מהפורום, אין issue)

**תיקוני QA (נדחפו כקומיטים חדשים):**
- `68b9e1d1c` — (1) באג לולאה באשף: `/SWITCHMODE` גבר על `/ALLUSERS`/`/CURRENTUSER` של שיגור-מחדש, כך שמשתמש שבחר באשף בהיקף ההפוך קיבל שוב את ההיקף המבוקש מסומן ונתקע בלולאת שיגור. עכשיו דגל השיגור-מחדש גובר (בשני הסקריפטים). (2) נתיב האינדקס שאינו שמור נגזר מהיקף ההתקנה (ProgramData מול AppData, ותיקיית index ריקה שהמתקין יוצר) — בלי קיבוע לפני ההחלפה האפליקציה הייתה בונה את אינדקס החיפוש מחדש. עכשיו `keyIndexPath` נשמר לפני שיגור המתקין (כמו ב-library_bloc).
- `f60034cd7` — עדכון בדיקה קיימת (ShouldSkipPage/InitializeWizard) לנוסח החדש.

**בדיקות** (`flutter test -j 1` על test/update, test/installer, test/settings, test/core/app_paths_test.dart, test/indexing/bloc/indexing_bloc_test.dart, test/release):
- ענף: 2139 עברו, 102 דולגו, 11 נכשלו · בסיס (upstream/dev 4fe1973a4): 2113 עברו, 102 דולגו, 11 נכשלו.
- 11 הכישלונות זהים בדיוק בשניהם (diff ריק) ותלויי סביבה: 2× app_paths "תיקיית מסדים מוגנת", personal_books_import copyFiles ו-orphan_library delete — ריצה כ-root (uid 0) מתעלמת מהרשאות קריאה-בלבד; 2× release_packaging — אין `pwsh`; 5× linux_split_update_packages — אין `zstd`.
- הבדיקות החדשות לא מתקמפלות על הבסיס (install_mode_switch.dart / install_mode_panel.dart / WindowsInstallScope חסרים).
- dart analyze + format נקיים; ui_lint: 0 חדשות; קטלוג ה-l10n נוצר מחדש בלי שינוי.

**קונפליקטים:** merge-tree מול upstream/dev נקי. מול 37 ה-PR הפתוחים — קונפליקט חדש רק עם #5691 (`settings_catalogs.g.dart`, שורות סמוכות; פתרון: יצירה מחדש עם `dart run tool/generate_settings_l10n.dart`). שאר הקונפליקטים קיימים כבר מול dev.

**נבדק סטטית (ISCC לא רץ בענן):** תחביר Pascal (begin/end, `;`, הכרזה לפני שימוש של SwitchModeTarget/SwitchModeParam בשני הסקריפטים). ה-uninstaller הישן רץ `/VERYSILENT /CROSSSCOPE=1` → `InitializeUninstall` יוצא לפני שאלת המחיקה (DeleteUserDataOnUninstall=False), אין `[UninstallDelete]`, ו-CurUninstallStepChanged מדלג על הסרה צולבת. ההגבהה רק דרך RelaunchSetupElevated הקיים ב-NextButtonClick. ההסרה רק ב-ssPostInstall — התקנה שנכשלה/בוטלה לא מסירה את הקודמת. ניידת: לא מוצעת באפליקציה, ו-RemoveOtherScopeInstalls יוצא ב-PortableMode.

**חובה בדיקה ידנית ב-Windows:** קומפילציית ISCC של שני הסקריפטים; שני הכיוונים (כולל ביטול UAC); בחירה הפוכה באשף אחרי ההחלפה (התיקון); רשומה אחת ב"אפליקציות ומאפיינים"; ספרים, הגדרות, הערות ואינדקס נשמרים בלי אינדוקס מחדש.

**החלטות פתוחות למתחזקים:**
1. ביטול UAC בהסרת ההתקנה לכל המשתמשים (כיוון ←משתמש נוכחי), או אישור UAC בחשבון מנהל אחר (כיוון ←כל המשתמשים: ה-HKCU הוא של המנהל) — שתי רשומות נשארות. זו התנהגות RemoveOtherScopeInstalls הקיימת (#886/#1020).
2. אחרי מעבר לכל המשתמשים הספרייה נשארת ב-AppData של המשתמש הנוכחי; משתמשים אחרים יקבלו ברירת מחדל ריקה ב-ProgramData.
3. ההחלפה מורידה את הריליס האחרון; בגרסת מפתחים חדשה ממנו היא נכשלת בהודעת "בדקו את החיבור לרשת" (מטעה, אבל בטוח).
4. קיצור בשולחן העבודה לא מועבר (המשימה כבויה כברירת מחדל ו-UsePreviousTasks=no).
