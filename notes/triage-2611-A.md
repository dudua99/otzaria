# Triage 26.11 A — classification (upstream/dev @ 4fe1973a4)

No issue in this batch was queued: every item is data, suggestion, duplicate, already fixed on dev, or needs reporter info.

| Issue | Class | Why | Fixing commit / question |
|---|---|---|---|
| 5950 | skip: library data | book title rename (מהר"ם לובלין), forwarded to Y-PLONI | — |
| 5951 | already fixed | search in commentary panel did not count Word footnotes = #5715 | #5720 (merge 6ab714600; a94474b1a, ba21aac7d) |
| 5969 | skip: handled / needs retest | overlaps #5757/#5833 (dudua99); retest on build with #5833 or a minimal example was requested | question already posted on the issue |
| 5983 | skip: suggestion (download) | HebrewBooks download blocking UI; no maintainer approval | — |
| 5987 | skip: library data | chapter boundary in ירמיהו (last verse of prev chapter) | — |
| 5989 | needs reporter info | partly verified: `lib/personal_notes/widgets/commentary_notes_section.dart:97-110` ListTile Text not selectable; expanded/hover views already use PersonalNoteContentView with selection fixes. Which path fails is unknown | question already posted (dudua99): באילו משלושת המקומות ההעתקה נכשלת — התקציר ברשימת "הערות על המפרשים המוצגים", הערה מורחבת או חלונית ריחוף — והאם הכשל בבחירה או רק ב-Ctrl+C? |
| 5990 | skip: rejected | Y-PLONI: "חסר תועלת למשתמשים הרגילים" | — |
| 5991 | skip: data / needs decision | palmoni5: maybe the acronym is missing in the DB | — |
| 5993 | skip: duplicate | mmichaelush: duplicate of #5203 (biographies ↔ books; #5768 merged c8352d539) | — |
| 5996 | skip: plugin / needs info | blank window of the עיון ההלכה plugin; plugin-side or WebView, no details | שאלה: באיזו גרסה של התוכנה ושל התוסף זה קורה, והאם החלונית נשארת ריקה גם אחרי סגירה ופתיחה מחדש של התוכנה? |
| 5999 | skip: needs maintainer look at report | white window follow-up to #5468; app report now carries window diagnostics (#5475, 38980432c) — read them in the admin report | — |
| 6000 | skip: needs decision | Y-PLONI undecided ("הפופאפ יכול להפריע") | — |
| 6001 | needs reporter info | shortcut opened from a plugin already returns native focus to Flutter (#3759, 24b898b80, in 0.9.98.3); other entry paths unknown | שאלה: באיזה תוסף הקלדת, ואיך פתחת את חלון האיתור — בקיצור מקשים (איזה?) או בלחיצה על כפתור? ובאיזו גרסה של התוכנה? |
| 6002 | skip: suggestion | commentators in generational order; no maintainer approval | — |
| 6005 | skip: library data | missing part in שו"ת מהריט | — |
| 6006 | skip: library data | missing text in שיטה מקובצת כתובות | — |
| 6007 | skip: library data | missing sections in שקל הקודש | — |
| 6009 | needs reporter info | too vague; commentators-tab navigation shortcuts were fixed in #5859 (de80e652d, cd0a2e0dd, 23.11) — maybe already covered | שאלה: איך ניסית לעבור לעמוד הבא בכרטיסיית המפרשים — Page Down, גלגלת, חיצים או כפתור בסרגל? ובאיזו גרסה של התוכנה? |
| 6010 | skip: install/download | library download error outside app code | — |
| 6011 | skip: suggestion | palmoni5: probably discussed/done | — |
| 6012 | skip: library data | palmoni5: data from Sefaria | — |
| 6013 | already fixed | single-letter shortcut (א → search in book) fired while typing in the commentary search field: `_handleGlobalKeyEvent` in text_book_screen had no typing guard; now `lib/text_book/view/text_book_screen.dart:2714` returns early on `shouldIgnoreWhileEditing` | #6018 (9622c2bc1, 25.11) |
| 6014 | skip: suggestion / reply | answer to #3234 ("lately it did not happen") + "sync all" suggestion | — |
