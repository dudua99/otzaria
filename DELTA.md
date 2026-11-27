# DELTA v1 → v2a (names/uniform-titles-3209 @1f5dd43b)

## Per-table row counts in patch.db (non-zero only; every other upsert_/delete_ table = 0)

| table | upsert | delete |
|---|---|---|
| `book` | 150 | 0 |
| `book_acronym` | 6 | 3 |
| `book_topic` | 116 | 116 |
| `category` | 30 | 29 |
| `category_closure` | 100 | 100 |
| `line` | 16901 | 0 |
| `line_dh` | 0 | 1163 |
| `link` | 0 | 1 |
| `schema_meta` | 1 | 0 |
| `topic` | 22 | 21 |

Total rows: 18759.

### `delete_book_acronym` (3 rows)

- delete {"bookId": 5071, "term": "חידושי הרא\"ה על כתובות"}
- delete {"bookId": 4975, "term": "חידושי הר\"י מיגאש על בבא בתרא"}
- delete {"bookId": 4976, "term": "חידושי הר\"י מיגאש על שבועות"}

### `delete_book_topic` (116 rows, first 30 shown)

- delete {"bookId": 6225, "topicId": 23}
- delete {"bookId": 6226, "topicId": 23}
- delete {"bookId": 6310, "topicId": 36}
- delete {"bookId": 6311, "topicId": 36}
- delete {"bookId": 6312, "topicId": 36}
- delete {"bookId": 6313, "topicId": 37}
- delete {"bookId": 6314, "topicId": 37}
- delete {"bookId": 6385, "topicId": 54}
- delete {"bookId": 6386, "topicId": 54}
- delete {"bookId": 6573, "topicId": 71}
- delete {"bookId": 6574, "topicId": 71}
- delete {"bookId": 6575, "topicId": 71}
- delete {"bookId": 6622, "topicId": 79}
- delete {"bookId": 6623, "topicId": 79}
- delete {"bookId": 6624, "topicId": 79}
- delete {"bookId": 7064, "topicId": 147}
- delete {"bookId": 7065, "topicId": 147}
- delete {"bookId": 7066, "topicId": 147}
- delete {"bookId": 7070, "topicId": 148}
- delete {"bookId": 7071, "topicId": 148}
- delete {"bookId": 7072, "topicId": 148}
- delete {"bookId": 7073, "topicId": 148}
- delete {"bookId": 7074, "topicId": 149}
- delete {"bookId": 7075, "topicId": 149}
- delete {"bookId": 7076, "topicId": 149}
- delete {"bookId": 7077, "topicId": 149}
- delete {"bookId": 7223, "topicId": 166}
- delete {"bookId": 7224, "topicId": 166}
- delete {"bookId": 7237, "topicId": 167}
- delete {"bookId": 7238, "topicId": 167}

### `delete_category` (29 rows)

- delete {"id": 1472, "parentId": 64, "title": "שות מהרשם", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי שלום מרדכי [המהרש\"ם] ב\"ר משה הכהן שבדרון.", "heDesc": "תשובות בענייני הלכה מרבי שלום מרדכי [המהרש\"ם] ב\"ר משה הכהן שבדרון."}
- delete {"id": 1476, "parentId": 1160, "title": "רמחל", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבנו הרמח\"ל, בעניינים שונים, הנהגת ה', דרכי הלימוד, ועוד.", "heDesc": "חיבורי רבנו הרמח\"ל, בעניינים שונים, הנהגת ה', דרכי הלימוד, ועוד."}
- delete {"id": 1503, "parentId": 124, "title": "מהרם שיק תריג מצות", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1513, "parentId": 80, "title": "חידושי הרימ", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1514, "parentId": 80, "title": "חידושי מהראך", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1525, "parentId": 74, "title": "ספר ימי מוהרנת", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1546, "parentId": 764, "title": "ראש", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבנו אשר ב\"ר יחיאל על המשנה.", "heDesc": "חיבורי רבנו אשר ב\"ר יחיאל על המשנה."}
- delete {"id": 1597, "parentId": 64, "title": "מביט", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי משה מטראני [המבי\"ט].", "heDesc": "תשובות בענייני הלכה מרבי משה מטראני [המבי\"ט]."}
- delete {"id": 1598, "parentId": 64, "title": "מהרם שיק", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי משה שיק.", "heDesc": "תשובות בענייני הלכה מרבי משה שיק."}
- delete {"id": 1599, "parentId": 64, "title": "מהרש", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי שמואל אנגל.", "heDesc": "תשובות בענייני הלכה מרבי שמואל אנגל."}
- delete {"id": 1614, "parentId": 64, "title": "שות עטרת חכמים", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1615, "parentId": 64, "title": "שות שבט סופר", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1616, "parentId": 64, "title": "שות תעלומות לב", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי אליהו בכור חזן.", "heDesc": "תשובות בענייני הלכה מרבי אליהו בכור חזן."}
- delete {"id": 1619, "parentId": 64, "title": "תשובות הראם", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי אלכסנדר סנדר מרגליות.", "heDesc": "תשובות בענייני הלכה מרבי אלכסנדר סנדר מרגליות."}
- delete {"id": 1620, "parentId": 64, "title": "תשורת שי", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1652, "parentId": 871, "title": "חידושי הלכות מהרם חריף", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1653, "parentId": 871, "title": "חידושי המהריט", "level": 2, "orderIndex": 999, "heShortDesc": "חידושי רבי יוסף מטראני [המהרי\"ט] על הש\"ס.", "heDesc": "חידושי רבי יוסף מטראני [המהרי\"ט] על הש\"ס."}
- delete {"id": 1665, "parentId": 871, "title": "ליקוטי מהריל", "level": 2, "orderIndex": 999, "heShortDesc": "ליקוטי רבי י־הודה ליב מזקילקוב על הש\"ס.", "heDesc": "ליקוטי רבי י־הודה ליב מזקילקוב על הש\"ס."}
- delete {"id": 1666, "parentId": 1665, "title": "סדר נשים", "level": 3, "orderIndex": 999, "heShortDesc": "ליקוטי מהריל על מסכתות סדר נשים.", "heDesc": "ליקוטי מהריל על מסכתות סדר נשים."}
- delete {"id": 1684, "parentId": 1683, "title": "גליוני השס", "level": 3, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות הש\"ס.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות הש\"ס."}
- delete {"id": 1685, "parentId": 1684, "title": "מועד", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר מועד.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר מועד."}
- delete {"id": 1686, "parentId": 1684, "title": "נזיקין", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נזיקין.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נזיקין."}
- delete {"id": 1687, "parentId": 1684, "title": "נשים", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נשים.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נשים."}
- delete {"id": 1720, "parentId": 990, "title": "ריבן", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1724, "parentId": 784, "title": "גליוני השס", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ב\"ר יהודה ענגיל על התלמוד הירושלמי.", "heDesc": "חיבורי רבי יוסף ב\"ר יהודה ענגיל על התלמוד הירושלמי."}
- delete {"id": 1725, "parentId": 1724, "title": "מועד", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1726, "parentId": 1724, "title": "נזיקין", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1727, "parentId": 1724, "title": "נשים", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- delete {"id": 1734, "parentId": 622, "title": "פירוש הגרא", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}

### `delete_category_closure` (100 rows, first 30 shown)

- delete {"ancestorId": 1684, "descendantId": 1684}
- delete {"ancestorId": 1683, "descendantId": 1684}
- delete {"ancestorId": 871, "descendantId": 1684}
- delete {"ancestorId": 12, "descendantId": 1684}
- delete {"ancestorId": 1724, "descendantId": 1724}
- delete {"ancestorId": 784, "descendantId": 1724}
- delete {"ancestorId": 19, "descendantId": 1724}
- delete {"ancestorId": 1652, "descendantId": 1652}
- delete {"ancestorId": 871, "descendantId": 1652}
- delete {"ancestorId": 12, "descendantId": 1652}
- delete {"ancestorId": 1653, "descendantId": 1653}
- delete {"ancestorId": 871, "descendantId": 1653}
- delete {"ancestorId": 12, "descendantId": 1653}
- delete {"ancestorId": 1513, "descendantId": 1513}
- delete {"ancestorId": 80, "descendantId": 1513}
- delete {"ancestorId": 61, "descendantId": 1513}
- delete {"ancestorId": 43, "descendantId": 1513}
- delete {"ancestorId": 1514, "descendantId": 1514}
- delete {"ancestorId": 80, "descendantId": 1514}
- delete {"ancestorId": 61, "descendantId": 1514}
- delete {"ancestorId": 43, "descendantId": 1514}
- delete {"ancestorId": 1665, "descendantId": 1665}
- delete {"ancestorId": 871, "descendantId": 1665}
- delete {"ancestorId": 12, "descendantId": 1665}
- delete {"ancestorId": 1597, "descendantId": 1597}
- delete {"ancestorId": 64, "descendantId": 1597}
- delete {"ancestorId": 62, "descendantId": 1597}
- delete {"ancestorId": 1598, "descendantId": 1598}
- delete {"ancestorId": 64, "descendantId": 1598}
- delete {"ancestorId": 62, "descendantId": 1598}

### `delete_line_dh` (1163 rows, first 30 shown)

- delete {"bookId": 6305, "dhText": "אאומנים", "lineIndex": 1480, "dhDisplay": "אאומנים"}
- delete {"bookId": 6305, "dhText": "אאכ יש בו כגריס ועוד", "lineIndex": 2311, "dhDisplay": "אא\"כ יש בו כגריס ועוד"}
- delete {"bookId": 6305, "dhText": "אבל", "lineIndex": 1283, "dhDisplay": "אבל"}
- delete {"bookId": 6305, "dhText": "אבל אם אינו", "lineIndex": 1551, "dhDisplay": "אבל אם אינו"}
- delete {"bookId": 6305, "dhText": "אבל ברבית דרבנן", "lineIndex": 1317, "dhDisplay": "אבל ברבית דרבנן"}
- delete {"bookId": 6305, "dhText": "אבל חוששת", "lineIndex": 2006, "dhDisplay": "אבל חוששת"}
- delete {"bookId": 6305, "dhText": "או בציר", "lineIndex": 414, "dhDisplay": "או בציר"}
- delete {"bookId": 6305, "dhText": "או מל יום לל יום", "lineIndex": 2065, "dhDisplay": "או מל' יום לל' יום"}
- delete {"bookId": 6305, "dhText": "או שתגלה מעט מהשלחן ותתן קערה שלה עליו", "lineIndex": 2442, "dhDisplay": "או שתגלה מעט מהשלחן ותתן קערה שלה עליו"}
- delete {"bookId": 6305, "dhText": "או שתים", "lineIndex": 2148, "dhDisplay": "או שתים"}
- delete {"bookId": 6305, "dhText": "אווז", "lineIndex": 846, "dhDisplay": "אווז"}
- delete {"bookId": 6305, "dhText": "אוסרים", "lineIndex": 110, "dhDisplay": "אוסרים"}
- delete {"bookId": 6305, "dhText": "אוסרין", "lineIndex": 642, "dhDisplay": "אוסרין"}
- delete {"bookId": 6305, "dhText": "אוסרת", "lineIndex": 1004, "dhDisplay": "אוסרת"}
- delete {"bookId": 6305, "dhText": "אותו יום כולו", "lineIndex": 1944, "dhDisplay": "אותו יום כולו"}
- delete {"bookId": 6305, "dhText": "אותן מלוה", "lineIndex": 1895, "dhDisplay": "אותן מלוה"}
- delete {"bookId": 6305, "dhText": "אחד", "lineIndex": 447, "dhDisplay": "אחד"}
- delete {"bookId": 6305, "dhText": "אחד", "lineIndex": 1184, "dhDisplay": "אחד"}
- delete {"bookId": 6305, "dhText": "אחד", "lineIndex": 2477, "dhDisplay": "אחד"}
- delete {"bookId": 6305, "dhText": "אחד", "lineIndex": 2487, "dhDisplay": "אחד"}
- delete {"bookId": 6305, "dhText": "אחר", "lineIndex": 2429, "dhDisplay": "אחר"}
- delete {"bookId": 6305, "dhText": "אחריות", "lineIndex": 1713, "dhDisplay": "אחריות"}
- delete {"bookId": 6305, "dhText": "אחריות על שאר נכסיו", "lineIndex": 1670, "dhDisplay": "אחריות על שאר נכסיו"}
- delete {"bookId": 6305, "dhText": "אחת", "lineIndex": 2479, "dhDisplay": "אחת"}
- delete {"bookId": 6305, "dhText": "אחת או ב", "lineIndex": 1799, "dhDisplay": "אחת או ב'"}
- delete {"bookId": 6305, "dhText": "אימת שירצה", "lineIndex": 1429, "dhDisplay": "אימת שירצה"}
- delete {"bookId": 6305, "dhText": "אין המלוה צריך לחוש", "lineIndex": 1587, "dhDisplay": "אין המלוה צריך לחוש"}
- delete {"bookId": 6305, "dhText": "אין לו", "lineIndex": 1733, "dhDisplay": "אין לו"}
- delete {"bookId": 6305, "dhText": "אין לסמוך גכ אדבריו אבל מסלפת מהני", "lineIndex": 79, "dhDisplay": "אין לסמוך ג\"כ אדבריו אבל מסלפ\"ת מהני"}
- delete {"bookId": 6305, "dhText": "אין מתירין", "lineIndex": 2075, "dhDisplay": "אין מתירין"}

### `delete_link` (1 rows)

- delete {"id": 3928314, "sourceBookId": 5061, "targetBookId": 7816, "sourceLineId": 2797152, "targetLineId": 6289774, "targetLineIndex": 14, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}

### `delete_topic` (21 rows)

- delete {"id": 23, "name": "מהרם שיק תריג מצות"}
- delete {"id": 36, "name": "חידושי הרימ"}
- delete {"id": 37, "name": "חידושי מהראך"}
- delete {"id": 54, "name": "ספר ימי מוהרנת"}
- delete {"id": 79, "name": "ראש"}
- delete {"id": 147, "name": "מביט"}
- delete {"id": 148, "name": "מהרם שיק"}
- delete {"id": 149, "name": "מהרש"}
- delete {"id": 166, "name": "שות מהרשם"}
- delete {"id": 167, "name": "שות עטרת חכמים"}
- delete {"id": 168, "name": "שות שבט סופר"}
- delete {"id": 169, "name": "שות תעלומות לב"}
- delete {"id": 172, "name": "תשובות הראם"}
- delete {"id": 173, "name": "תשורת שי"}
- delete {"id": 201, "name": "חידושי הלכות מהרם חריף"}
- delete {"id": 202, "name": "חידושי המהריט"}
- delete {"id": 210, "name": "ליקוטי מהריל"}
- delete {"id": 224, "name": "גליוני השס"}
- delete {"id": 245, "name": "חדושי הראה"}
- delete {"id": 252, "name": "ריבן"}
- delete {"id": 271, "name": "פירוש הגרא"}

### `upsert_book` (150 rows, first 30 shown)

- update {"id": 420}: **categoryId**: 1472 → 1745
- update {"id": 437}: **categoryId**: 1472 → 1745
- update {"id": 441}: **categoryId**: 1472 → 1745
- update {"id": 4447}: **title**: "מהרש\"א - חדושי הלכות על ביצה" → "מהרש\"א - חידושי הלכות על ביצה"
- update {"id": 4448}: **title**: "מהרש\"א - חדושי הלכות על פסחים" → "מהרש\"א - חידושי הלכות על פסחים"
- update {"id": 4450}: **title**: "מהרש\"א - חדושי הלכות על ראש השנה" → "מהרש\"א - חידושי הלכות על ראש השנה"
- update {"id": 4454}: **title**: "מהרש\"א - חדושי הלכות על סוכה" → "מהרש\"א - חידושי הלכות על סוכה"
- update {"id": 4456}: **title**: "מהרש\"א - חדושי הלכות על חולין" → "מהרש\"א - חידושי הלכות על חולין"
- update {"id": 4457}: **title**: "מהרש\"א - חדושי הלכות על בכורות" → "מהרש\"א - חידושי הלכות על בכורות"
- update {"id": 4458}: **title**: "מהרש\"א - חדושי הלכות על מנחות" → "מהרש\"א - חידושי הלכות על מנחות"
- update {"id": 4459}: **title**: "מהרש\"א - חדושי הלכות על קידושין" → "מהרש\"א - חידושי הלכות על קידושין"
- update {"id": 4460}: **title**: "מהרש\"א - חדושי הלכות על יבמות" → "מהרש\"א - חידושי הלכות על יבמות"
- update {"id": 4461}: **title**: "מהרש\"א - חדושי הלכות על נדרים" → "מהרש\"א - חידושי הלכות על נדרים"
- update {"id": 4464}: **title**: "מהרש\"א - חדושי הלכות על גיטין" → "מהרש\"א - חידושי הלכות על גיטין"
- update {"id": 4465}: **title**: "מהרש\"א - חדושי הלכות על סוטה" → "מהרש\"א - חידושי הלכות על סוטה"
- update {"id": 4467}: **title**: "מהרש\"א - חדושי הלכות על שבועות" → "מהרש\"א - חידושי הלכות על שבועות"
- update {"id": 4468}: **title**: "מהרש\"א - חדושי הלכות על הוריות" → "מהרש\"א - חידושי הלכות על הוריות"
- update {"id": 4469}: **title**: "מהרש\"א - חדושי הלכות על עבודה זרה" → "מהרש\"א - חידושי הלכות על עבודה זרה"
- update {"id": 4470}: **title**: "מהרש\"א - חדושי הלכות על בבא מציעא" → "מהרש\"א - חידושי הלכות על בבא מציעא"
- update {"id": 4471}: **title**: "מהרש\"א - חדושי הלכות על סנהדרין" → "מהרש\"א - חידושי הלכות על סנהדרין"
- update {"id": 4472}: **title**: "מהרש\"א - חדושי הלכות על בבא קמא" → "מהרש\"א - חידושי הלכות על בבא קמא"
- update {"id": 4473}: **title**: "מהרש\"א - חדושי הלכות על מכות" → "מהרש\"א - חידושי הלכות על מכות"
- update {"id": 4474}: **title**: "מהרש\"א - חדושי הלכות על בבא בתרא" → "מהרש\"א - חידושי הלכות על בבא בתרא"
- update {"id": 4975}: **title**: "חדושי הר\"י מיגאש על בבא בתרא" → "חידושי הר\"י מיגאש על בבא בתרא"
- update {"id": 4976}: **title**: "חדושי הר\"י מיגאש על שבועות" → "חידושי הר\"י מיגאש על שבועות"
- update {"id": 5061}: **title**: "תוספות ישנים  על כריתות" → "תוספות ישנים על כריתות"
- update {"id": 5071}: **title**: "חדושי הרא\"ה על כתובות" → "חידושי הרא\"ה על כתובות"
- update {"id": 5775}: **categoryId**: 1476 → 1746
- update {"id": 5777}: **categoryId**: 1476 → 1746
- update {"id": 5779}: **categoryId**: 1476 → 1746

### `upsert_book_acronym` (6 rows)

- insert {"bookId": 4976, "term": "חדושי הר\"י מיגאש על שבועות"}
- insert {"bookId": 4975, "term": "חדושי הר\"י מיגאש על בבא בתרא"}
- insert {"bookId": 5071, "term": "חדושי הרא\"ה על כתובות"}
- insert {"bookId": 6305, "term": "חוות דעת חדושים"}
- insert {"bookId": 7575, "term": "חדושי רעא על תלמוד בבלי"}
- insert {"bookId": 8023, "term": "חדושי הרי מיגאש על בבא מציעא"}

### `upsert_book_topic` (116 rows, first 30 shown)

- insert {"bookId": 6225, "topicId": 285}
- insert {"bookId": 6226, "topicId": 285}
- insert {"bookId": 6310, "topicId": 286}
- insert {"bookId": 6311, "topicId": 286}
- insert {"bookId": 6312, "topicId": 286}
- insert {"bookId": 6313, "topicId": 287}
- insert {"bookId": 6314, "topicId": 287}
- insert {"bookId": 6385, "topicId": 288}
- insert {"bookId": 6386, "topicId": 288}
- insert {"bookId": 6573, "topicId": 289}
- insert {"bookId": 6574, "topicId": 289}
- insert {"bookId": 6575, "topicId": 289}
- insert {"bookId": 6622, "topicId": 290}
- insert {"bookId": 6623, "topicId": 290}
- insert {"bookId": 6624, "topicId": 290}
- insert {"bookId": 7064, "topicId": 291}
- insert {"bookId": 7065, "topicId": 291}
- insert {"bookId": 7066, "topicId": 291}
- insert {"bookId": 7070, "topicId": 292}
- insert {"bookId": 7071, "topicId": 292}
- insert {"bookId": 7072, "topicId": 292}
- insert {"bookId": 7073, "topicId": 292}
- insert {"bookId": 7074, "topicId": 293}
- insert {"bookId": 7075, "topicId": 293}
- insert {"bookId": 7076, "topicId": 293}
- insert {"bookId": 7077, "topicId": 293}
- insert {"bookId": 7223, "topicId": 294}
- insert {"bookId": 7224, "topicId": 294}
- insert {"bookId": 7237, "topicId": 295}
- insert {"bookId": 7238, "topicId": 295}

### `upsert_category` (30 rows)

- update {"id": 1043}: **title**: "חדושי הרא״ה" → "חידושי הרא״ה"
- insert {"id": 1745, "parentId": 64, "title": "שו״ת מהרש״ם", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי שלום מרדכי [המהרש\"ם] ב\"ר משה הכהן שבדרון.", "heDesc": "תשובות בענייני הלכה מרבי שלום מרדכי [המהרש\"ם] ב\"ר משה הכהן שבדרון."}
- insert {"id": 1746, "parentId": 1160, "title": "רמח״ל", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבנו הרמח\"ל, בעניינים שונים, הנהגת ה', דרכי הלימוד, ועוד.", "heDesc": "חיבורי רבנו הרמח\"ל, בעניינים שונים, הנהגת ה', דרכי הלימוד, ועוד."}
- insert {"id": 1747, "parentId": 124, "title": "מהר״ם שיק תרי״ג מצות", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1748, "parentId": 80, "title": "חידושי הרי״מ", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1749, "parentId": 80, "title": "חידושי מהרא״ך", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1750, "parentId": 74, "title": "ספר ימי מוהרנ״ת", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1751, "parentId": 764, "title": "רא״ש", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבנו אשר ב\"ר יחיאל על המשנה.", "heDesc": "חיבורי רבנו אשר ב\"ר יחיאל על המשנה."}
- insert {"id": 1752, "parentId": 64, "title": "מבי״ט", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי משה מטראני [המבי\"ט].", "heDesc": "תשובות בענייני הלכה מרבי משה מטראני [המבי\"ט]."}
- insert {"id": 1753, "parentId": 64, "title": "מהר״ם שיק", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי משה שיק.", "heDesc": "תשובות בענייני הלכה מרבי משה שיק."}
- insert {"id": 1754, "parentId": 64, "title": "מהר״ש", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי שמואל אנגל.", "heDesc": "תשובות בענייני הלכה מרבי שמואל אנגל."}
- insert {"id": 1755, "parentId": 64, "title": "שו״ת עטרת חכמים", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1756, "parentId": 64, "title": "שו״ת שבט סופר", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1757, "parentId": 64, "title": "שו״ת תעלומות לב", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי אליהו בכור חזן.", "heDesc": "תשובות בענייני הלכה מרבי אליהו בכור חזן."}
- insert {"id": 1758, "parentId": 64, "title": "תשובות הרא״ם", "level": 2, "orderIndex": 999, "heShortDesc": "תשובות בענייני הלכה מרבי אלכסנדר סנדר מרגליות.", "heDesc": "תשובות בענייני הלכה מרבי אלכסנדר סנדר מרגליות."}
- insert {"id": 1759, "parentId": 64, "title": "תשורת ש״י", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1760, "parentId": 871, "title": "חידושי הלכות מהר״ם חריף", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1761, "parentId": 871, "title": "חידושי המהרי״ט", "level": 2, "orderIndex": 999, "heShortDesc": "חידושי רבי יוסף מטראני [המהרי\"ט] על הש\"ס.", "heDesc": "חידושי רבי יוסף מטראני [המהרי\"ט] על הש\"ס."}
- insert {"id": 1762, "parentId": 871, "title": "ליקוטי מהרי״ל", "level": 2, "orderIndex": 999, "heShortDesc": "ליקוטי רבי י־הודה ליב מזקילקוב על הש\"ס.", "heDesc": "ליקוטי רבי י־הודה ליב מזקילקוב על הש\"ס."}
- insert {"id": 1763, "parentId": 1762, "title": "סדר נשים", "level": 3, "orderIndex": 999, "heShortDesc": "ליקוטי מהריל על מסכתות סדר נשים.", "heDesc": "ליקוטי מהריל על מסכתות סדר נשים."}
- insert {"id": 1764, "parentId": 1683, "title": "גליוני הש״ס", "level": 3, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות הש\"ס.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות הש\"ס."}
- insert {"id": 1765, "parentId": 1764, "title": "מועד", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר מועד.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר מועד."}
- insert {"id": 1766, "parentId": 1764, "title": "נזיקין", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נזיקין.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נזיקין."}
- insert {"id": 1767, "parentId": 1764, "title": "נשים", "level": 4, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נשים.", "heDesc": "חיבורי רבי יוסף ענגיל, 'גליוני הש\"ס', על מסכתות סדר נשים."}
- insert {"id": 1768, "parentId": 990, "title": "ריב״ן", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1769, "parentId": 784, "title": "גליוני הש״ס", "level": 2, "orderIndex": 999, "heShortDesc": "חיבורי רבי יוסף ב\"ר יהודה ענגיל על התלמוד הירושלמי.", "heDesc": "חיבורי רבי יוסף ב\"ר יהודה ענגיל על התלמוד הירושלמי."}
- insert {"id": 1770, "parentId": 1769, "title": "מועד", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1771, "parentId": 1769, "title": "נזיקין", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1772, "parentId": 1769, "title": "נשים", "level": 3, "orderIndex": 999, "heShortDesc": null, "heDesc": null}
- insert {"id": 1773, "parentId": 622, "title": "פירוש הגר״א", "level": 2, "orderIndex": 999, "heShortDesc": null, "heDesc": null}

### `upsert_category_closure` (100 rows, first 30 shown)

- insert {"ancestorId": 1764, "descendantId": 1764}
- insert {"ancestorId": 1683, "descendantId": 1764}
- insert {"ancestorId": 871, "descendantId": 1764}
- insert {"ancestorId": 12, "descendantId": 1764}
- insert {"ancestorId": 1769, "descendantId": 1769}
- insert {"ancestorId": 784, "descendantId": 1769}
- insert {"ancestorId": 19, "descendantId": 1769}
- insert {"ancestorId": 1760, "descendantId": 1760}
- insert {"ancestorId": 871, "descendantId": 1760}
- insert {"ancestorId": 12, "descendantId": 1760}
- insert {"ancestorId": 1761, "descendantId": 1761}
- insert {"ancestorId": 871, "descendantId": 1761}
- insert {"ancestorId": 12, "descendantId": 1761}
- insert {"ancestorId": 1748, "descendantId": 1748}
- insert {"ancestorId": 80, "descendantId": 1748}
- insert {"ancestorId": 61, "descendantId": 1748}
- insert {"ancestorId": 43, "descendantId": 1748}
- insert {"ancestorId": 1749, "descendantId": 1749}
- insert {"ancestorId": 80, "descendantId": 1749}
- insert {"ancestorId": 61, "descendantId": 1749}
- insert {"ancestorId": 43, "descendantId": 1749}
- insert {"ancestorId": 1762, "descendantId": 1762}
- insert {"ancestorId": 871, "descendantId": 1762}
- insert {"ancestorId": 12, "descendantId": 1762}
- insert {"ancestorId": 1752, "descendantId": 1752}
- insert {"ancestorId": 64, "descendantId": 1752}
- insert {"ancestorId": 62, "descendantId": 1752}
- insert {"ancestorId": 1753, "descendantId": 1753}
- insert {"ancestorId": 64, "descendantId": 1753}
- insert {"ancestorId": 62, "descendantId": 1753}

### `upsert_line` (16901 rows, first 30 shown)

- update {"id": 4483870}: **heRef**: "חוות דעת חדושים 2" → "חוות דעת חידושים 2"
- update {"id": 4483873}: **heRef**: "חוות דעת חדושים 5" → "חוות דעת חידושים 5"
- update {"id": 4483875}: **heRef**: "חוות דעת חדושים 7" → "חוות דעת חידושים 7"
- update {"id": 4483877}: **heRef**: "חוות דעת חדושים 9" → "חוות דעת חידושים 9"
- update {"id": 4483879}: **heRef**: "חוות דעת חדושים 11" → "חוות דעת חידושים 11"
- update {"id": 4483881}: **heRef**: "חוות דעת חדושים 13" → "חוות דעת חידושים 13"
- update {"id": 4483883}: **heRef**: "חוות דעת חדושים 15" → "חוות דעת חידושים 15"
- update {"id": 4483885}: **heRef**: "חוות דעת חדושים 17" → "חוות דעת חידושים 17"
- update {"id": 4483887}: **heRef**: "חוות דעת חדושים 19" → "חוות דעת חידושים 19"
- update {"id": 4483889}: **heRef**: "חוות דעת חדושים 21" → "חוות דעת חידושים 21"
- update {"id": 4483891}: **heRef**: "חוות דעת חדושים 23" → "חוות דעת חידושים 23"
- update {"id": 4483892}: **heRef**: "חוות דעת חדושים 24" → "חוות דעת חידושים 24"
- update {"id": 4483894}: **heRef**: "חוות דעת חדושים 26" → "חוות דעת חידושים 26"
- update {"id": 4483896}: **heRef**: "חוות דעת חדושים 28" → "חוות דעת חידושים 28"
- update {"id": 4483898}: **heRef**: "חוות דעת חדושים 30" → "חוות דעת חידושים 30"
- update {"id": 4483900}: **heRef**: "חוות דעת חדושים 32" → "חוות דעת חידושים 32"
- update {"id": 4483902}: **heRef**: "חוות דעת חדושים 34" → "חוות דעת חידושים 34"
- update {"id": 4483904}: **heRef**: "חוות דעת חדושים 36" → "חוות דעת חידושים 36"
- update {"id": 4483906}: **heRef**: "חוות דעת חדושים 38" → "חוות דעת חידושים 38"
- update {"id": 4483908}: **heRef**: "חוות דעת חדושים 40" → "חוות דעת חידושים 40"
- update {"id": 4483910}: **heRef**: "חוות דעת חדושים 42" → "חוות דעת חידושים 42"
- update {"id": 4483912}: **heRef**: "חוות דעת חדושים 44" → "חוות דעת חידושים 44"
- update {"id": 4483914}: **heRef**: "חוות דעת חדושים 46" → "חוות דעת חידושים 46"
- update {"id": 4483916}: **heRef**: "חוות דעת חדושים 48" → "חוות דעת חידושים 48"
- update {"id": 4483918}: **heRef**: "חוות דעת חדושים 50" → "חוות דעת חידושים 50"
- update {"id": 4483920}: **heRef**: "חוות דעת חדושים 52" → "חוות דעת חידושים 52"
- update {"id": 4483922}: **heRef**: "חוות דעת חדושים 54" → "חוות דעת חידושים 54"
- update {"id": 4483924}: **heRef**: "חוות דעת חדושים 56" → "חוות דעת חידושים 56"
- update {"id": 4483926}: **heRef**: "חוות דעת חדושים 58" → "חוות דעת חידושים 58"
- update {"id": 4483928}: **heRef**: "חוות דעת חדושים 60" → "חוות דעת חידושים 60"

### `upsert_schema_meta` (1 rows)

- update {"key": "db_version"}: **value**: "1" → "2"

### `upsert_topic` (22 rows)

- insert {"id": 285, "name": "מהר״ם שיק תרי״ג מצות"}
- insert {"id": 286, "name": "חידושי הרי״מ"}
- insert {"id": 287, "name": "חידושי מהרא״ך"}
- insert {"id": 288, "name": "ספר ימי מוהרנ״ת"}
- insert {"id": 289, "name": "רמח״ל"}
- insert {"id": 290, "name": "רא״ש"}
- insert {"id": 291, "name": "מבי״ט"}
- insert {"id": 292, "name": "מהר״ם שיק"}
- insert {"id": 293, "name": "מהר״ש"}
- insert {"id": 294, "name": "שו״ת מהרש״ם"}
- insert {"id": 295, "name": "שו״ת עטרת חכמים"}
- insert {"id": 296, "name": "שו״ת שבט סופר"}
- insert {"id": 297, "name": "שו״ת תעלומות לב"}
- insert {"id": 298, "name": "תשובות הרא״ם"}
- insert {"id": 299, "name": "תשורת ש״י"}
- insert {"id": 300, "name": "חידושי הלכות מהר״ם חריף"}
- insert {"id": 301, "name": "חידושי המהרי״ט"}
- insert {"id": 302, "name": "ליקוטי מהרי״ל"}
- insert {"id": 303, "name": "גליוני הש״ס"}
- insert {"id": 304, "name": "חידושי הרא״ה"}
- insert {"id": 305, "name": "ריב״ן"}
- insert {"id": 306, "name": "פירוש הגר״א"}

## Full list: book title changes (28)

| id | v1 title | v2a title | book.heRef changed | line.heRef rows changed |
|---|---|---|---|---|
| 4447 | מהרש"א - חדושי הלכות על ביצה | מהרש"א - חידושי הלכות על ביצה | no | 0 |
| 4448 | מהרש"א - חדושי הלכות על פסחים | מהרש"א - חידושי הלכות על פסחים | no | 0 |
| 4450 | מהרש"א - חדושי הלכות על ראש השנה | מהרש"א - חידושי הלכות על ראש השנה | no | 0 |
| 4454 | מהרש"א - חדושי הלכות על סוכה | מהרש"א - חידושי הלכות על סוכה | no | 0 |
| 4456 | מהרש"א - חדושי הלכות על חולין | מהרש"א - חידושי הלכות על חולין | no | 0 |
| 4457 | מהרש"א - חדושי הלכות על בכורות | מהרש"א - חידושי הלכות על בכורות | no | 0 |
| 4458 | מהרש"א - חדושי הלכות על מנחות | מהרש"א - חידושי הלכות על מנחות | no | 0 |
| 4459 | מהרש"א - חדושי הלכות על קידושין | מהרש"א - חידושי הלכות על קידושין | no | 0 |
| 4460 | מהרש"א - חדושי הלכות על יבמות | מהרש"א - חידושי הלכות על יבמות | no | 0 |
| 4461 | מהרש"א - חדושי הלכות על נדרים | מהרש"א - חידושי הלכות על נדרים | no | 0 |
| 4464 | מהרש"א - חדושי הלכות על גיטין | מהרש"א - חידושי הלכות על גיטין | no | 0 |
| 4465 | מהרש"א - חדושי הלכות על סוטה | מהרש"א - חידושי הלכות על סוטה | no | 0 |
| 4467 | מהרש"א - חדושי הלכות על שבועות | מהרש"א - חידושי הלכות על שבועות | no | 0 |
| 4468 | מהרש"א - חדושי הלכות על הוריות | מהרש"א - חידושי הלכות על הוריות | no | 0 |
| 4469 | מהרש"א - חדושי הלכות על עבודה זרה | מהרש"א - חידושי הלכות על עבודה זרה | no | 0 |
| 4470 | מהרש"א - חדושי הלכות על בבא מציעא | מהרש"א - חידושי הלכות על בבא מציעא | no | 0 |
| 4471 | מהרש"א - חדושי הלכות על סנהדרין | מהרש"א - חידושי הלכות על סנהדרין | no | 0 |
| 4472 | מהרש"א - חדושי הלכות על בבא קמא | מהרש"א - חידושי הלכות על בבא קמא | no | 0 |
| 4473 | מהרש"א - חדושי הלכות על מכות | מהרש"א - חידושי הלכות על מכות | no | 0 |
| 4474 | מהרש"א - חדושי הלכות על בבא בתרא | מהרש"א - חידושי הלכות על בבא בתרא | no | 0 |
| 4975 | חדושי הר"י מיגאש על בבא בתרא | חידושי הר"י מיגאש על בבא בתרא | no | 0 |
| 4976 | חדושי הר"י מיגאש על שבועות | חידושי הר"י מיגאש על שבועות | no | 0 |
| 5061 | תוספות ישנים  על כריתות | תוספות ישנים על כריתות | no | 0 |
| 5071 | חדושי הרא"ה על כתובות | חידושי הרא"ה על כתובות | no | 0 |
| 6305 | חוות דעת חדושים | חוות דעת חידושים | yes | 1231 |
| 7575 | חדושי רע״א על תלמוד בבלי | חידושי רע״א על תלמוד בבלי | yes | 15478 |
| 7971 | חידושי הראה על עבודה זרה | חידושי הרא״ה על עבודה זרה | yes | 189 |
| 8023 | חדושי הרי מיגאש על בבא מציעא | חידושי הר״י מיגאש על בבא מציעא | yes | 3 |

## Full list: category changes

Renamed in place (same id):

- 1043: `תלמוד בבלי/ראשונים/חדושי הרא״ה` → `תלמוד בבלי/ראשונים/חידושי הרא״ה`

Deleted (v1) — 29 categories:

- 1472 `שו״ת/אחרונים/שות מהרשם`
- 1476 `מחשבת ישראל/אחרונים/רמחל`
- 1503 `הלכה/ספרי מצוות/מהרם שיק תריג מצות`
- 1513 `הלכה/שולחן ערוך/מפרשים/חידושי הרימ`
- 1514 `הלכה/שולחן ערוך/מפרשים/חידושי מהראך`
- 1525 `חסידות/ברסלב/ספר ימי מוהרנת`
- 1546 `משנה/ראשונים/ראש`
- 1597 `שו״ת/אחרונים/מביט`
- 1598 `שו״ת/אחרונים/מהרם שיק`
- 1599 `שו״ת/אחרונים/מהרש`
- 1614 `שו״ת/אחרונים/שות עטרת חכמים`
- 1615 `שו״ת/אחרונים/שות שבט סופר`
- 1616 `שו״ת/אחרונים/שות תעלומות לב`
- 1619 `שו״ת/אחרונים/תשובות הראם`
- 1620 `שו״ת/אחרונים/תשורת שי`
- 1652 `תלמוד בבלי/אחרונים/חידושי הלכות מהרם חריף`
- 1653 `תלמוד בבלי/אחרונים/חידושי המהריט`
- 1665 `תלמוד בבלי/אחרונים/ליקוטי מהריל`
- 1666 `תלמוד בבלי/אחרונים/ליקוטי מהריל/סדר נשים`
- 1684 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני השס`
- 1685 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני השס/מועד`
- 1686 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני השס/נזיקין`
- 1687 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני השס/נשים`
- 1720 `תלמוד בבלי/ראשונים/ריבן`
- 1724 `תלמוד ירושלמי/מפרשים/גליוני השס`
- 1725 `תלמוד ירושלמי/מפרשים/גליוני השס/מועד`
- 1726 `תלמוד ירושלמי/מפרשים/גליוני השס/נזיקין`
- 1727 `תלמוד ירושלמי/מפרשים/גליוני השס/נשים`
- 1734 `תנ״ך/אחרונים/פירוש הגרא`

Created (v2a) — 29 categories:

- 1745 `שו״ת/אחרונים/שו״ת מהרש״ם`
- 1746 `מחשבת ישראל/אחרונים/רמח״ל`
- 1747 `הלכה/ספרי מצוות/מהר״ם שיק תרי״ג מצות`
- 1748 `הלכה/שולחן ערוך/מפרשים/חידושי הרי״מ`
- 1749 `הלכה/שולחן ערוך/מפרשים/חידושי מהרא״ך`
- 1750 `חסידות/ברסלב/ספר ימי מוהרנ״ת`
- 1751 `משנה/ראשונים/רא״ש`
- 1752 `שו״ת/אחרונים/מבי״ט`
- 1753 `שו״ת/אחרונים/מהר״ם שיק`
- 1754 `שו״ת/אחרונים/מהר״ש`
- 1755 `שו״ת/אחרונים/שו״ת עטרת חכמים`
- 1756 `שו״ת/אחרונים/שו״ת שבט סופר`
- 1757 `שו״ת/אחרונים/שו״ת תעלומות לב`
- 1758 `שו״ת/אחרונים/תשובות הרא״ם`
- 1759 `שו״ת/אחרונים/תשורת ש״י`
- 1760 `תלמוד בבלי/אחרונים/חידושי הלכות מהר״ם חריף`
- 1761 `תלמוד בבלי/אחרונים/חידושי המהרי״ט`
- 1762 `תלמוד בבלי/אחרונים/ליקוטי מהרי״ל`
- 1763 `תלמוד בבלי/אחרונים/ליקוטי מהרי״ל/סדר נשים`
- 1764 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני הש״ס`
- 1765 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני הש״ס/מועד`
- 1766 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני הש״ס/נזיקין`
- 1767 `תלמוד בבלי/אחרונים/ר' יוסף ענגיל/גליוני הש״ס/נשים`
- 1768 `תלמוד בבלי/ראשונים/ריב״ן`
- 1769 `תלמוד ירושלמי/מפרשים/גליוני הש״ס`
- 1770 `תלמוד ירושלמי/מפרשים/גליוני הש״ס/מועד`
- 1771 `תלמוד ירושלמי/מפרשים/גליוני הש״ס/נזיקין`
- 1772 `תלמוד ירושלמי/מפרשים/גליוני הש״ס/נשים`
- 1773 `תנ״ך/אחרונים/פירוש הגר״א`

Books whose categoryId changed: 122 (all inside the 29 re-created categories).

## Table totals v1 → v2a (tables whose count differs)

- `book_acronym`: 41825 → 41828
- `line_dh`: 1273149 → 1271986
- `link`: 4454493 → 4454492
- `topic`: 284 → 285
