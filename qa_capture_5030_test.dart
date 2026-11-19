import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/book_common/utils/link_anchor_markers.dart';
import 'package:otzaria/models/links.dart';
import 'package:otzaria/text_book/models/book_notes.dart';
import 'package:otzaria/text_book/utils/inline_notes_utils.dart';
import 'package:otzaria/widgets/smart_text/render_settings.dart';
import 'package:otzaria/widgets/smart_text/smart_text_widget.dart';

// QA capture for #5030 — not committed.
void main() {
  const stored =
      'וכן אמרו חכמים על פי שנים עדים <sup class="footnote-marker">21</sup> יומת המת';
  // full line: stored visible text with the body at charPos after "21".
  final markerVisEnd = 'וכן אמרו חכמים על פי שנים עדים 21'.length;
  final bookNotes = (BookNotesBuilder()
        ..add(19, 0, '21', 'דברים יז, ה.', charPos: markerVisEnd))
      .build();
  final link = Link(
    heRef: 'דברים יז, ו',
    index1: 20,
    path2: 'דברים',
    index2: 1,
    connectionType: 'LINKER',
    anchorStart: 'וכן אמרו חכמים על '.length,
    anchorEnd: markerVisEnd + 5,
  );
  final html = injectLinkAnchorMarkers(
    rawLine: addInlineNotePreviewLinks(stored, lineIndex: 19, dbNotes: bookNotes),
    anchorLinks: [link],
    styleIndexByCommentator: const {},
    lineIndex: 19,
    notes: bookNotes.notesAt(19),
  );

  testWidgets('capture', (tester) async {
    await tester.runAsync(() async {
      for (final f in ['FrankRuehlCLM-Medium.ttf']) {
        final loader = FontLoader('FrankRuhlCLM')
          ..addFont(File('fonts/$f').readAsBytes().then((b) => ByteData.view(b.buffer)));
        await loader.load();
      }
    });
    final key = GlobalKey();
    tester.view.physicalSize = const Size(900, 360);
    tester.view.devicePixelRatio = 2;
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
                Text(Platform.environment['QA_LABEL'] ?? '',
                    style: const TextStyle(fontFamily: 'FrankRuhlCLM', fontSize: 16, color: Colors.red)),
                SmartTextWidget(
                  text: html,
                  settings: const RenderSettings(fontSize: 28, fontFamily: 'FrankRuhlCLM'),
                  onAnchorTap: (_) {},
                ),
              ]),
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      File(Platform.environment['QA_OUT']!).writeAsBytesSync(data!.buffer.asUint8List());
    });
    // ignore: avoid_print
    print('HTML: $html');
  });
}
