NOT READY
לא הוכח שורש לדיווח כולו; נמצא פגם אמיתי וחלקי שתיקונו דורש החלטת מתחזקים (אזור #3640/#3048).
ממצא שנבדק (upstream/dev 9f5de64aa): בגלילה אנכית בלוח מגע בתוך TabSwipeDetector, ~20px הראשונים של כל מחווה נבלעים.
בדיקה (evidence_tab_swipe_vertical_scroll_test.dart כאן, לא נדחפה לענף): PanZoom אנכי בצעדים של 4px על ListView —
  בלי הגלאי: [4,8,12,16,20,24,28,32]; עם TabSwipeDetector: [0,0,0,0,0,4,8,12] (כלומר נתקע ואז זז; 20px אבודים בכל מחווה).
מסלול הקוד: lib/tabs/view/tab_swipe_detector.dart (RawGestureDetector סביב תוכן הטאב) —
  TrackpadTabSwipeRecognizer (lib/tabs/utils/trackpad_tab_swipe_recognizer.dart, אופקי) ו-TabContentVerticalDragRecognizer
  (lib/tabs/utils/tab_content_vertical_drag_recognizer.dart, "בולען" אנכי, 19a966255) נכנסים לזירה עם ה-VerticalDrag של ה-Scrollable.
  עם כמה חברים בזירה אף אחד לא זוכה עד kTouchSlop (18px, computeHitSlop ל-trackpad), וה-Scrollable (DragStartBehavior.start)
  לא מקבל את הדלתא שלפני הזכייה. בלי הגלאי ה-Scrollable חבר יחיד וזוכה מיד. קיים מאז 52c60c068 (10.6, החלקה בין טאבים) — לפני 0.9.98.
למה זה לא מוכיח את הדיווח: (1) המדווח כותב שזה קורה גם בתוספים — ה-WebView מקבל גלילה דרך Listener מחוץ לזירה (19a966255),
  ולכן הנתיב הזה לא אמור לתקוע שם; (2) המדווח סתר את עצמו ("רק עם עכבר, ואין לי עכבר"); עכבר (SmoothWheelScroll) לא עובר בזירה;
  (3) לא נמצא מנגנון של "קפיצה" מאוחרת — הדלתא נבלעת ולא נדחית. ייתכן שהתקיעה בכל מקום (כולל תוספים) סביבתית/עומס.
לא הצלחתי לקרוא את האבחנה של Y-PLONI מ-3.11 (גישה ל-API/דף של Otzaria/otzaria חסומה בסשן) — כדאי להשוות אליה.
אפשרויות תיקון (החלטת מתחזקים, נוגע במנגנון החלקת הטאבים):
  א. TrackpadTabSwipeRecognizer נדחה בעדכון הראשון כש-|dy|>|dx|, והבולען האנכי לא מצטרף לזירה ב-trackpad כשהתוכן אינו WebView —
     ה-Scrollable נשאר לבד וזוכה מיד (הבדיקה למעלה תעבור);
  ב. להשאיר כמו שזה (התנהגות Flutter רגילה של PageView מקונן) ולסגור את הדיווח כסביבתי.
לא נדחף ענף קוד. claim: claim/fix-3975.
