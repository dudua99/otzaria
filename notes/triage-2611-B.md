# Triage 26.11 B — classification (checked against upstream/dev 4fe1973a4)

| Issue | Class | Why / fixing commit / question |
|---|---|---|
| 6016 | skip — asked someone else | Donation phone exists (offline only); Y-PLONI asked @Rivka-Or to improve the display — not approved for workers |
| 6019 | skip — suggestion, needs decision | Expand side tabs on hover; palmoni5 only pointed to precedent #5737, no approval |
| 6020 | skip — suggestion / library data | History shows paragraph number instead of heading in שיטות קמאי/חזו"א — depends on the books' TOC headings; suggestion label, no approval |
| 6022 | **bug → queued** | Arrow next/prev section starts from `tab.index` (top line) not the selected section; regression 9c79c5f14. notes/6022.md |
| 6024 | **bug → queued** | Export dialog: "בחר פורמט לייצוא" above the holy-names card instead of next to the buttons (text_book_export_dialog.dart:49). notes/6024.md |
| 6026 | skip — already fixed | palmoni5 "probably handled"; d01ec41a6 (15.11) "גיבוי: תוסף גדול מדי אינו כשל, ומדווח בהודעה אחת בגיבוי ידני" |
| 6027 | skip — suggestion | Parasha name in search results; forum suggestion, no approval |
| 6029 | skip — rejected | Y-PLONI: already so (commentators / linker / links) |
| 6030 | skip — rejected / data | palmoni5 unsure ("not really his commentator"); links between books = data |
| 6031 | skip — question/suggestion | Where semantic files live: next to seforim.db (semantic_paths.dart); old model folders are deleted since de409bea8 |
| 6033 | skip — by design | Reader toolbar "hide markers" is per tab/book ("השינויים חלים על כרטיסייה זו בלבד", text_display_bar_button.dart:436); global default is in settings |
| 6043 | skip — suggestion | Separate width for page-shape view; no approval |
| 6045 | skip — outside app code | `.seforim-update-temp` is not created anywhere in the app repo (git grep on dev) — offline updater |
| 6046 | skip — already fixed | de409bea8 (01.11) "חיפוש חכם: מחיקת תיקיית המודל הקודם (meivin-round2-onnx) אחרי התקנת המודל הנוכחי" (kLegacySemanticModelFolderNames) |
| 6047 | skip — needs decision | palmoni5 asked Y-PLONI (maybe per book) |
| 6048 | **bug → queued (reproduce first)** | Shift+Down after a one-line mouse selection drops the selection. notes/6048.md |
| 6049 | skip — library data | Missing part of a passage in חידושי הרמב"ן שבת; palmoni5 forwarded to Y-PLONI |
| 6050 | skip — already fixed | palmoni5 "fixed for next version"; 51b551012 (15.11) "מפרשים: רווח קטן בין דיבורים בלי כותרת ובלי כותרת חוזרת (#4963, #4616)" |
| 6062 | **bug → queued** | Android: tools panel requestFocus opens the keyboard (24ddea5be); precedent c222d5ac7. notes/6062.md |
| 6066 | skip — outside app code | App's plugin update check already respects offline mode (plugin_update_check_service.dart:52-59, chip only); the "window" comes from the plugin store plugin, as the reporter concluded |
| 6067 | skip — suggestion / data | Tur↔Shulchan Aruch right-click jump; links data, no approval |
| 6069 | needs reporter info | Question: "באיזה ספר ובאיזה פסוק זה קורה, והאם מדובר בהערות אישיות שהוספת או בהערות של הספר? מה מוצג בריחוף, ומה היית מצפה לראות?" |
