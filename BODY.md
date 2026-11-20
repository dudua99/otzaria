## מה היה חסר
`library.getLinks` מחזיר רק את הקישורים **היוצאים** מחלון שורות. תוסף שרוצה לעבור על קישור בשני הכיוונים (למשל תוסף מילון שמפיץ תרגום לאורך מסורת הש"ס) לא יכול למצוא קישור שנשמר רק בצד השני. אין דרך נתמכת לגלות אותו בלי לסרוק את כל הספרים.

## הסיבה
ה-SDK חשף עד היום רק את מה שהממשק מציג. בתצוגה יש היפוך (`_loadInverseSourceRows`, מ-bbb3a46b1, וסוגי ההפניה מ-6b048c6ef), אבל זו לוגיקת תצוגה:
- רק סוגים תלויי-טקסט. סוגי הפניה (כמו `MESORAT_HASHAS`) נכללים רק במסד שיש בו `link_suppressed_side`.
- הסוג נכתב מחדש ל-`SOURCE`.
- צד מדוכא וקישורים בתוך אותו ספר מסוננים.
- לרשומה אין סימן כיוון.
לכן תוסף לא יכול לבנות על ההיפוך הזה.

## השינוי
- `library.getLinks` מקבל `direction`:
  - `'outgoing'` — ברירת המחדל. התשובה זהה לזו של היום, בית בבית.
  - `'incoming'` — הקישורים שספרים אחרים שומרים **אל** שורות החלון, כפי שנשמרו.
  - `'both'` — היוצאים ואחריהם הנכנסים, ובכל רשומה `direction`.
  - ערך אחר: `error.invalid_params`.
- רשומה נכנסת: `sourceTitle`, `sourceLine`, `sourceLineEnd`, `sourceHeRef`, `sourceSource`, `sourceCategoryId` (זהות הספר השומר, כך שספרים שווי-שם ממסדים שונים נבדלים), `targetLine` (השורה בחלון), `connectionType` המקורי, `isCommentary`.
- אותן מגבלות: חלון של 200 שורות, 2,000 רשומות ו-`truncated` על התשובה כולה. `connectionTypes`, `targetTitles` ו-`targetTitlePrefixes` חלים בנכנסים על הספר האחר. `includeAnchors` אינו חל על הנכנסים.
- SQL: מצב `raw` ב-`_loadInverseSourceRows`, באותה שאילתה חסומה (bookId וחלון, כולל `link_coverage`), בלי שכתוב הסוג ובלי סינוני התצוגה. הוא עובר דרך `getLinksForBookRange(incoming: true)` ונקרא מהמסד של הספר עצמו (רשמי או מצורף).
- `TextBookRepository.getIncomingLinksInRange` — מתודה חדשה. `getBookLinksInRange` והתצוגה לא השתנו.
- תיעוד: `API_REFERENCE.md` (סעיף `library.getLinks` ודוגמה), `otzaria_plugin.d.ts` (`IncomingBookLink`), `README.md`.

החלטות שלא נקבעו ב-issue (אפשר לשנות):
- `library.getRawLinks` לא השתנה. ה-issue ביקש את `getLinks`, ופורמט `links.json` נבנה סביב צד המקור.
- קישורי-משתמש (CSV) וקישורים בין מסדים (`external_link`) אינם נכללים בנכנסים, רק המסד של הספר.
- ב-`'both'` קישור הפניה שהממשק כבר מציג גם בצד השני עשוי להופיע פעמיים: פעם כיוצא (כפי שמוצג) ופעם כנכנס (כפי שנשמר). זה מתועד.

Closes #5271

PRs פתוחים שנוגעים באותם קבצים: #5628 ו-#5396 (`plugin_bridge_adapter.dart`), #5551 (`API_REFERENCE.md`), #3442 (`text_book_repository.dart`). `git merge-tree` מול כל אחד: אין קונפליקט חדש. ל-#3442 יש קונפליקט גם מול dev, בלי קשר לשינוי הזה.

## בדיקות
- `test/data_providers/incoming_links_range_test.dart` (חדש, מסד SQLite אמיתי בלי `link_suppressed_side`): הנכנסים מחזירים מסורת הש"ס, מפרש בסוג `COMMENTARY` המקורי (ולא `SOURCE`) וקישור בתוך הספר. החלון חל על צד היעד. ברירת המחדל לא השתנתה (מסורת הש"ס אינה בה, המפרש עדיין `SOURCE`).
- `test/plugins/bridge/plugin_bridge_links_api_test.dart`, קבוצה חדשה `library.getLinks direction (issue #5271)`: צורת הרשומה הנכנסת; ברירת מחדל ו-`'outgoing'` זהות ובלי קריאה לנכנסים; `'both'` לפי הסדר; תחיליות על הספר האחר; מכסה משותפת; שלושה ערכים לא חוקיים.
  - על dev: הקובץ החדש לא מתקמפל (אין `incoming`), ו-7 מתוך 8 הבדיקות החדשות בקבוצה נכשלות (ברירת המחדל עוברת, כצפוי). בענף: כולן עוברות.
- `flutter test -j 1` על test/plugins, ‏test/data_providers וכל הבדיקות שמייבאות את `plugin_bridge_adapter.dart`, ‏`text_book_repository.dart` או `database_library_provider.dart` (97 נתיבים):
  - בענף: 5928 עברו, 6 נכשלו, 23 דולגו.
  - על הבסיס (dev + הבדיקות החדשות): 5918 עברו, 14 נכשלו, 23 דולגו.
  - 6 הכשלונות של הענף נכשלים בדיוק כך גם על הבסיס, בלי קשר לשינוי: ארבע בדיקות "תיקייה חסומה / SQLITE_READONLY" ב-library_update_repository_test (הרצה כ-root), "כשל באמצע הכתיבה" ב-plugin_bridge_adapter_test ו-page_shape_super_commentary_wait_test. 8 הכשלונות הנוספים בבסיס הם הבדיקות החדשות בלבד.
- `dart analyze` ו-`dart format --set-exit-if-changed` על הקבצים שנגעו — נקי. `dart tool/ui_lint_cli.dart` — זהה לבסיס.
- אין שינוי חזותי.

<!-- SUITE -->
