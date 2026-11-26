# Sweep 26.11 part 5 — issues assigned to other maintainers (bugs only) — results (dev 4fe1973a4)

Classes: FIX-NOW / ALREADY-FIXED (incl. duplicate) / DATA / NEEDS-REPORTER / NEEDS-DECISION / OUTSIDE.
Where a question was already sent and is unanswered, no new question is written; the row gives the close/wait decision instead. Feature requests / design ideas are NEEDS-DECISION even when labelled bug.

| issue | assigned | class | one-line reason | action |
|---|---|---|---|---|
| 6066 | palmoni5 | FIX-NOW | Offline mode blocks plugin UI only; the network gate (plugin_network_gate.dart:23) and background runtime ignore keyOfflineMode, so the store plugin still checks and shows "updates" | queued `6066 bug`, notes/6066.md |
| 6023 | mmichaelush | NEEDS-DECISION | Request to make commentary/links lists and their tool buttons denser like the compact side menu — design request, not broken behavior | options: (א) apply compact density to commentary/links panels (mmichaelush/design), (ב) close as suggestion |
| 5955 | mmichaelush | NEEDS-DECISION | macOS library update failed on SQLite lock during WAL switch; reporter says the next update succeeded by itself, lock holder never identified/reproduced | options: (א) close as resolved by itself, (ב) mmichaelush takes the hardening/diagnostics plan from his analysis as a separate task |
| 5911 | Y-PLONI | DATA | Hover on "לעיל/לקמן" opens Eruvin instead of the same tractate; the app has no own לעיל/לקמן resolution — the target comes from the library's link data | fix the generated links for relative refs (resolve to the current tractate) in SeforimLibrary link generation / Otzaria/otzaria-library links; Y-PLONI to confirm the book |
| 5697 | palmoni5 | NEEDS-DECISION | Itur should treat "ראשון"≈א' or treat a letter as the n-th chapter — matching enhancement, not a broken function | options: (א) add ordinal-word↔letter normalization in itur, (ב) ordinal letter → n-th section regardless of its title, (ג) no |
| 5608 | Nathaniel-260 | NEEDS-DECISION | Zmanim cards: bigger centred digits, bell only on demand — design change (notes/5608.md has the default spec) | Nathaniel-260 decides: implement notes/5608.md default or close |
| 5594 | YMP112 | NEEDS-DECISION | Already in QUEUE; prbody/5594-fix VERDICT = NOT READY: root 11259f78c (relative drag + frozen thumb), every fix breaks one of its tests | palmoni5 decides which requirement of 11259f78c to drop (or Shift fine-drag); not re-queued |
| 5565 | palmoni5 | OUTSIDE/ENV | Android 11 / Mali-G72 black screen after unlock, only full restart helps, no Dart error; palmoni5's triage points to Impeller/Vulkan surface restore (Flutter engine); side bug startDragging on mobile is already fixed (AppDragToMoveArea returns child when !DeviceChrome.hasWindowCaption) | test build with io.flutter.embedding.android.EnableImpeller=false for the reporter (palmoni5); reminder already sent — no new question |
| 5548 | Y-PLONI | DATA | Remaining unlinked citations in book 664 line 296 ("(דף טז.)", "(דף יט.)") and multi-verse refs like "איוב כב א ד ו יב" — the app does not linkify text itself, links come from the library | add these links / multi-verse ref parsing in SeforimLibrary link generation (Otzaria/otzaria-library) |
| 5536 | palmoni5 | NEEDS-DECISION | Sudden close with no crash record; questions sent + reminder (deadline 26.11) unanswered. Side bug from the same report (print screen pop closing the dropdown) is fixed on dev by 31fbce36a/3a38d0c9c (19.11) | close for no answer today (deadline passed) or keep waiting |
| 5245 | palmoni5 | NEEDS-DECISION | Process stayed in background after close; questions sent + reminder (deadline 26.11) unanswered; dev has watchdog/forceTerminate shutdown path; nothing provable | close for no answer today, or keep waiting |
| 5156 | Y-PLONI | NEEDS-DECISION | Word import lost bold in first two paragraphs; importer already resolves rStyle/bCs/basedOn (docx_to_otzaria.dart:300-340); file requested + reminder unanswered — not reproducible without the file | close for no answer today, or keep waiting |
| 5142 | Y-PLONI | DATA | שערי ישר / תקפו כהן sit under הלכה>מערכות; Y-PLONI asked where they should go, no answer | library category decision in Otzaria/otzaria-library (Y-PLONI); no app change |
| 4940 | Rivka-Or | ALREADY-FIXED | Enter navigation + red highlight in links search done in 31dc38d5e (PR #5190, merged 16.11, approved by palmoni5) | close with comment below; the filter-chips-cover-text idea is a separate suggestion |
| 4574 | arieldaniely | NEEDS-DECISION | "לא מצאתי" feedback for smart search — new feature needing a service-side event (palmoni5 16.11, notes/4574.md) | arieldaniely/palmoni5 decide; not queued |
| 4484 | Y-PLONI | DATA | "תרגום" link shows the verse — palmoni5: the link itself points to the verse | link data should target the Targum text (SeforimLibrary/otzaria-library links); Y-PLONI decides if separable |
| 3795 | palmoni5 | OUTSIDE/ENV | Reporter confirmed: reading-mode-plugin set as default reader is white; "קורא רגיל" works; machine's WebView2 composition fails (0x8007139F → HWND mode) | plugin/WebView2 environment; waiting for reporter's answer on other plugins (palmoni5 asked); issue was closed then reporter replied |
| 3384 | Y-PLONI | ALREADY-FIXED | Search-from-selection with footnote marker fixed in PR #4336 (6.11); manual-typed part: question + reminder unanswered (deadline 26.11) | close with comment below |
| 2444 | YMP112 | NEEDS-DECISION | Split view moves section arrows into "⋮" by design; palmoni5 vs Y-PLONI disagreed (title vs arrows), Y-PLONI: "do as you understand" | palmoni5 decides: width-based arrows in split view (Y-PLONI's audit plan) or keep current |
| 2367 | YMP112 | NEEDS-DECISION | Shift+arrow in commentary column: team could not reproduce (works on report version and dev); questions + reminder unanswered | close as not reproducible today, or keep waiting |
| 4326 | palmoni5 | NEEDS-DECISION | Slow page-shape/startup (forum); palmoni5's 7 questions unanswered, no logs | close for no answer, or keep waiting for a report with startup diagnostics |

## Closing comments (Hebrew)
- #4940: "תוקן ב-#5190: Enter בשדה החיפוש עובר לקישור הבא, וההדגשה אדומה כמו בחיפוש בספר. ההצעה לכפתור שמקפל את כפתורי הסינון היא הצעה נפרדת — אפשר לפתוח עליה דיווח חדש."
- #3384: "החיפוש מתוך טקסט מסומן (לחיצה ימנית) כשיש בו מספר הערה תוקן ב-#4336. על החיפוש שהוקלד ידנית לא התקבלה תשובה, ולכן נסגר. אם זה עדיין קורה בגרסה החדשה, נא לשלוח דיווח חדש עם המילים שהוקלדו."

## Queued
6066
