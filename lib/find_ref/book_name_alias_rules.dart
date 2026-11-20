/// כללי כינויים שבקוד, ולא בנתוני הכינויים — ולכן חלים על כל ספר, גם במסד
/// מצורף ובספרייה שלא עודכנה (#5599).
///
/// מילות הקישור ("על", "מסכת") — ב-[bookNameAcronymForm] וב-
/// [bookNameTractateAcronymForm]. כאן: הכותרת עצמה ככינוי בצורות אלו, ושמות
/// קיבוציים של סטים.
library;

import 'package:otzaria/find_ref/book_name_match.dart';

/// הכותרת [matchTitle] (ב-[bookNameMatchForm]) בצורות ההשוואה של הכינויים:
/// בלי "על" שבין מילים, ובלי "מסכת" שבאמצע. כך "רמב"ם משנה תענית" מזהה את
/// "רמב"ם על משנה תענית" גם כשאין לו כינוי כזה.
({String relaxed, String tractate}) bookTitleAliasForms(String matchTitle) {
  final relaxed = bookNameAcronymForm(matchTitle);
  return (relaxed: relaxed, tractate: bookNameTractateAcronymForm(relaxed));
}

/// שמות קיבוציים של סט ספרים, ותחילית הכותרת המשותפת לספריו (ב-
/// [bookNameMatchForm]): "פירוש המשניות ברכות" הוא "רמב"ם על משנה ברכות", גם
/// כשלספר אין כינוי כזה.
const Map<String, String> bookSetCollectiveNames = {
  'פירוש המשניות': 'רמבם על משנה',
  'פרוש המשניות': 'רמבם על משנה',
  'פיהמ': 'רמבם על משנה',
  'פיהמש': 'רמבם על משנה',
};

/// [query] (ב-[bookNameMatchForm]) כשהוא פותח בשם קיבוצי — עם תחילית הכותרות
/// במקומו, בצורת `tractate` של [bookTitleAliasForms]; `null` אם אינו פותח בשם
/// כזה. מילת ייחוס אחרי השם ("פירוש המשניות לרמב"ם") אינה משנה את הסט.
String? bookSetTitleQuery(String query) {
  for (final MapEntry(key: name, value: titlePrefix)
      in bookSetCollectiveNames.entries) {
    if (query != name && !query.startsWith('$name ')) continue;
    var rest = query.substring(name.length).trim();
    final author = titlePrefix.split(' ').first;
    for (final attribution in ['ל$author', 'לה$author']) {
      if (rest == attribution || rest.startsWith('$attribution ')) {
        rest = rest.substring(attribution.length).trim();
      }
    }
    return bookTitleAliasForms(
      rest.isEmpty ? titlePrefix : '$titlePrefix $rest',
    ).tractate;
  }
  return null;
}
