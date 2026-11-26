import 'package:flutter/services.dart';

// ממופה לפי keyId (פרימיטיב) כי LogicalKeyboardKey דורס את == ולא יכול
// לשמש מפתח במפת const.
final Map<int, LogicalKeyboardKey> _numpadNavigationKeys = {
  LogicalKeyboardKey.numpad8.keyId: LogicalKeyboardKey.arrowUp,
  LogicalKeyboardKey.numpad2.keyId: LogicalKeyboardKey.arrowDown,
  LogicalKeyboardKey.numpad4.keyId: LogicalKeyboardKey.arrowLeft,
  LogicalKeyboardKey.numpad6.keyId: LogicalKeyboardKey.arrowRight,
  LogicalKeyboardKey.numpad7.keyId: LogicalKeyboardKey.home,
  LogicalKeyboardKey.numpad1.keyId: LogicalKeyboardKey.end,
  LogicalKeyboardKey.numpad9.keyId: LogicalKeyboardKey.pageUp,
  LogicalKeyboardKey.numpad3.keyId: LogicalKeyboardKey.pageDown,
};

/// המקש הלוגי של [event], כשמקשי לוח הספרות בלי NumLock נחשבים למקשי הניווט
/// שהם מסמנים.
///
/// מנוע Flutter ב-Windows מזהה את מקשי לוח הספרות לפי קוד הסריקה ומדווח
/// numpad8 וכו' גם כש-NumLock כבוי; רק היעדר התו מבדיל ביניהם (issue #5212).
/// Ctrl/Alt/Meta מבטלים גם הם את התו, ולכן צירוף כזה נשאר ספרה (Ctrl+ספרה
/// עובר ללשונית). ל-KeyUp אין תו לעולם, והוא ממופה כדי לסיים את הלחיצה.
LogicalKeyboardKey navigationKeyOf(KeyEvent event) {
  final keyboard = HardwareKeyboard.instance;
  final isDigit =
      event is! KeyUpEvent &&
      (event.character != null ||
          keyboard.isControlPressed ||
          keyboard.isAltPressed ||
          keyboard.isMetaPressed);
  if (isDigit) return event.logicalKey;
  return _numpadNavigationKeys[event.logicalKey.keyId] ?? event.logicalKey;
}
