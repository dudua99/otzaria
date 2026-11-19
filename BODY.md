## מה שבור
בלחיצה ימנית על סמל אוצריא בשורת המשימות (Windows) מופיעים קבצים שלא קשורים לתוכנה (למשל קובצי Word). לחיצה עליהם לא עושה כלום.

## סיבת השורש
חלונות הקבצים של Windows (Common Item Dialog) רושמים כל קובץ שנבחר בהם ברשימת "אחרונים" של המערכת (`SHAddToRecentDocs`). הרשימה הזו נשמרת תחת ה-AppUserModelID של התהליך, ומאז 53693cf45 (AppUserModelID אחיד לתהליך ולקיצורים) זה אותו מזהה של הסמל המוצמד. לכן קבצים שנבחרו בייבוא, בייצוא או בשמירה מופיעים ב-Jump List של אוצריא.

הדיאלוגים מגיעים מהמזלג `Otzaria/flutter_file_picker` (ענף `codex/integrated-fixes`, resolved-ref ‏f7154a0 ב-`pubspec.lock`). בקובץ `packages/file_picker_windows/lib/src/file_picker_windows.dart` שלושת הדיאלוגים (בחירת תיקייה בשורה 164, פתיחת קבצים בשורה 268, שמירה בשורה 341) מגדירים `FOS_FORCEFILESYSTEM | FOS_NOCHANGEDIR` וכו', אבל אף אחד מהם לא מגדיר `FOS_DONTADDTORECENT`. גם הענף העדכני (71fd72af) לא מגדיר אותו.

לחיצה על פריט כזה מפעילה את `otzaria.exe` עם נתיב הקובץ כפרמטר, והתוכנה לא מטפלת בפרמטר הזה. לכן לא קורה כלום.

## התיקון (במזלג, לא במאגר הזה)
מוסיפים `FOS_DONTADDTORECENT` לשלושת הדיאלוגים. הקבוע קיים ב-`win32` 6.4.0 (`enums.g.dart`: `FILEOPENDIALOGOPTIONS(33554432)`):

```diff
--- a/packages/file_picker_windows/lib/src/file_picker_windows.dart
+++ b/packages/file_picker_windows/lib/src/file_picker_windows.dart
@@ getDirectoryPath
             FOS_PICKFOLDERS |
             FOS_FORCEFILESYSTEM |
-            FOS_NOCHANGEDIR;
+            FOS_NOCHANGEDIR |
+            FOS_DONTADDTORECENT;
@@ pickFiles
             FOS_FILEMUSTEXIST |
-            FOS_NOCHANGEDIR;
+            FOS_NOCHANGEDIR |
+            FOS_DONTADDTORECENT;
@@ saveFile
-            fileDialog.getOptions() | FOS_FORCEFILESYSTEM | FOS_NOCHANGEDIR;
+            fileDialog.getOptions() |
+            FOS_FORCEFILESYSTEM |
+            FOS_NOCHANGEDIR |
+            FOS_DONTADDTORECENT;
```

אחרי המיזוג במזלג צריך לעדכן את `resolved-ref` ב-`pubspec.lock` של אוצריא (`flutter pub upgrade windows_file_picker`).

התיקון הזה מונע רק רשומות חדשות. רשומות שכבר נשמרו נשארות עד שהמשתמש מסיר אותן ("הסר מרשימה זו"). אם רוצים לנקות אותן אוטומטית, אפשר להוסיף ב-`windows/runner/jump_list_manager.cpp` קריאה חד-פעמית ל-`IApplicationDestinations::RemoveAllDestinations`. זו החלטה של המתחזק.

Refs #4036

## בדיקות
- לא היה אפשר לשחזר. הבאג תלוי ב-Shell של Windows, והסביבה כאן היא Linux. גם בדיקת Dart לא תעבור דרך דיאלוג ה-COM.
- וידאתי שהדגל חסר בקוד המזלג (f7154a0 וגם 71fd72af) ושהקבוע קיים בגרסת `win32` הנעולה (6.4.0).
- לא שיניתי קוד במאגר הזה, ולכן לא הרצתי בדיקות.

<!-- SUITE -->
