/// מחוות שהתוכן שמתחת עדיין בודק אם הן שלו, ולכן ההחלקה בין כרטיסיות
/// ממתינה לתשובה לפני שהיא זוכה בהן.
///
/// WebView בדסקטופ אינו משתתף בזירת המחוות, ותשובת ה-DOM מגיעה באיחור. בלי
/// המתנה כזו ההחלקה הייתה מוכרעת לפני שהתשובה למחווה הנוכחית הגיעה
/// (issue #3640).
class TabSwipeHold {
  final Set<int> _pointers = {};

  void hold(int pointer) => _pointers.add(pointer);

  void release(int pointer) => _pointers.remove(pointer);

  bool holds(int pointer) => _pointers.contains(pointer);
}
