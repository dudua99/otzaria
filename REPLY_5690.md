תודה, הממצא נכון ושוחזר.

**מה נמצא:** ‏`_returnToReading` שלח תמיד `NavigateToScreen(Screen.reading)`, גם כשהחלונית הפעילה היא `SearchingTab`. ‏`NavigationBloc` מיישר את הסרגל רק כשהחלונית הפעילה משתנה, ולכן הסרגל נשאר על ״עיון״.

**מה השתנה (15594df89):** המסך נבחר לפי `TabsState.activePane`, כמו ב־`SyncScreenWithActivePane`: לחלונית חיפוש נשלח `Screen.search`, ולכל חלונית אחרת `Screen.reading`. אותו מסלול משמש גם את Esc.

**בדיקות:** ״החלונית הפעילה היא חיפוש: חוזרים למסך החיפוש״ ב־`library_multi_select_open_test.dart` (‏5da0f6acc). על ראש הענף היא נכשלה כי נשלח `NavigateToScreen(Screen.reading)`.
`flutter test test/library test/perf/design_system_hot_paths_perf_test.dart`: ‏680 עברו, 1 דולגה. ‏analyze, format ו־ui_lint נקיים.
