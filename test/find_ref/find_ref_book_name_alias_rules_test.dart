import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/find_ref/repository/reference_books_cache.dart';

import 'support/seeded_reference_library.dart';

/// כללי הכינויים שבקוד (issue #5599): הכותרת עצמה ככינוי בלי מילות קישור, ושם
/// קיבוצי של סט. נתוני אמת מ-seforim.db (v38).

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

const _paths = {
  194: 'תוספתא, דפוס וילנא, סדר מועד',
  521: 'משנה, ראשונים, רמב״ם, סדר מועד',
  556: 'משנה, ראשונים, רמב״ם, סדר זרעים',
  522: 'משנה, ראשונים, רמב״ם, סדר מועד',
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

  test('מילת קישור בשאילתה בלבד: "תוספתא על יומא" היא "תוספתא יומא"', () async {
    final titles = await titlesFor('תוספתא על יומא', const [
      (id: 194, title: 'תוספתא יומא', acronyms: <String>[]),
    ]);

    expect(hitFor('תוספתא על יומא', 194)?.matchRank, 3);
    expect(titles, ['תוספתא יומא']);
  });

  test('"מסכת" שבאמצע מושמטת גם מול הכותרת', () {
    seedLibrary(const [_rambamBerakhot, _rambamTaanit]);

    expect(hitFor('רמב"ם משנה מסכת תענית', _rambamTaanit.id)?.matchRank, 3);
    expect(hitFor('רמב"ם משנה מסכת תענית', _rambamBerakhot.id), isNull);
  });

  // שומר: כינוי מילולי של ספר אחד קודם לכותרת שהותאמה בכללים של ספר אחר.
  test('כינוי מילולי קודם לכותרת בלי מילות קישור', () async {
    final titles = await titlesFor('רמב"ם משנה תענית', const [
      _rambamTaanit,
      (id: 900, title: 'משנה תענית', acronyms: ['רמבם משנה תענית']),
    ]);

    expect(titles.first, 'משנה תענית');
  });
}
