import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/models/books.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria/tabs/bloc/tabs_bloc.dart';
import 'package:otzaria/tabs/bloc/tabs_state.dart';
import 'package:otzaria/tabs/models/pdf_tab.dart';
import 'package:otzaria/tabs/tabs_repository.dart';
import 'package:otzaria/tabs/view/tab_swipe_detector.dart';
import '../helpers/memory_settings_cache.dart';

class _FakeTabsRepository extends TabsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => Settings.init(cacheProvider: MemorySettingsCache()));

  for (final withDetector in [false, true]) {
    testWidgets('גלילה אנכית בלוח מגע עוקבת אחרי האצבעות (detector=$withDetector)', (
      tester,
    ) async {
      final bloc = TabsBloc(repository: _FakeTabsRepository());
      addTearDown(bloc.close);
      bloc.emit(
        TabsState(
          tabs: [
            PdfBookTab(book: PdfBook(title: '0', path: '/tmp/0.pdf'), pageNumber: 1),
          ],
          currentTabIndex: 0,
        ),
      );
      final pages = PageController();
      addTearDown(pages.dispose);
      final scroll = ScrollController();
      addTearDown(scroll.dispose);
      final content = PageView(
        controller: pages,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListView(
            controller: scroll,
            children: [for (var i = 0; i < 100; i++) const SizedBox(height: 50)],
          ),
        ],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: withDetector
                ? TabSwipeDetector(
                    controller: pages,
                    onActiveChanged: (_) {},
                    child: content,
                  )
                : content,
          ),
        ),
      );
      final center = tester.getCenter(find.byType(ListView));
      final gesture = await tester.createGesture(kind: PointerDeviceKind.trackpad);
      await gesture.panZoomStart(center, timeStamp: Duration.zero);
      final offsets = <double>[];
      for (var i = 1; i <= 8; i++) {
        await gesture.panZoomUpdate(
          center,
          pan: Offset(0, -4.0 * i),
          timeStamp: Duration(milliseconds: i * 10),
        );
        await tester.pump(const Duration(milliseconds: 10));
        offsets.add(scroll.offset);
      }
      await gesture.panZoomEnd(timeStamp: const Duration(milliseconds: 90));
      await tester.pumpAndSettle();
      // ignore: avoid_print
      print('detector=$withDetector offsets=$offsets');
      expect(offsets, [for (var i = 1; i <= 8; i++) 4.0 * i]);
    });
  }
}
