# DELTA v1 → v2b (libdata-2611)

## Per-table row counts in patch.db (non-zero only; every other upsert_/delete_ table = 0)

| table | upsert | delete |
|---|---|---|
| `book` | 39 | 0 |
| `category` | 1 | 0 |
| `line` | 321 | 321 |
| `line_content` | 321 | 321 |
| `line_toc` | 321 | 321 |
| `link` | 6 | 6 |
| `link_coverage` | 1 | 0 |
| `link_range` | 1 | 0 |
| `schema_meta` | 1 | 0 |

Total rows: 1981.

### `delete_line` (321 rows, first 40 shown)

- delete {"id": 6933313, "bookId": 7932, "lineIndex": 1596, "heRef": "חברותא על בבא בתרא 1597", "tocEntryId": null, "charCount": 20}
- delete {"id": 6934354, "bookId": 7932, "lineIndex": 2637, "heRef": "חברותא על בבא בתרא 2638", "tocEntryId": null, "charCount": 21}
- delete {"id": 6936346, "bookId": 7932, "lineIndex": 4629, "heRef": "חברותא על בבא בתרא 4630", "tocEntryId": null, "charCount": 23}
- delete {"id": 6937144, "bookId": 7932, "lineIndex": 5427, "heRef": "חברותא על בבא בתרא 5428", "tocEntryId": null, "charCount": 26}
- delete {"id": 6939072, "bookId": 7932, "lineIndex": 7355, "heRef": "חברותא על בבא בתרא 7356", "tocEntryId": null, "charCount": 28}
- delete {"id": 6939714, "bookId": 7932, "lineIndex": 7997, "heRef": "חברותא על בבא בתרא 7998", "tocEntryId": null, "charCount": 24}
- delete {"id": 6940049, "bookId": 7932, "lineIndex": 8332, "heRef": "חברותא על בבא בתרא 8333", "tocEntryId": null, "charCount": 20}
- delete {"id": 6941986, "bookId": 7932, "lineIndex": 10269, "heRef": "חברותא על בבא בתרא 10270", "tocEntryId": null, "charCount": 22}
- delete {"id": 6943358, "bookId": 7932, "lineIndex": 11641, "heRef": "חברותא על בבא בתרא 11642", "tocEntryId": null, "charCount": 19}
- delete {"id": 6944360, "bookId": 7932, "lineIndex": 12643, "heRef": "חברותא על בבא בתרא 12644", "tocEntryId": null, "charCount": 44}
- delete {"id": 6946209, "bookId": 7933, "lineIndex": 1848, "heRef": "חברותא על בבא מציעא 1849", "tocEntryId": null, "charCount": 24}
- delete {"id": 6947752, "bookId": 7933, "lineIndex": 3391, "heRef": "חברותא על בבא מציעא 3392", "tocEntryId": null, "charCount": 23}
- delete {"id": 6948850, "bookId": 7933, "lineIndex": 4489, "heRef": "חברותא על בבא מציעא 4490", "tocEntryId": null, "charCount": 19}
- delete {"id": 6950788, "bookId": 7933, "lineIndex": 6427, "heRef": "חברותא על בבא מציעא 6428", "tocEntryId": null, "charCount": 17}
- delete {"id": 6952392, "bookId": 7933, "lineIndex": 8031, "heRef": "חברותא על בבא מציעא 8032", "tocEntryId": null, "charCount": 21}
- delete {"id": 6953200, "bookId": 7933, "lineIndex": 8839, "heRef": "חברותא על בבא מציעא 8840", "tocEntryId": null, "charCount": 29}
- delete {"id": 6954646, "bookId": 7933, "lineIndex": 10285, "heRef": "חברותא על בבא מציעא 10286", "tocEntryId": null, "charCount": 29}
- delete {"id": 6955664, "bookId": 7933, "lineIndex": 11303, "heRef": "חברותא על בבא מציעא 11304", "tocEntryId": null, "charCount": 18}
- delete {"id": 6957003, "bookId": 7933, "lineIndex": 12642, "heRef": "חברותא על בבא מציעא 12643", "tocEntryId": null, "charCount": 18}
- delete {"id": 6957318, "bookId": 7933, "lineIndex": 12957, "heRef": "חברותא על בבא מציעא 12958", "tocEntryId": null, "charCount": 50}
- delete {"id": 6958674, "bookId": 7934, "lineIndex": 1355, "heRef": "חברותא על בבא קמא 1356", "tocEntryId": null, "charCount": 23}
- delete {"id": 6959746, "bookId": 7934, "lineIndex": 2427, "heRef": "חברותא על בבא קמא 2428", "tocEntryId": null, "charCount": 22}
- delete {"id": 6960775, "bookId": 7934, "lineIndex": 3456, "heRef": "חברותא על בבא קמא 3457", "tocEntryId": null, "charCount": 18}
- delete {"id": 6961770, "bookId": 7934, "lineIndex": 4451, "heRef": "חברותא על בבא קמא 4452", "tocEntryId": null, "charCount": 33}
- delete {"id": 6962747, "bookId": 7934, "lineIndex": 5428, "heRef": "חברותא על בבא קמא 5429", "tocEntryId": null, "charCount": 29}
- delete {"id": 6963430, "bookId": 7934, "lineIndex": 6111, "heRef": "חברותא על בבא קמא 6112", "tocEntryId": null, "charCount": 18}
- delete {"id": 6965396, "bookId": 7934, "lineIndex": 8077, "heRef": "חברותא על בבא קמא 8078", "tocEntryId": null, "charCount": 18}
- delete {"id": 6966531, "bookId": 7934, "lineIndex": 9212, "heRef": "חברותא על בבא קמא 9213", "tocEntryId": null, "charCount": 18}
- delete {"id": 6968089, "bookId": 7934, "lineIndex": 10770, "heRef": "חברותא על בבא קמא 10771", "tocEntryId": null, "charCount": 23}
- delete {"id": 6969011, "bookId": 7934, "lineIndex": 11692, "heRef": "חברותא על בבא קמא 11693", "tocEntryId": null, "charCount": 46}
- delete {"id": 6970580, "bookId": 7935, "lineIndex": 1568, "heRef": "חברותא על ביצה 1569", "tocEntryId": null, "charCount": 17}
- delete {"id": 6971473, "bookId": 7935, "lineIndex": 2461, "heRef": "חברותא על ביצה 2462", "tocEntryId": null, "charCount": 20}
- delete {"id": 6972085, "bookId": 7935, "lineIndex": 3073, "heRef": "חברותא על ביצה 3074", "tocEntryId": null, "charCount": 21}
- delete {"id": 6972828, "bookId": 7935, "lineIndex": 3816, "heRef": "חברותא על ביצה 3817", "tocEntryId": null, "charCount": 18}
- delete {"id": 6973430, "bookId": 7935, "lineIndex": 4418, "heRef": "חברותא על ביצה 4419", "tocEntryId": null, "charCount": 25}
- delete {"id": 6973431, "bookId": 7935, "lineIndex": 4419, "heRef": "חברותא על ביצה 4420", "tocEntryId": null, "charCount": 19}
- delete {"id": 6974575, "bookId": 7936, "lineIndex": 1142, "heRef": "חברותא על בכורות 1143", "tocEntryId": null, "charCount": 29}
- delete {"id": 6975158, "bookId": 7936, "lineIndex": 1725, "heRef": "חברותא על בכורות 1726", "tocEntryId": null, "charCount": 28}
- delete {"id": 6975646, "bookId": 7936, "lineIndex": 2213, "heRef": "חברותא על בכורות 2214", "tocEntryId": null, "charCount": 23}
- delete {"id": 6976613, "bookId": 7936, "lineIndex": 3180, "heRef": "חברותא על בכורות 3181", "tocEntryId": null, "charCount": 30}

### `delete_line_content` (321 rows, first 40 shown)

- delete {"id": 6933313, "content": "<br><center><big><b>הדרן עלך פרק השותפין</b></big></center>"}
- delete {"id": 6934354, "content": "<br><center><big><b>הדרן עלך פרק לא יחפור</b></big></center>"}
- delete {"id": 6936346, "content": "<br><center><big><b>הדרן עלך פרק חזקת הבתים</b></big></center>"}
- delete {"id": 6937144, "content": "<br><center><big><b>הדרן עלך פרק המוכר את הבית</b></big></center>"}
- delete {"id": 6939072, "content": "<br><center><big><b>הדרן עלך פרק המוכר את הספינה</b></big></center>"}
- delete {"id": 6939714, "content": "<br><center><big><b>הדרן עלך פרק המוכר פירות</b></big></center>"}
- delete {"id": 6940049, "content": "<br><center><big><b>הדרן עלך פרק בית כור</b></big></center>"}
- delete {"id": 6941986, "content": "<br><center><big><b>הדרן עלך פרק יש נוחלין</b></big></center>"}
- delete {"id": 6943358, "content": "<br><center><big><b>הדרן עלך פרק מי שמת</b></big></center>"}
- delete {"id": 6944360, "content": "<br><center><big><b>הדרן עלך פרק גט פשוט וסליקא לה מסכת בבא בתרא</b></big></center>"}
- delete {"id": 6946209, "content": "<br><center><big><b>הדרן עלך פרק שנים אוחזין</b></big></center>"}
- delete {"id": 6947752, "content": "<br><center><big><b>הדרן עלך פרק אלו מציאות</b></big></center>"}
- delete {"id": 6948850, "content": "<br><center><big><b>הדרן עלך פרק המפקיד</b></big></center>"}
- delete {"id": 6950788, "content": "<br><center><big><b>הדרן עלך פרק הזהב</b></big></center>"}
- delete {"id": 6952392, "content": "<br><center><big><b>הדרן עלך פרק איזו נשך</b></big></center>"}
- delete {"id": 6953200, "content": "<br><center><big><b>הדרן עלך פרק השוכר את האומנין</b></big></center>"}
- delete {"id": 6954646, "content": "<br><center><big><b>הדרן עלך פרק השוכר את הפועלים</b></big></center>"}
- delete {"id": 6955664, "content": "<br><center><big><b>הדרן עלך פרק השואל</b></big></center>"}
- delete {"id": 6957003, "content": "<br><center><big><b>הדרן הלך פרק המקבל</b></big></center>"}
- delete {"id": 6957318, "content": "<br><center><big><b>הדרן עלך פרק הבית והעליה וסליקא לה מסכת בבא מציעא.</b></big></center>"}
- delete {"id": 6958674, "content": "<br><center><big><b>הדרן עלך פרק ארבעה אבות</b></big></center>"}
- delete {"id": 6959746, "content": "<br><center><big><b>הדרן עלך פרק כיצד הרגל</b></big></center>"}
- delete {"id": 6960775, "content": "<br><center><big><b>הדרן עלך פרק המניח</b></big></center>"}
- delete {"id": 6961770, "content": "<br><center><big><b>הדרן עלך פרק שור שנגח ארבעה וחמשה</b></big></center>"}
- delete {"id": 6962747, "content": "<br><center><big><b>הדרן עלך פרק שור שנגח את הפרה</b></big></center>"}
- delete {"id": 6963430, "content": "<br><center><big><b>הדרן פרק עלך הכונס</b></big></center>"}
- delete {"id": 6965396, "content": "<br><center><big><b>הדרן עלך פרק מרובה</b></big></center>"}
- delete {"id": 6966531, "content": "<br><center><big><b>הדרן עלך פרק החובל</b></big></center>"}
- delete {"id": 6968089, "content": "<br><center><big><b>הדרן עלך פרק הגוזל עצים</b></big></center>"}
- delete {"id": 6969011, "content": "<br><center><big><b>הדרן עלך פרק הגוזל בתרא וסליקא לה מסכת בבא קמא</b></big></center>"}
- delete {"id": 6970580, "content": "<br><center><big><b>הדרן עלך פרק ביצה</b></big></center>"}
- delete {"id": 6971473, "content": "<br><center><big><b>הדרן עלך פרק יום טוב</b></big></center>"}
- delete {"id": 6972085, "content": "<br><center><big><b>הדרן עלך פרק אין צדין</b></big></center>"}
- delete {"id": 6972828, "content": "<br><center><big><b>הדרן עלך פרק המביא</b></big></center>"}
- delete {"id": 6973430, "content": "<br><center><big><b>הדרן עלך פרק משילין פירות</b></big></center>"}
- delete {"id": 6973431, "content": "<center><b><big>וסליקא לן מסכת ביצה</big></b></center>"}
- delete {"id": 6974575, "content": "<br><center><big><b>הדרן עלך פרק הלוקח עובר חמורו</b></big></center>"}
- delete {"id": 6975158, "content": "<br><center><big><b>הדרן עלך פרק הלוקח עובר פרתו</b></big></center>"}
- delete {"id": 6975646, "content": "<br><center><big><b>הדרן עלך פרק הלוקח בהמה</b></big></center>"}
- delete {"id": 6976613, "content": "<br><center><big><b>הדרן עלך פרק כל פסולי המוקדשין</b></big></center>"}

### `delete_line_toc` (321 rows, first 40 shown)

- delete {"lineId": 6933313, "tocEntryId": 1421174}
- delete {"lineId": 6934354, "tocEntryId": 1421196}
- delete {"lineId": 6936346, "tocEntryId": 1421264}
- delete {"lineId": 6937144, "tocEntryId": 1421290}
- delete {"lineId": 6939072, "tocEntryId": 1421329}
- delete {"lineId": 6939714, "tocEntryId": 1421352}
- delete {"lineId": 6940049, "tocEntryId": 1421364}
- delete {"lineId": 6941986, "tocEntryId": 1421428}
- delete {"lineId": 6943358, "tocEntryId": 1421470}
- delete {"lineId": 6944360, "tocEntryId": 1421505}
- delete {"lineId": 6946209, "tocEntryId": 1421547}
- delete {"lineId": 6947752, "tocEntryId": 1421574}
- delete {"lineId": 6948850, "tocEntryId": 1421596}
- delete {"lineId": 6950788, "tocEntryId": 1421631}
- delete {"lineId": 6952392, "tocEntryId": 1421663}
- delete {"lineId": 6953200, "tocEntryId": 1421679}
- delete {"lineId": 6954646, "tocEntryId": 1421702}
- delete {"lineId": 6955664, "tocEntryId": 1421721}
- delete {"lineId": 6957003, "tocEntryId": 1421748}
- delete {"lineId": 6957318, "tocEntryId": 1421756}
- delete {"lineId": 6958674, "tocEntryId": 1421789}
- delete {"lineId": 6959746, "tocEntryId": 1421810}
- delete {"lineId": 6960775, "tocEntryId": 1421830}
- delete {"lineId": 6961770, "tocEntryId": 1421851}
- delete {"lineId": 6962747, "tocEntryId": 1421870}
- delete {"lineId": 6963430, "tocEntryId": 1421886}
- delete {"lineId": 6965396, "tocEntryId": 1421928}
- delete {"lineId": 6966531, "tocEntryId": 1421949}
- delete {"lineId": 6968089, "tocEntryId": 1421986}
- delete {"lineId": 6969011, "tocEntryId": 1422004}
- delete {"lineId": 6970580, "tocEntryId": 1422034}
- delete {"lineId": 6971473, "tocEntryId": 1422052}
- delete {"lineId": 6972085, "tocEntryId": 1422065}
- delete {"lineId": 6972828, "tocEntryId": 1422078}
- delete {"lineId": 6973430, "tocEntryId": 1422089}
- delete {"lineId": 6973431, "tocEntryId": 1422089}
- delete {"lineId": 6974575, "tocEntryId": 1422114}
- delete {"lineId": 6975158, "tocEntryId": 1422128}
- delete {"lineId": 6975646, "tocEntryId": 1422143}
- delete {"lineId": 6976613, "tocEntryId": 1422166}

### `delete_link` (6 rows)

- delete {"id": 1064034, "sourceBookId": 104, "targetBookId": 5424, "sourceLineId": 35442, "targetLineId": 3045100, "targetLineIndex": 658, "targetBookOrderIndex": 2, "connectionTypeId": 1, "baseProvenance": 2}
- delete {"id": 4273056, "sourceBookId": 109, "targetBookId": 7935, "sourceLineId": 48681, "targetLineId": 6973431, "targetLineIndex": 4419, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- delete {"id": 4407269, "sourceBookId": 105, "targetBookId": 7959, "sourceLineId": 39774, "targetLineId": 7149636, "targetLineIndex": 13460, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- delete {"id": 4417457, "sourceBookId": 106, "targetBookId": 7961, "sourceLineId": 42967, "targetLineId": 7163565, "targetLineIndex": 11665, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- delete {"id": 4419013, "sourceBookId": 106, "targetBookId": 7961, "sourceLineId": 43534, "targetLineId": 7165400, "targetLineIndex": 13500, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- delete {"id": 4446267, "sourceBookId": 104, "targetBookId": 7965, "sourceLineId": 35920, "targetLineId": 7201796, "targetLineIndex": 15417, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}

### `upsert_book` (39 rows)

- update {"id": 124}: **heDesc**: "המסכת עוסקת בעיקר בדיני קרקעות. טעם כפיית מחיצה על השכן היא משום היזק ראיה, וא\"כ גם פרק א' עוסק בהרחקת נזקים" → "המסכת עוסקת בעיקר בדיני קרקעות."
- update {"id": 7932}: **contentHash**: 5572556994854393964 → 6266294136752876545
- update {"id": 7933}: **contentHash**: 6437837168396139873 → -6982410967339037816
- update {"id": 7934}: **contentHash**: -2668566791168590520 → -4223256427368097326
- update {"id": 7935}: **contentHash**: 7157606411789538690 → -5870010993115767765
- update {"id": 7936}: **contentHash**: -8620143239964914286 → -3332457346278721871
- update {"id": 7937}: **contentHash**: 1891990308414188822 → -5119315887276465069
- update {"id": 7938}: **contentHash**: -1036215861395963012 → 1014244194966131331
- update {"id": 7939}: **contentHash**: -1693304590246957387 → 4458437671270138681
- update {"id": 7940}: **contentHash**: 3479372741062813156 → -475748867515615515
- update {"id": 7941}: **contentHash**: 5906563117488012523 → 5823800644367132077
- update {"id": 7942}: **contentHash**: -5067121381488202504 → -8660655616721356426
- update {"id": 7943}: **contentHash**: 5143834532363041756 → -301269531765326460
- update {"id": 7944}: **contentHash**: 2038421138633099874 → 175274034509560929
- update {"id": 7945}: **contentHash**: 7818900928692781443 → 4606084168253036280
- update {"id": 7946}: **contentHash**: 7934792724331434546 → 8978748942944472903
- update {"id": 7947}: **contentHash**: 6024095142834931377 → 5848512152949118313
- update {"id": 7948}: **contentHash**: 3934065709162120223 → -568890729006063134
- update {"id": 7949}: **contentHash**: -2300822873591097583 → 2951319929609590263
- update {"id": 7950}: **contentHash**: 1904861283610082936 → 2542373427600950674
- update {"id": 7951}: **contentHash**: 1204709432261541853 → -6631465467481394246
- update {"id": 7952}: **contentHash**: 6905855199898463517 → 1267656110945666790
- update {"id": 7953}: **contentHash**: -4568596258292753766 → 3183370398088067326
- update {"id": 7954}: **contentHash**: 366395847796607826 → 9057957574566799578
- update {"id": 7955}: **contentHash**: -6384469478050187914 → 4391611126111151484
- update {"id": 7956}: **contentHash**: -1898325927550817297 → -4838928025382278224
- update {"id": 7957}: **contentHash**: 8830772831956469891 → -6323985027906501263
- update {"id": 7958}: **contentHash**: -5605713966215881234 → -520769108449949492
- update {"id": 7959}: **contentHash**: -352029143388298540 → 9137511023670674363
- update {"id": 7960}: **contentHash**: -5383616373192776968 → 5725618529698834248
- update {"id": 7961}: **contentHash**: 7222885646043646405 → 4084678608341459496
- update {"id": 7962}: **contentHash**: -417264148128701402 → 6909109928601771450
- update {"id": 7963}: **contentHash**: 24433523290758337 → 5860417823460347585
- update {"id": 7964}: **contentHash**: 3718049668695662385 → 1140937309099806488
- update {"id": 7965}: **contentHash**: 5253965278851204706 → 7755429122245889852
- update {"id": 7966}: **contentHash**: 3943874651606351177 → -8872667731680891808
- update {"id": 7967}: **contentHash**: 7425056611225834815 → 8438760837971127570
- update {"id": 7968}: **contentHash**: 1531576420855588154 → 7834101266193418231
- update {"id": 7969}: **contentHash**: 668648552206681363 → 3361817104021497764

### `upsert_category` (1 rows)

- update {"id": 1735}: **heShortDesc**: "דרשות ודרושים על סדר המקרא. ובו: ליקוטי חבר בן חיים." → "דרשות ודרושים על סדר המקרא."; **heDesc**: "דרשות ודרושים על סדר המקרא. ובו: ליקוטי חבר בן חיים." → "דרשות ודרושים על סדר המקרא."

### `upsert_line` (321 rows, first 40 shown)

- insert {"id": 7925186, "bookId": 7932, "lineIndex": 1596, "heRef": "חברותא על בבא בתרא 1597", "tocEntryId": null, "charCount": 20}
- insert {"id": 7925187, "bookId": 7932, "lineIndex": 2637, "heRef": "חברותא על בבא בתרא 2638", "tocEntryId": null, "charCount": 21}
- insert {"id": 7925188, "bookId": 7932, "lineIndex": 4629, "heRef": "חברותא על בבא בתרא 4630", "tocEntryId": null, "charCount": 23}
- insert {"id": 7925189, "bookId": 7932, "lineIndex": 5427, "heRef": "חברותא על בבא בתרא 5428", "tocEntryId": null, "charCount": 26}
- insert {"id": 7925190, "bookId": 7932, "lineIndex": 7355, "heRef": "חברותא על בבא בתרא 7356", "tocEntryId": null, "charCount": 28}
- insert {"id": 7925191, "bookId": 7932, "lineIndex": 7997, "heRef": "חברותא על בבא בתרא 7998", "tocEntryId": null, "charCount": 24}
- insert {"id": 7925192, "bookId": 7932, "lineIndex": 8332, "heRef": "חברותא על בבא בתרא 8333", "tocEntryId": null, "charCount": 20}
- insert {"id": 7925193, "bookId": 7932, "lineIndex": 10269, "heRef": "חברותא על בבא בתרא 10270", "tocEntryId": null, "charCount": 22}
- insert {"id": 7925194, "bookId": 7932, "lineIndex": 11641, "heRef": "חברותא על בבא בתרא 11642", "tocEntryId": null, "charCount": 19}
- insert {"id": 7925195, "bookId": 7932, "lineIndex": 12643, "heRef": "חברותא על בבא בתרא 12644", "tocEntryId": null, "charCount": 44}
- insert {"id": 7925196, "bookId": 7933, "lineIndex": 1848, "heRef": "חברותא על בבא מציעא 1849", "tocEntryId": null, "charCount": 24}
- insert {"id": 7925197, "bookId": 7933, "lineIndex": 3391, "heRef": "חברותא על בבא מציעא 3392", "tocEntryId": null, "charCount": 23}
- insert {"id": 7925198, "bookId": 7933, "lineIndex": 4489, "heRef": "חברותא על בבא מציעא 4490", "tocEntryId": null, "charCount": 19}
- insert {"id": 7925199, "bookId": 7933, "lineIndex": 6427, "heRef": "חברותא על בבא מציעא 6428", "tocEntryId": null, "charCount": 17}
- insert {"id": 7925200, "bookId": 7933, "lineIndex": 8031, "heRef": "חברותא על בבא מציעא 8032", "tocEntryId": null, "charCount": 21}
- insert {"id": 7925201, "bookId": 7933, "lineIndex": 8839, "heRef": "חברותא על בבא מציעא 8840", "tocEntryId": null, "charCount": 29}
- insert {"id": 7925202, "bookId": 7933, "lineIndex": 10285, "heRef": "חברותא על בבא מציעא 10286", "tocEntryId": null, "charCount": 29}
- insert {"id": 7925203, "bookId": 7933, "lineIndex": 11303, "heRef": "חברותא על בבא מציעא 11304", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925204, "bookId": 7933, "lineIndex": 12642, "heRef": "חברותא על בבא מציעא 12643", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925205, "bookId": 7933, "lineIndex": 12957, "heRef": "חברותא על בבא מציעא 12958", "tocEntryId": null, "charCount": 50}
- insert {"id": 7925206, "bookId": 7934, "lineIndex": 1355, "heRef": "חברותא על בבא קמא 1356", "tocEntryId": null, "charCount": 23}
- insert {"id": 7925207, "bookId": 7934, "lineIndex": 2427, "heRef": "חברותא על בבא קמא 2428", "tocEntryId": null, "charCount": 22}
- insert {"id": 7925208, "bookId": 7934, "lineIndex": 3456, "heRef": "חברותא על בבא קמא 3457", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925209, "bookId": 7934, "lineIndex": 4451, "heRef": "חברותא על בבא קמא 4452", "tocEntryId": null, "charCount": 33}
- insert {"id": 7925210, "bookId": 7934, "lineIndex": 5428, "heRef": "חברותא על בבא קמא 5429", "tocEntryId": null, "charCount": 29}
- insert {"id": 7925211, "bookId": 7934, "lineIndex": 6111, "heRef": "חברותא על בבא קמא 6112", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925212, "bookId": 7934, "lineIndex": 8077, "heRef": "חברותא על בבא קמא 8078", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925213, "bookId": 7934, "lineIndex": 9212, "heRef": "חברותא על בבא קמא 9213", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925214, "bookId": 7934, "lineIndex": 10770, "heRef": "חברותא על בבא קמא 10771", "tocEntryId": null, "charCount": 23}
- insert {"id": 7925215, "bookId": 7934, "lineIndex": 11692, "heRef": "חברותא על בבא קמא 11693", "tocEntryId": null, "charCount": 46}
- insert {"id": 7925216, "bookId": 7935, "lineIndex": 1568, "heRef": "חברותא על ביצה 1569", "tocEntryId": null, "charCount": 17}
- insert {"id": 7925217, "bookId": 7935, "lineIndex": 2461, "heRef": "חברותא על ביצה 2462", "tocEntryId": null, "charCount": 20}
- insert {"id": 7925218, "bookId": 7935, "lineIndex": 3073, "heRef": "חברותא על ביצה 3074", "tocEntryId": null, "charCount": 21}
- insert {"id": 7925219, "bookId": 7935, "lineIndex": 3816, "heRef": "חברותא על ביצה 3817", "tocEntryId": null, "charCount": 18}
- insert {"id": 7925220, "bookId": 7935, "lineIndex": 4418, "heRef": "חברותא על ביצה 4419", "tocEntryId": null, "charCount": 25}
- insert {"id": 7925221, "bookId": 7935, "lineIndex": 4419, "heRef": "חברותא על ביצה 4420", "tocEntryId": null, "charCount": 19}
- insert {"id": 7925222, "bookId": 7936, "lineIndex": 1142, "heRef": "חברותא על בכורות 1143", "tocEntryId": null, "charCount": 29}
- insert {"id": 7925223, "bookId": 7936, "lineIndex": 1725, "heRef": "חברותא על בכורות 1726", "tocEntryId": null, "charCount": 28}
- insert {"id": 7925224, "bookId": 7936, "lineIndex": 2213, "heRef": "חברותא על בכורות 2214", "tocEntryId": null, "charCount": 23}
- insert {"id": 7925225, "bookId": 7936, "lineIndex": 3180, "heRef": "חברותא על בכורות 3181", "tocEntryId": null, "charCount": 30}

### `upsert_line_content` (321 rows, first 40 shown)

- insert {"id": 7925186, "content": "<center><big><b>הדרן עלך פרק השותפין</b></big></center><br>"}
- insert {"id": 7925187, "content": "<center><big><b>הדרן עלך פרק לא יחפור</b></big></center><br>"}
- insert {"id": 7925188, "content": "<center><big><b>הדרן עלך פרק חזקת הבתים</b></big></center><br>"}
- insert {"id": 7925189, "content": "<center><big><b>הדרן עלך פרק המוכר את הבית</b></big></center><br>"}
- insert {"id": 7925190, "content": "<center><big><b>הדרן עלך פרק המוכר את הספינה</b></big></center><br>"}
- insert {"id": 7925191, "content": "<center><big><b>הדרן עלך פרק המוכר פירות</b></big></center><br>"}
- insert {"id": 7925192, "content": "<center><big><b>הדרן עלך פרק בית כור</b></big></center><br>"}
- insert {"id": 7925193, "content": "<center><big><b>הדרן עלך פרק יש נוחלין</b></big></center><br>"}
- insert {"id": 7925194, "content": "<center><big><b>הדרן עלך פרק מי שמת</b></big></center><br>"}
- insert {"id": 7925195, "content": "<center><big><b>הדרן עלך פרק גט פשוט וסליקא לה מסכת בבא בתרא</b></big></center><br>"}
- insert {"id": 7925196, "content": "<center><big><b>הדרן עלך פרק שנים אוחזין</b></big></center><br>"}
- insert {"id": 7925197, "content": "<center><big><b>הדרן עלך פרק אלו מציאות</b></big></center><br>"}
- insert {"id": 7925198, "content": "<center><big><b>הדרן עלך פרק המפקיד</b></big></center><br>"}
- insert {"id": 7925199, "content": "<center><big><b>הדרן עלך פרק הזהב</b></big></center><br>"}
- insert {"id": 7925200, "content": "<center><big><b>הדרן עלך פרק איזו נשך</b></big></center><br>"}
- insert {"id": 7925201, "content": "<center><big><b>הדרן עלך פרק השוכר את האומנין</b></big></center><br>"}
- insert {"id": 7925202, "content": "<center><big><b>הדרן עלך פרק השוכר את הפועלים</b></big></center><br>"}
- insert {"id": 7925203, "content": "<center><big><b>הדרן עלך פרק השואל</b></big></center><br>"}
- insert {"id": 7925204, "content": "<center><big><b>הדרן הלך פרק המקבל</b></big></center><br>"}
- insert {"id": 7925205, "content": "<center><big><b>הדרן עלך פרק הבית והעליה וסליקא לה מסכת בבא מציעא.</b></big></center><br>"}
- insert {"id": 7925206, "content": "<center><big><b>הדרן עלך פרק ארבעה אבות</b></big></center><br>"}
- insert {"id": 7925207, "content": "<center><big><b>הדרן עלך פרק כיצד הרגל</b></big></center><br>"}
- insert {"id": 7925208, "content": "<center><big><b>הדרן עלך פרק המניח</b></big></center><br>"}
- insert {"id": 7925209, "content": "<center><big><b>הדרן עלך פרק שור שנגח ארבעה וחמשה</b></big></center><br>"}
- insert {"id": 7925210, "content": "<center><big><b>הדרן עלך פרק שור שנגח את הפרה</b></big></center><br>"}
- insert {"id": 7925211, "content": "<center><big><b>הדרן פרק עלך הכונס</b></big></center><br>"}
- insert {"id": 7925212, "content": "<center><big><b>הדרן עלך פרק מרובה</b></big></center><br>"}
- insert {"id": 7925213, "content": "<center><big><b>הדרן עלך פרק החובל</b></big></center><br>"}
- insert {"id": 7925214, "content": "<center><big><b>הדרן עלך פרק הגוזל עצים</b></big></center><br>"}
- insert {"id": 7925215, "content": "<center><big><b>הדרן עלך פרק הגוזל בתרא וסליקא לה מסכת בבא קמא</b></big></center><br>"}
- insert {"id": 7925216, "content": "<center><big><b>הדרן עלך פרק ביצה</b></big></center><br>"}
- insert {"id": 7925217, "content": "<center><big><b>הדרן עלך פרק יום טוב</b></big></center><br>"}
- insert {"id": 7925218, "content": "<center><big><b>הדרן עלך פרק אין צדין</b></big></center><br>"}
- insert {"id": 7925219, "content": "<center><big><b>הדרן עלך פרק המביא</b></big></center><br>"}
- insert {"id": 7925220, "content": "<center><big><b>הדרן עלך פרק משילין פירות</b></big></center>"}
- insert {"id": 7925221, "content": "<center><b><big>וסליקא לן מסכת ביצה</big></b></center><br>"}
- insert {"id": 7925222, "content": "<center><big><b>הדרן עלך פרק הלוקח עובר חמורו</b></big></center><br>"}
- insert {"id": 7925223, "content": "<center><big><b>הדרן עלך פרק הלוקח עובר פרתו</b></big></center><br>"}
- insert {"id": 7925224, "content": "<center><big><b>הדרן עלך פרק הלוקח בהמה</b></big></center><br>"}
- insert {"id": 7925225, "content": "<center><big><b>הדרן עלך פרק כל פסולי המוקדשין</b></big></center><br>"}

### `upsert_line_toc` (321 rows, first 40 shown)

- insert {"lineId": 7925186, "tocEntryId": 1421174}
- insert {"lineId": 7925187, "tocEntryId": 1421196}
- insert {"lineId": 7925188, "tocEntryId": 1421264}
- insert {"lineId": 7925189, "tocEntryId": 1421290}
- insert {"lineId": 7925190, "tocEntryId": 1421329}
- insert {"lineId": 7925191, "tocEntryId": 1421352}
- insert {"lineId": 7925192, "tocEntryId": 1421364}
- insert {"lineId": 7925193, "tocEntryId": 1421428}
- insert {"lineId": 7925194, "tocEntryId": 1421470}
- insert {"lineId": 7925195, "tocEntryId": 1421505}
- insert {"lineId": 7925196, "tocEntryId": 1421547}
- insert {"lineId": 7925197, "tocEntryId": 1421574}
- insert {"lineId": 7925198, "tocEntryId": 1421596}
- insert {"lineId": 7925199, "tocEntryId": 1421631}
- insert {"lineId": 7925200, "tocEntryId": 1421663}
- insert {"lineId": 7925201, "tocEntryId": 1421679}
- insert {"lineId": 7925202, "tocEntryId": 1421702}
- insert {"lineId": 7925203, "tocEntryId": 1421721}
- insert {"lineId": 7925204, "tocEntryId": 1421748}
- insert {"lineId": 7925205, "tocEntryId": 1421756}
- insert {"lineId": 7925206, "tocEntryId": 1421789}
- insert {"lineId": 7925207, "tocEntryId": 1421810}
- insert {"lineId": 7925208, "tocEntryId": 1421830}
- insert {"lineId": 7925209, "tocEntryId": 1421851}
- insert {"lineId": 7925210, "tocEntryId": 1421870}
- insert {"lineId": 7925211, "tocEntryId": 1421886}
- insert {"lineId": 7925212, "tocEntryId": 1421928}
- insert {"lineId": 7925213, "tocEntryId": 1421949}
- insert {"lineId": 7925214, "tocEntryId": 1421986}
- insert {"lineId": 7925215, "tocEntryId": 1422004}
- insert {"lineId": 7925216, "tocEntryId": 1422034}
- insert {"lineId": 7925217, "tocEntryId": 1422052}
- insert {"lineId": 7925218, "tocEntryId": 1422065}
- insert {"lineId": 7925219, "tocEntryId": 1422078}
- insert {"lineId": 7925220, "tocEntryId": 1422089}
- insert {"lineId": 7925221, "tocEntryId": 1422089}
- insert {"lineId": 7925222, "tocEntryId": 1422114}
- insert {"lineId": 7925223, "tocEntryId": 1422128}
- insert {"lineId": 7925224, "tocEntryId": 1422143}
- insert {"lineId": 7925225, "tocEntryId": 1422166}

### `upsert_link` (6 rows)

- insert {"id": 4454494, "sourceBookId": 104, "targetBookId": 5424, "sourceLineId": 35454, "targetLineId": 3045100, "targetLineIndex": 658, "targetBookOrderIndex": 2, "connectionTypeId": 1, "baseProvenance": 2}
- insert {"id": 4454495, "sourceBookId": 109, "targetBookId": 7935, "sourceLineId": 48681, "targetLineId": 7925221, "targetLineIndex": 4419, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- insert {"id": 4454496, "sourceBookId": 105, "targetBookId": 7959, "sourceLineId": 39774, "targetLineId": 7925418, "targetLineIndex": 13460, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- insert {"id": 4454497, "sourceBookId": 106, "targetBookId": 7961, "sourceLineId": 42967, "targetLineId": 7925437, "targetLineIndex": 11665, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- insert {"id": 4454498, "sourceBookId": 106, "targetBookId": 7961, "sourceLineId": 43534, "targetLineId": 7925439, "targetLineIndex": 13500, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}
- insert {"id": 4454499, "sourceBookId": 104, "targetBookId": 7965, "sourceLineId": 35920, "targetLineId": 7925480, "targetLineIndex": 15417, "targetBookOrderIndex": 999, "connectionTypeId": 1, "baseProvenance": 0}

### `upsert_link_coverage` (1 rows)

- insert {"lineId": 35456, "linkId": 4454494, "side": 0}

### `upsert_link_range` (1 rows)

- insert {"linkId": 4454494, "side": 0, "endLineId": 35456, "endLineIndex": 3626}

### `upsert_schema_meta` (1 rows)

- update {"key": "db_version"}: **value**: "1" → "2"

