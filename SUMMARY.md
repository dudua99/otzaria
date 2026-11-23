# CR 2311 — PR Otzaria/otzaria#5644

בקשה: Bshlomecha (באישור הבעלים) — לשנות את התווית "הדיווחים ששלחתי" ל"הדיווחים שלי".

- ענף: feat/attached-db-placement-explain-2387-v2
- קומיט חדש: 6562ab71cb07ff1a49b3ad828e6ab8c0019b67bd (dudua99, push רגיל, בלי force)
- קבצים:
  - lib/settings/panels/reports_card.dart — תווית הכפתור + הערת התיעוד
  - lib/settings/l10n/settings_en.arb — המפתח; אנגלית "My Sent Reports" → "My Reports" (Title Case כמו "Sent Reports"/"Your Reports")
  - lib/settings/l10n/settings_catalogs.g.dart — נוצר מחדש ב-`dart run tool/generate_settings_l10n.dart`
  - test/settings/panels/reports_card_test.dart — הבדיקות מחפשות את התווית החדשה
- חיפוש בכל הריפו (כולל docs): אין מופעים נוספים של "הדיווחים ששלחתי".
- בדיקות (`flutter test -j 1`): test/settings/l10n, test/settings/dialogs, test/settings/panels/*report*, וכל קובצי הבדיקה בנתיב *report* (כולל app_report) — 1075 עברו, 1 דולג, 0 נכשלו.
- dart analyze: נקי. dart format: 0 שינויים. ui_lint: יציאה 0, אין הפרות חדשות.
- merge-tree מול upstream/dev: ללא קונפליקטים.
- לא פורסם דבר ב-GitHub; REPLY.md מוכן להדבקה.
