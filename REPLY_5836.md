תודה, הממצא נכון ושוחזר.

כשהרצועה נבנית לפני מסך התוצאות, `createdResultsBloc` עדיין `null`, ויצירת ה־BLoC לא הודיעה לרצועה — האייקון נשאר עד בנייה מחדש.

התיקון (cd8326f3b): `SemanticSearchTab` חושף `createdResultsBlocListenable`, ו־`SearchTabLeading` מאזין לו בלי ליצור את ה־BLoC מראש. ההודעה נשלחת במיקרו־משימה, כי המסך יוצר את ה־BLoC בזמן בנייה (`initState`), והודעה סינכרונית גרמה ל־"markNeedsBuild called during build" (נבדק).

בדיקה: `test/navigation/search_tab_running_indicator_test.dart` — «כרטיסיית חיפוש חכם: הספינר מופיע כשהמסך יוצר את ה-BLoC, בלי בנייה מחדש» (האייקון נבנה לפני ווידג'ט אח שיוצר את ה־BLoC בבנייה). נכשלת לפני התיקון ועוברת אחריו; 303 בדיקות בקבצים הקשורים עוברות. analyze, format ו־ui_lint נקיים.
