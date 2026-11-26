// Measurement for #5040b — not committed anywhere. Mirrors the app's paths:
// indexing = addTextBookBytes per book + commit (IndexingRepository._indexTextBook
// / _commitIndex); removal = deleteDocumentsByFilePaths + commit
// (IndexingRepository._deleteIndexedFilePaths, used by dropOrphanedIndexEntries).
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria_search_engine/otzaria_search_engine.dart';

import 'native_library.dart';

const _alphabet = 'אבגדהוזחטיכלמנסעפצקרשת';

List<int> _book(Random rng, int lines, int wordsPerLine) {
  final sb = StringBuffer();
  for (var l = 0; l < lines; l++) {
    for (var w = 0; w < wordsPerLine; w++) {
      final len = 2 + rng.nextInt(6);
      for (var c = 0; c < len; c++) {
        sb.write(_alphabet[rng.nextInt(_alphabet.length)]);
      }
      sb.write(' ');
    }
    sb.write('\n');
  }
  return utf8.encode(sb.toString());
}

int _dirBytes(Directory dir) {
  var total = 0;
  for (final e in dir.listSync(recursive: true)) {
    if (e is File) total += e.lengthSync();
  }
  return total;
}

String _segments(Directory dir) {
  final meta = File('${dir.path}/meta.json');
  if (!meta.existsSync()) return 'no meta';
  final json = jsonDecode(meta.readAsStringSync()) as Map<String, dynamic>;
  final segs = (json['segments'] as List).cast<Map<String, dynamic>>();
  var maxDoc = 0, deleted = 0;
  for (final s in segs) {
    maxDoc += s['max_doc'] as int;
    final d = s['deletes'];
    if (d is Map) deleted += d['num_deleted_docs'] as int;
  }
  final ratio = maxDoc == 0 ? 0 : deleted * 100 / maxDoc;
  return 'segments=${segs.length} max_doc=$maxDoc deleted=$deleted '
      '(${ratio.toStringAsFixed(1)}%)';
}

String _mb(int b) => '${(b / 1048576).toStringAsFixed(2)} MiB';

Future<void> main() async {
  final skip = await initNativeEngine();
  final version = Platform.environment['ENGINE_VERSION'] ?? '?';
  final books = int.parse(Platform.environment['BOOKS'] ?? '200');
  final lines = int.parse(Platform.environment['LINES'] ?? '400');
  final removeShare = double.parse(Platform.environment['REMOVE'] ?? '0.9');

  test('reclaim after removal ($version)', () async {
    final dir = Directory.systemTemp.createTempSync('reclaim_$version');
    final engine = await SearchEngine.newInstance(path: dir.path);
    final rng = Random(5040);
    final texts = [for (var i = 0; i < books; i++) _book(rng, lines, 12)];
    void log(String step) => print(
      '[$version] $step: size=${_mb(_dirBytes(dir))} ${_segments(dir)}',
    );

    // Official library stand-in (kept): 20 books.
    for (var i = 0; i < 20; i++) {
      await engine.addTextBookBytes(
        title: 'base $i',
        topics: '/base',
        filePath: 'id:$i',
        text: texts[i % texts.length],
        textStorage: TextStorage.inIndex,
      );
    }
    await engine.commit();
    log('1. base library indexed');

    for (var i = 0; i < books; i++) {
      await engine.addTextBookBytes(
        title: 'personal $i',
        topics: '/personal',
        filePath: 'uid:$i',
        text: texts[i],
        textStorage: TextStorage.inIndex,
      );
    }
    await engine.commit();
    final indexed = _dirBytes(dir);
    log('2. personal books indexed');

    final removed = (books * removeShare).round();
    await engine.deleteDocumentsByFilePaths(
      filePaths: [for (var i = 0; i < removed; i++) 'uid:$i'],
    );
    await engine.commit();
    log('3. removed $removed books (delete+commit)');

    var waited = 0;
    while (waited < 30) {
      await Future<void>.delayed(const Duration(seconds: 1));
      waited++;
    }
    log('4. after 30s idle (background merge window)');

    // A later small write by the app (e.g. the next refresh) — one more commit.
    await engine.addTextBookBytes(
      title: 'later',
      topics: '/personal',
      filePath: 'uid:later',
      text: texts[books - 1].sublist(0, 2000),
      textStorage: TextStorage.inIndex,
    );
    await engine.commit();
    await Future<void>.delayed(const Duration(seconds: 10));
    log('5. after one more commit + 10s');

    for (var i = 0; i < removed; i++) {
      await engine.addTextBookBytes(
        title: 'personal $i',
        topics: '/personal',
        filePath: 'uid:$i',
        text: texts[i],
        textStorage: TextStorage.inIndex,
      );
    }
    await engine.commit();
    await Future<void>.delayed(const Duration(seconds: 10));
    log('6. re-added $removed books + commit + 10s');
    final readded = _dirBytes(dir);
    print('[$version] growth after re-add vs step 2: '
        '${((readded - indexed) * 100 / indexed).toStringAsFixed(1)}%');

    await engine.optimize();
    log('7. after explicit optimize (reference)');

    await engine.closeIndexWriter();
    engine.dispose();
    dir.deleteSync(recursive: true);
  }, skip: skip, timeout: const Timeout(Duration(minutes: 30)));
}
