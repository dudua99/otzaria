import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Future<void> _loadFonts() async {
  final manifest = json.decode(
    await rootBundle.loadString('FontManifest.json'),
  ) as List<dynamic>;
  for (final f in manifest) {
    final loader = FontLoader(f['family'] as String);
    for (final a in f['fonts'] as List<dynamic>) {
      loader.addFont(rootBundle.load(a['asset'] as String));
    }
    await loader.load();
  }
}

void main() {
  final outDir = Platform.environment['SHOT_OUT']!;
  setUpAll(() async {
    await Settings.init(cacheProvider: MemoryCacheProvider());
    await _loadFonts();
  });
  for (final dark in [false, true]) {
    for (final width in [360.0, 800.0]) {
      testWidgets('shot ${dark ? 'dark' : 'light'}_${width.toInt()}', (
        tester,
      ) async {
        LibraryProviderManager.instance.resetForTesting();
        LibraryProviderManager.instance.seedMappingsForTesting(
          mapping: {
            BookCompositeKey.create(
              title: 'מפרש בדיקה',
              categoryId: 1,
              fileType: 'txt',
            ): FakeCommentaryLibraryProvider(),
          },
          providers: [FakeCommentaryLibraryProvider()],
        );
        final settingsBloc = _TestSettingsBloc(SettingsState.initial());
        addTearDown(() async => settingsBloc.close());
        tester.view.physicalSize = Size(width, 420);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final bloc = StubTextBookBloc(
          _loadedState(
            links: [
              _link(heRef: 'מפרש בדיקה ו, ה', index1: 1, index2: 3),
              _link(heRef: 'מפרש בדיקה ו, ח', index1: 2, index2: 4),
            ],
            content: const ['שורה א', 'שורה ב'],
            visibleIndices: const [0, 1],
          ),
        );
        addTearDown(() async => bloc.close());
        final key = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: dark ? Brightness.dark : Brightness.light,
              ),
              home: Directionality(
                textDirection: TextDirection.rtl,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<TextBookBloc>.value(value: bloc),
                    BlocProvider<SettingsBloc>.value(value: settingsBloc),
                  ],
                  child: Scaffold(
                    body: CommentaryListBase(
                      openBookCallback: (_) {},
                      fontSize: 18,
                      showSearch: true,
                      shrinkWrap: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final texts = tester
            .widgetList<Text>(find.byType(Text))
            .map((t) => t.data)
            .whereType<String>()
            .toList();
        final name = '${dark ? 'dark' : 'light'}_${width.toInt()}';
        // ignore: avoid_print
        print('TEXTS $name: ${texts.join(' | ')}');
        for (final t in ['מפרש בדיקה', 'ו, ה', 'ו, ח', 'מפרש בדיקה ו, ה']) {
          final f = find.text(t);
          if (f.evaluate().isNotEmpty) {
            // ignore: avoid_print
            print('RECT $name "$t": ${tester.getRect(f.first)}');
          }
        }
        await tester.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          File('$outDir/$name.png')
            ..createSync(recursive: true)
            ..writeAsBytesSync(bytes!.buffer.asUint8List());
        });
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 20));
      });
    }
  }
}
