import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/library/bloc/library_bloc.dart';
import 'package:otzaria/library/bloc/library_event.dart';
import 'package:otzaria/library/bloc/library_state.dart';
import 'package:otzaria/library/models/library.dart';
import 'package:otzaria/models/book_source.dart';
import 'package:otzaria/models/books.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria/theme/app_seed_colors.dart';
import 'package:otzaria/theme/app_theme_data.dart';
import 'package:otzaria/tools/shamor_zachor/models/book_model.dart';
import 'package:otzaria/tools/shamor_zachor/models/progress_model.dart';
import 'package:otzaria/tools/shamor_zachor/providers/shamor_zachor_data_provider.dart';
import 'package:otzaria/tools/shamor_zachor/providers/shamor_zachor_progress_provider.dart';
import 'package:otzaria/tools/shamor_zachor/screens/book_detail_screen.dart';
import 'package:otzaria/tools/shamor_zachor/services/progress_service.dart';
import 'package:otzaria/tools/shamor_zachor/widgets/add_books_to_tracking_dialog.dart';
import 'package:provider/provider.dart';

import '../support/golden_fonts.dart';
import '../test_helpers/memory_cache_provider.dart';

class _MockLibraryBloc extends MockBloc<LibraryEvent, LibraryState>
    implements LibraryBloc {}

class _MemoryProgressService extends ProgressService {
  @override
  Future<ProgressMapById> loadProgressDataById() async => {};
  @override
  Future<CompletionDatesByIdMap> loadCompletionDatesById() async => {};
  @override
  Future<Map<int, List<ProgressColumn>>> loadColumnsByBookId() async => {};
  @override
  Future<ColumnCompletionDatesMap> loadColumnCompletionDates() async => {};
}

class _ReadyDataProvider extends ShamorZachorDataProvider {
  final BookDetails book;
  _ReadyDataProvider(this.book);
  @override
  (BookDetails, String, String)? getBookById(int bookId) =>
      book.id == bookId ? (book, 'ספר', 'ספרי PDF') : null;
  @override
  BookDetails? getBookDetails(String categoryName, String bookName) => book;
  @override
  bool get isLoading => false;
}

Category _category(String title) => Category(
  title: title,
  description: '',
  shortDescription: '',
  order: 0,
  subCategories: [],
  books: [],
  parent: null,
);

ThemeData _theme(Brightness b) => b == Brightness.dark
    ? AppThemeData.dark(
        AppThemeData.createColorScheme(AppSeedColors.defaultDark, b),
        compactMenuMode: false,
      )
    : AppThemeData.light(
        AppThemeData.createColorScheme(AppSeedColors.defaultLight, b),
        compactMenuMode: false,
      );

Widget _app(Brightness b, Widget home) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: _theme(b),
  locale: const Locale('he', 'IL'),
  supportedLocales: const [Locale('he', 'IL')],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: home,
);

Future<void> _fonts() async {
  await loadGoldenFonts();
  final roboto = FontLoader('Roboto')
    ..addFont(rootBundle.load('fonts/Rubik-VariableFont_wght.ttf'));
  await roboto.load();
}

void main() {
  setUpAll(() async {
    await Settings.init(cacheProvider: MemoryCacheProvider());
    await _fonts();
  });

  for (final b in Brightness.values) {
    for (final width in [360.0, 900.0]) {
      testWidgets('dialog ${b.name} $width', (tester) async {
        tester.view.physicalSize = Size(width, 700);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final halacha = _category('הלכה');
        halacha.books.addAll([
          TextBook(title: 'ברכות - משנה ברורה', id: 9, category: halacha),
          PdfBook(
            title: 'ברכות - סיכומים',
            id: 3,
            source: BookSource.user,
            category: halacha,
            path: '/home/u/ברכות - סיכומים.pdf',
          ),
          PdfBook(
            title: 'ברכות - היברובוקס',
            externalLibraryId: 'hebrewbooks:1234',
            category: halacha,
            path: '/hb/1234.pdf',
          ),
          PdfBook(
            title: 'ברכות - קובץ',
            category: halacha,
            path: '/lib/ברכות - קובץ.pdf',
          ),
        ]);
        final bloc = _MockLibraryBloc();
        whenListen(
          bloc,
          const Stream<LibraryState>.empty(),
          initialState: LibraryState(library: Library(categories: [halacha])),
        );
        await tester.pumpWidget(
          _app(
            b,
            BlocProvider<LibraryBloc>.value(
              value: bloc,
              child: Builder(
                builder: (context) => Scaffold(
                  body: AddBooksToTrackingDialog(
                    dataProvider: ShamorZachorDataProvider(),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.enterText(find.byType(TextField), 'ברכות');
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('shots/dialog_${b.name}_${width.toInt()}.png'),
        );
      });

      testWidgets('detail ${b.name} $width', (tester) async {
        tester.view.physicalSize = Size(width, 700);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final book = BookDetails(
          id: -1,
          contentType: 'pdf',
          parts: const [BookPart(name: 'ראשי', startPage: 1, endPage: 12)],
        );
        final progress = ShamorZachorProgressProvider(
          progressService: _MemoryProgressService(),
        );
        addTearDown(progress.dispose);
        await progress.ensureLoaded();
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ShamorZachorDataProvider>(
                create: (_) => _ReadyDataProvider(book),
              ),
              ChangeNotifierProvider<ShamorZachorProgressProvider>.value(
                value: progress,
              ),
            ],
            child: _app(
              b,
              Scaffold(
                body: BookDetailScreen(
                  topLevelCategoryKey: 'ספרי PDF',
                  bookName: 'ברכות - סיכומים',
                  bookId: -1,
                  bookDetails: book,
                  onOpenLine: (_) {},
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        addTearDown(gesture.removePointer);
        await gesture.addPointer(location: Offset.zero);
        await gesture.moveTo(tester.getCenter(find.text('ג׳').first));
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('shots/detail_${b.name}_${width.toInt()}.png'),
        );
      });
    }
  }
}
