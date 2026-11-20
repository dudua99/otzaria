import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/find_ref/repository/reference_books_cache.dart';

import 'support/seeded_reference_library.dart';

/// כללי הכינויים שבקוד (issue #5599): מילות קישור בשני צדי ההשוואה, הכותרת
/// עצמה ככינוי בלעדיהן, שם קיבוצי של סט, וקדימות להתאמה מילולית. נתוני אמת
/// מ-seforim.db (v38).

const _rambamSukka = (
  id: 521,
  title: 'רמב"ם על משנה סוכה',
  acronyms: ['רמבם משנה סוכה'],
);

const _rambamBerakhot = (
  id: 556,
  title: 'רמב"ם על משנה ברכות',
  acronyms: [
    'פירוש הרמבם למשנה ברכות',
    'רמבם ברכות',
    'רמבם משנה ברכות',
    'רמבם ע"מ ברכות',
    'רמבם על משנה',
  ],
);

const _rambamTaanit = (
  id: 522,
  title: 'רמב"ם על משנה תענית',
  acronyms: [
    'משנה תורה תענית',
    'משנתורה תענית',
    'רמב"ם תענית',
    'רמבם משנה תורה תענית',
  ],
);

const _toseftaYoma = (
  id: 194,
  title: 'תוספתא יומא',
  acronyms: [
    'תוס"א',
    'תוס"א יומא',
    "תוס'",
    "תוס' יומא",
    'תוספתא על יומא',
    "תוספתא על מס' יומא",
    'תוספתא על מסכת יומא',
  ],
);

const _tosafotYoma = (
  id: 1908,
  title: 'תוספות על יומא',
  acronyms: [
    'תוס"י',
    "תוס' יומא",
    "תוס' מסכת יומא",
    "תוס' על יומא",
    'תוסא יומא',
    'תוספות יומא',
    'תוספות על מסכת יומא',
  ],
);

const _mishnehTorahShevuot = (
  id: 329,
  title: 'משנה תורה, הלכות שבועות',
  acronyms: [
    'יד החזקה הלכות שבועות',
    'יד החזקה שבועות',
    'משנה תורה שבועות',
    "רמב\"ם הל' שבועות",
    'רמב"ם הלכות שבועות',
    'רמב"ם שבועות',
  ],
);

const _rambamShevuot = (
  id: 540,
  title: 'רמב"ם על משנה שבועות',
  acronyms: ['רמבם', 'רמבם על שבועות', 'רמבם שבועות'],
);

const _paths = {
  194: 'תוספתא, דפוס וילנא, סדר מועד',
  329: 'הלכה, משנה תורה, ספר הפלאה',
  521: 'משנה, ראשונים, רמב״ם, סדר מועד',
  540: 'משנה, ראשונים, רמב״ם, סדר נזיקין',
  556: 'משנה, ראשונים, רמב״ם, סדר זרעים',
  522: 'משנה, ראשונים, רמב״ם, סדר מועד',
  1908: 'תלמוד בבלי, ראשונים, תוספות, סדר מועד',
};

void main() {
  tearDown(resetSeededLibrary);

  Future<List<String>> titlesFor(String query, List<SeedBook> books) async {
    seedLibrary(books, categoryPaths: _paths);
    return [for (final r in await buildFindRefRepo().findRefs(query)) r.title];
  }

  ReferenceBookHit? hitFor(String query, int bookId) => ReferenceBooksCache
      .instance
      .search(query)
      .where((h) => h.bookId == bookId)
      .firstOrNull;

  group('שם קיבוצי של סט', () {
    for (final query in [
      'פיה"מ סוכה',
      'פירוש המשניות סוכה',
      'פרוש המשניות לרמב"ם סוכה',
    ]) {
      test(
        '"$query" מזהה את "רמב"ם על משנה סוכה", שאין לו כינוי כזה',
        () async {
          final titles = await titlesFor(query, const [
            _rambamBerakhot,
            _rambamSukka,
          ]);

          expect(hitFor(query, _rambamSukka.id)?.matchRank, 3);
          expect(titles.first, _rambamSukka.title);
        },
      );
    }

    test('"פירוש המשניות" לבדו מחזיר את כל ספרי הסט', () {
      seedLibrary(const [_rambamBerakhot, _rambamSukka]);

      for (final book in [_rambamBerakhot, _rambamSukka]) {
        final hit = hitFor('פירוש המשניות', book.id);
        expect(hit?.matchRank, 4, reason: book.title);
        expect(hit!.acronymTailIsTitleWords, isTrue, reason: book.title);
      }
    });
  });

  test('הכותרת בלי מילות קישור היא כינוי מדויק', () async {
    final titles = await titlesFor('רמב"ם משנה תענית', const [
      _rambamBerakhot,
      _rambamTaanit,
    ]);

    expect(hitFor('רמב"ם משנה תענית', _rambamTaanit.id)?.matchRank, 3);
    expect(titles.first, _rambamTaanit.title);
  });

  // שומר: צירוף שנגמר במילת קישור ("אוצרות יוסף על") אינו שם ספר שבולע אותה.
  test('מילת קישור בסוף צירוף אינה מושמטת', () async {
    final titles = await titlesFor('אוצרות יוסף על יורה דעה', const [
      (
        id: 5955,
        title: 'אוצרות יוסף יורה דעה',
        acronyms: ['אוצרות יוסף יו"ד', 'אוצרות יוסף על יורה דעה'],
      ),
    ]);

    expect(titles, ['אוצרות יוסף יורה דעה']);
  });

  group('כינוי מילולי קודם לכינוי שנגזר מהכללים', () {
    test('"תוס מסכת יומא" — תוספות לפני תוספתא ("תוס\' יומא")', () async {
      final titles = await titlesFor('תוס מסכת יומא', const [
        _toseftaYoma,
        _tosafotYoma,
      ]);

      expect(titles.first, _tosafotYoma.title);
      expect(titles, contains(_toseftaYoma.title));
    });

    // שומר: כאן שני הספרים מילוליים ("רמבם על שבועות", "רמב"ם שבועות").
    test('"רמב"ם על שבועות" — פירוש המשנה לפני משנה תורה', () async {
      final titles = await titlesFor('רמב"ם על שבועות', const [
        _mishnehTorahShevuot,
        _rambamShevuot,
      ]);

      expect(titles.first, _rambamShevuot.title);
      expect(titles, contains(_mishnehTorahShevuot.title));
    });
  });
}
