## מה היה חסר

תוספים יכולים להוסיף פריטים לתפריט ההקשר בקורא (`reader-selection`, `reader-book`, `reader-pdf` ועוד), אבל לא בספרייה. אין דרך להציע פעולה על ספר ("הוסף לתוכנית הלימוד", "דווח על טעות בספר") בלי לפתוח אותו קודם. ה-issue מציע הקשר חדש, `library-book`.

## הסיבה

זו לא רגרסיה. תפריט ההקשר של ספר בספרייה (`_buildBookContextMenuRegion` ב-`lib/library/view/library_browser.dart`) כולל רק פריטים מובנים: "הוסף לבחירה", ובמסכת בבלי גם בחירת פורמט פתיחה. בנוסף, `ContextMenuRegistry` דוחה כל הקשר שאינו של הקורא (`error.unsupported_context`).

## השינוי

- `ContextMenuRegistry` מקבל את ההקשר `library-book`. הוא לא נכלל בברירת המחדל, כך שפריטים קיימים בלי `contexts` לא מופיעים בספרייה.
- בתפריט ההקשר של ספר בספרייה נוספים בסוף פריטי התוספים של `library-book`, דרך `buildPluginContextMenuSection` הקיים. זה התפריט של שורה בעץ, של כרטיס ברשת ושל תוצאת איתור. בלחיצה ימנית, ובמגע בלחיצה ארוכה.
- הלחיצה עוברת באותו מסלול של שאר פריטי התפריט: אירוע לתוסף, `openPlugin` או פעולה דקלרטיבית (`action`) בלי להעיר את מנוע התוסף. ב-`selection` נמסרים זהות הספר (`id`, `bookId`, `bookUid`, `type`, `source`, ו-`external` כשיש), `bookTitle` ו-`categoryPath` בצורה של `library.getTree` (למשל `/הלכה`). `text`/`selectedText` ריקים, ו-`currentRef`/`currentIndex` הם `null`.
- תיעוד: `docs/plugin-sdk/API_REFERENCE.md` (סעיף חדש תחת `reader.addContextMenuItem`) ו-`otzaria_plugin.d.ts` (`ContextMenuContext`, `ReaderSelection.categoryPath`).

### ברירות שבחרתי (ההחלטות ב-issue עוד לא הוכרעו)

1. **איפה:** בתפריט ההקשר בלבד, כקבוצה נפרדת אחרי הפריטים המובנים, שנשארים כמו שהם. תפריט ⋮ (`BookActionsMenuButton`) לא השתנה: הוא תפריט מסוג אחר (`AppPopupMenuButton`), והוא נעלם כשאין לספר פעולה מובנית. אם רוצים גם אותו, אפשר להוסיף בהמשך.
2. **אילו פריטים:** ספרים בלבד. קטגוריה היא הקשר נפרד, עם payload אחר.
3. **הרשאה:** `reader.context_menu` הקיימת. אין הרשאה חדשה.
4. **ספרים מספקים חיצוניים** (`ExternalLibraryBook`): לא מקבלים פריטים בגרסה הזו.
5. **עומס:** המגבלה הקיימת של שני פריטים עליונים לתוסף חלה גם כאן. תוספים שונים מופרדים בקו, כמו בקורא. קיבוץ תחת "תוספים" הוא כלל רוחבי לכל התפריטים, ונשאר ל-#3160.
6. **סינון לפי ספר:** `bookTypes`/`bookSources` הקיימים חלים לפי הספר שנלחץ.

Closes #4466

## בדיקות

- `test/library/view/library_book_plugin_menu_test.dart`, קבוצה 'plugin items in the library book menu (issue #4466)'. הבדיקות רצות דרך `LibraryBrowser` האמיתי (רשימת תוצאות האיתור) ובונות את התפריט של שורת הספר:
  - פריט `library-book` מופיע בסוף התפריט אחרי קו מפריד. פריט של הקורא (בלי `contexts`) לא מופיע.
  - לחיצה על ספר PDF מוסרת את `id`, `type: 'pdf'`, `source`, `bookId`, `bookUid` ו-`categoryPath: '/הלכה'`, ו-`selectedText` ריק.
  - `bookTypes: ['pdf']` מציג את הפריט על ספר PDF ולא על ספר טקסט.
  - בלי פריטי `library-book` התפריט לא משתנה.
- `test/plugins/services/context_menu_registry_test.dart`: ‏`library-book` מתקבל רק כשמבקשים אותו, ולא נכנס לברירת המחדל. הקשר לא מוכר עדיין נדחה.
- על upstream/dev (‏eae19d093) כל 5 הבדיקות נכשלות: הרישום עם `library-book` נדחה ב-`error.unsupported_context`.
- `flutter test -j 1` על 42 קובצי בדיקה שמייבאים את `library_browser`, את `context_menu_registry` או את `plugin_context_menu_entries` (בלי קובץ העזר `plugin_menu_click_recorder.dart`, שאינו בדיקה):
  - ענף: 996 עברו, 1 נכשלה, 2 דולגו.
  - בסיס (eae19d093): 991 עברו, 1 נכשלה, 2 דולגו. ההפרש הוא 5 הבדיקות החדשות.
  - הכישלון זהה בשני הצדדים ולא קשור לשינוי: `plugin_bridge_adapter_test` "כשל באמצע הכתיבה אינו פוגע בקובץ הקיים", שנכשל כשמריצים כ-root.
- `dart analyze` ו-`dart format --set-exit-if-changed` נקיים על הקבצים שנגעתי בהם. `dart tool/ui_lint_cli.dart`: טבלה זהה לבסיס, 0 הפרות חדשות.
- מיזוג: נקי מול upstream/dev העדכני (090d38534). מול ה-PR-ים הפתוחים אין קונפליקט חדש. #5624 נוגע ב-`library_browser.dart`, ו-#5628/#5551 ב-`API_REFERENCE.md`. כולם מתמזגים נקי עם השינוי.
- שינוי חזותי: נוסף קטע תוספים בסוף תפריט ההקשר של ספר, רק כשיש תוסף עם `library-book`. צילומי לפני/אחרי (בהיר וכהה) בענף `qa-shots/4466`.

<!-- SUITE -->
