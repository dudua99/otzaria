import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/data/book_identity.dart';
import 'package:otzaria/data/data_providers/tantivy_data_provider.dart';
import 'package:otzaria/indexing/repository/indexing_repository.dart';
import 'package:otzaria/library/models/library.dart';
import 'package:otzaria/models/book_source.dart';
import 'package:otzaria/models/books.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria_search_engine/otzaria_search_engine.dart';

import '../../support/search_engine_test_init.dart';
import '../../test_helpers/memory_cache_provider.dart';

/// התרחיש מ-issue #5040 על המנוע האמיתי: הוספת ספרים אישיים, הסרתם מהתיקייה
/// (ניקוי היתומים שברענון, בלי איחוד ובלי optimize), והחזרתם — עם מספר
/// הספרים, המסמכים החיים והנפח בדיסק בכל שלב.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'הסרת ספרים אישיים מפנה את נפחם ברקע, והחזרתם אינה מנפחת את האינדקס',
    () async {
      await Settings.init(cacheProvider: MemoryCacheProvider());
      expect(
        await tryInitSearchEngine(),
        isTrue,
        reason: searchEngineSkipReason,
      );
      final root = await Directory.systemTemp.createTemp('orphan-disk-native-');
      final index = await Directory('${root.path}/index').create();
      final engine = await SearchEngine.newInstance(path: index.path);
      addTearDown(() async {
        engine.dispose();
        await root.delete(recursive: true);
      });
      final official = [
        for (var i = 1; i <= 50; i++) TextBook(id: i, title: 'רשמי $i'),
      ];
      final personal = [
        for (var i = 1; i <= 100; i++)
          TextBook(id: i, title: 'אישי $i', source: BookSource.user),
      ];
      final provider = TantivyDataProvider.forTesting(Future.value(engine));
      await provider.engine;
      final repository = IndexingRepository(
        provider,
        indexPdfBooks: () => false,
      );

      Future<void> add(Iterable<Book> books) async {
        await engine.addDocumentsBatch(
          docs: [
            for (final book in books)
              for (var line = 0; line < 300; line++)
                DocumentInput(
                  ordinal: line,
                  title: book.title,
                  reference: 'שורה $line',
                  topics: '/בדיקה',
                  text: List.generate(
                    40,
                    (i) => 'מילה${line}_$i ${book.title}',
                  ).join(' '),
                  segment: BigInt.from(line + 1),
                  isPdf: false,
                  filePath: BookIdentity.indexedFilePath(book),
                ),
          ],
        );
        await engine.commit();
        provider.indexedFilePaths.addAll(
          books.map(BookIdentity.indexedFilePath),
        );
      }

      Future<int> diskBytes() async {
        var bytes = 0;
        await for (final file in index.list(recursive: true)) {
          if (file is! File) continue;
          // המיזוג ברקע יוצר ומוחק קבצים זמניים תוך כדי הסריקה.
          try {
            bytes += await file.length();
          } on FileSystemException {
            continue;
          }
        }
        return bytes;
      }

      Future<int> measure(String step) async {
        final bytes = await diskBytes();
        final counts = await engine.countDocumentsByFilePath();
        final live = counts.values.fold<int>(0, (sum, count) => sum + count);
        debugPrint(
          'ORPHAN_DISK $step: books=${counts.length} liveDocs=$live '
          'bytes=$bytes segments=${await engine.getSegmentCount()}',
        );
        return bytes;
      }

      /// המנוע מאחד ברקע, בלי API להמתנה; מחכים לירידת הנפח עד גבול סביר.
      Future<int> settledBelow(int limit) async {
        final deadline = DateTime.now().add(const Duration(seconds: 20));
        var bytes = await diskBytes();
        while (bytes >= limit && DateTime.now().isBefore(deadline)) {
          await Future<void>.delayed(const Duration(milliseconds: 200));
          bytes = await diskBytes();
        }
        return bytes;
      }

      await add(official);
      await add(personal);
      final full = await measure('added 100 personal');

      final kept = personal.take(40).toList();
      expect(
        await repository.dropOrphanedIndexEntries(
          Library(categories: [])..books.addAll([...official, ...kept]),
          customFolders: [],
          attachedLibraries: [],
          preservedHiddenUserBookKeys: {},
        ),
        60,
      );
      await measure('removed 60 (refresh, right after commit)');
      // החיפוש אינו ממתין לאיחוד: הוא עונה מיד, על המצב החתום.
      final searchClock = Stopwatch()..start();
      expect(
        await engine.count(
          regexTerms: ['אישי'],
          facets: const [],
          slop: 0,
          maxExpansions: 10,
        ),
        40 * 300,
      );
      debugPrint('ORPHAN_DISK search during reclaim: ${searchClock.elapsed}');
      expect(await settledBelow((full * 0.8).round()), lessThan(full * 0.8));
      await measure('removed 60 (after background reclaim)');
      expect(await engine.countDocumentsByFilePath(), hasLength(90));

      await add(personal.skip(40));
      final readded = await measure('re-added 60');
      expect(await engine.countDocumentsByFilePath(), hasLength(150));
      expect(readded, lessThan(full * 1.1));
    },
  );
}
