READY
- ענף `fix/followup-5680`, ראש 19be44150 (ללא שינוי ב-QA). כותרת: "תיקון המשך ל-#5680 — סינון לפי ספר בקישורים נכנסים מתבצע בשאילתה, עם התקרה". ‏Refs #5271.
- הממצא קיים ב-dev ‏057aa1ba7 (`limit: null` כשיש targetTitles/targetTitlePrefixes).
- על dev: הבדיקה ב-bridge נכשלת (limit null), ו-incoming_links_range_test לא מתקמפל (פרמטר חדש). בענף: 73/73 עוברות.
- סקירה: ה-SQL (`sb.title IN (…)` / `substr(sb.title,1,length(?)) = ?`, ב-OR) שקול ל-`_titleAllowed` (בכיוון הנכנס `pathIsTitle`, כלומר path2 = sb.title); הסינון בגשר נשאר, ולכן הפלט לתוסף זהה. הסדר של הפרמטרים תואם את ה-placeholders; `IN ()` ריק מחזיר ריק כמו בגשר. קורא יחיד ל-`getIncomingLinksInRange`; מפתח המטמון כולל את הארגומנטים החדשים.
- test/plugins + test/data_providers על dev+ענף: ‏4763 עברו, 19 דולגו, 1 נכשלה; על dev: ‏4761/19/1. אותו כשל בשני הצדדים (plugin_bridge_adapter_test "כשל באמצע הכתיבה אינו פוגע בקובץ הקיים" — ריצה כ-root).
- analyze/format נקיים; ui_lint ‏80 = 80. merge-tree נקי; #5740, ‏#5821 נקיים; ‏#3442 מתנגש כבר מול dev.
- BODY: תוקן (#5732 כבר לא פתוח → #5821; ספירות) — ראו BODY_5680.md.
