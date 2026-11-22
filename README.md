# צילומים — issue #4455 (גרסה מתוקנת אחרי סגירת #5692)

תרחיש זהה בכל הצילומים: ספר טקסט נפתח מסימניה בשורה 30; הקורא נפרס רק
2.2 שניות אחרי שהספר נטען (המקרה ששוחזר בסגירת #5692). הצילום נלקח
כ-300ms אחרי שהשורה הופיעה, ב-1400×900 לוגי ×2, גופני האפליקציה האמיתיים
(FontManifest), ערכת נושא AppThemeData בהיר/כהה.

| קובץ | גרסה | highlightedLine ברגע ההופעה |
|---|---|---|
| dev_light.png / dev_dark.png | upstream/dev | null — אין הדגשה בכלל |
| old5692_light.png / old5692_dark.png | ראש #5692 שנסגר | null — הטיימר כבר פג לפני שהשורה הופיעה |
| fix_light.png / fix_dark.png | feat/bookmark-open-highlight-4455-r | 30 — השורה מודגשת בצבע הקיים AppSurfaces.highlightedLineBackground |
