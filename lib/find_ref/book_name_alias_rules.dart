/// כללי ההשוואה בין שאילתה לשם ספר באיתור מקורות שמעבר לכתיב
/// ([bookNameSpellingForm]): מילות קישור ושמות קיבוציים של סטים.
///
/// הכללים כאן ולא בנתוני הכינויים, ולכן חלים על כל ספר — גם במסד מצורף ובספרייה
/// שלא עודכנה. התאמה מילולית קודמת להתאמה שנגזרה מהם ([ReferenceBookHit.isAliasByRule]).
library;

import 'package:otzaria/find_ref/book_name_match.dart';

/// מילות קישור בשם ספר. הכינויים כוללים אותן לסירוגין ("רשבא על בק" לצד "רשבא ב"ב",
/// "ברטנורא על מסכת פסחים"), ולכן אינן מכריעות בהתאמה (#5599, #5609). הרשימה לפי
/// נתוני הכינויים: השמטת "הלכות", "ספר" או "תלמוד" הייתה מאחדת שמות של ספרים שונים.
const Set<String> bookNameConnectorWords = {'על', 'מסכת', 'מס'};

/// מילת קישור — ראו [bookNameConnectorWords].
bool isBookNameConnector(String word) => bookNameConnectorWords.contains(word);

/// "מסכת" / "מס'" — מילת הקישור שאינה נספרת גם בדירוג מילות הכותרת (#5609). "על"
/// נספרת שם: "רמב"ם על מקואות" הוא הפירוש על המשנה, ולא הלכות מקואות.
bool isTractateWord(String word) => word == 'מסכת' || word == 'מס';

/// [words] בלי מילות הקישור שאחרי המילה הראשונה. בראש השם היא חלק ממנו ("על
/// התורה", "מסכת סופרים"). "על" בסוף נשארת: צירוף שנגמר בה ("אוצרות יוסף על") היה
/// נעשה תחילית של הכינוי ובולע אותה משאר השאילתה.
List<String> withoutBookNameConnectors(List<String> words) => [
  for (var i = 0; i < words.length; i++)
    if (i == 0 ||
        !isBookNameConnector(words[i]) ||
        (i == words.length - 1 && words[i] == 'על'))
      words[i],
];

/// צורת ההשוואה בין שאילתה לכינוי: [bookNameSpellingForm] בלי מילות קישור
/// ([withoutBookNameConnectors]). השמטת מילה שלמה אינה יוצרת ביגרם שלא היה בטקסט.
String bookNameAcronymForm(String text) {
  final t = bookNameSpellingForm(text);
  if (!bookNameConnectorWords.any((w) => t.contains(' $w'))) return t;
  return withoutBookNameConnectors(t.split(' ')).join(' ');
}

/// שמות קיבוציים של סט ספרים, ותחילית הכותרת המשותפת לספריו: "פירוש המשניות
/// ברכות" הוא "רמב"ם על משנה ברכות", גם כשלספר אין כינוי כזה.
const Map<String, String> bookSetCollectiveNames = {
  'פירוש המשניות': 'רמבם על משנה',
  'פרוש המשניות': 'רמבם על משנה',
  'פיהמ': 'רמבם על משנה',
  'פיהמש': 'רמבם על משנה',
};

/// [query] (בצורת [bookNameMatchForm]) כשהוא פותח בשם קיבוצי — עם תחילית הכותרות
/// במקומו, ב-[bookNameAcronymForm]; `null` אם אינו פותח בשם כזה. מילת ייחוס אחרי
/// השם ("פירוש המשניות לרמב"ם") אינה משנה את הסט.
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
    return bookNameAcronymForm(
      rest.isEmpty ? titlePrefix : '$titlePrefix $rest',
    );
  }
  return null;
}
