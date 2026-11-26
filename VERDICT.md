READY
הסיבה אומתה במקור המנוע (Flutter 3.47.7, flutter_key_map.g.cc: scanCodeToLogicalMap_): מקשי לוח הספרות מדווחים numpadN גם כש-NumLock כבוי, ורק היעדר התו מבדיל.
ענף: fix/numpad-navigation-keys-5212 — HEAD 3986eded646609cd7f21a35ee1d14a49207df4e2 (2 קומיטים מעל upstream/dev 4fe1973a4)
כותרת PR: תיקון issue #5212 — מקשי הניווט בלוח הספרות (NumLock כבוי) בקורא
תיקון: navigationKeyOf (קובץ חדש lib/shortcuts/numpad_navigation.dart) + שימוש בו ב-ProgressiveScroll (חצים/PageUp/PageDown) וב-Home/End של text_book_screen.
לא רגרסיה: הטיפול במקשים נכתב מלכתחילה על המקש הראשי בלבד (57d7ccf2b, 0b07a7b88).
בדיקות חדשות נכשלות על dev ועוברות בענף (reader_page_keys_test, text_book_screen_actions_test).
סוויטה test/shortcuts + test/widgets + test/text_book/view: ענף 4231/1 דילוג/1 כישלון; בסיס 4227/1/1 — אותו כישלון קיים מראש (page_shape_super_commentary_wait_test).
analyze/format נקיים; ui_lint — אין הפרות חדשות; merge-tree מול 41 PR פתוחים — אין קונפליקט חדש.
החלטות: Ctrl+מקש בלוח הספרות נשאר ספרה (מעבר ללשונית) גם בלי NumLock, כי ל-Ctrl+ספרה אין תו גם עם NumLock ואי אפשר להבדיל. תצוגת צורת הדף וקורא ה-PDF לא כלולים (נכתב ב-BODY).
בדיקה ויזואלית: אין שינוי חזותי. מומלץ אימות ידני ב-Windows עם מקלדת עם לוח ספרות (NumLock כבוי: 2/8/3/9/1/7 בקורא; NumLock דולק: אין גלילה).
