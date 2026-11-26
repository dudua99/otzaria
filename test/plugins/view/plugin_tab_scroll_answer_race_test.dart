import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/plugins/view/plugin_tab_page.dart';
import 'package:otzaria/tabs/bloc/tabs_bloc.dart';
import 'package:otzaria/tabs/bloc/tabs_state.dart';
import 'package:otzaria/tabs/models/tool_tab.dart';
import 'package:otzaria/tabs/view/tab_swipe_detector.dart';

import '../../test_helpers/stub_tabs_bloc.dart';

/// issue #3640: תשובת הדף על גלילה אופקית מגיעה מה-WebView באיחור.
///
/// Flutter מכריע את המחווה כבר בעדכון הראשון, ולכן החלטה לפי התשובה האחרונה
/// שהגיעה (ולא לפי התשובה על המחווה הזו) מעבירה כרטיסייה מעל תוכן גולל או
/// חוסמת מעבר מעל תוכן סטטי. בדף כאן תפריט שנגלל לרוחב בחצי השמאלי ותוכן
/// סטטי בימני; הדף עונה 10 מילישניות אחרי תחילת המחווה, כמו ה-bridge.
/// ההחלקה ממתינה לתשובה על המחווה הזו, כך שאין ערך ישן שאפשר לטעות בו.
void main() {
  const answerDelay = Duration(milliseconds: 10);
  const menu = Offset(300, 400);
  const staticText = Offset(900, 400);
  late PageController controller;
  late List<Offset> webViewPans;
  late int webViewTouchMoves;

  bool scrollsAt(Offset position) => position.dx < 600;

  Future<void> pumpPluginTabs(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    webViewPans = [];
    webViewTouchMoves = 0;
    controller = PageController(initialPage: 1);
    addTearDown(controller.dispose);
    final tabs = [
      for (final id in ['a', 'b', 'c']) ToolTab(toolId: id, title: id),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TabsBloc>.value(
          value: StubTabsBloc(TabsState(tabs: tabs, currentTabIndex: 1)),
          child: TabSwipeDetector(
            controller: controller,
            onActiveChanged: (_) {},
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < 3; i++)
                  buildPluginTabBody(
                    webView: Listener(
                      onPointerPanZoomUpdate: (e) => webViewPans.add(e.pan),
                      onPointerMove: (_) => webViewTouchMoves++,
                      child: const ColoredBox(color: Colors.white),
                    ),
                    loading: false,
                    scrollsHorizontallyAt: (position) => Future.delayed(
                      answerDelay,
                      () => scrollsAt(position),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  // העדכון הראשון חוצה את הסף מיד, לפני שהתשובה הגיעה.
  Future<void> trackpadSwipe(WidgetTester tester, Offset at) async {
    final gesture = await tester.createGesture(
      kind: PointerDeviceKind.trackpad,
    );
    await gesture.panZoomStart(at, timeStamp: Duration.zero);
    for (var i = 1; i <= 8; i++) {
      await gesture.panZoomUpdate(
        at,
        pan: Offset(-30.0 * i, 0),
        timeStamp: Duration(milliseconds: 20 * i),
      );
      await tester.pump(const Duration(milliseconds: 20));
    }
    await gesture.panZoomEnd(timeStamp: const Duration(milliseconds: 180));
    await tester.pumpAndSettle();
  }

  Future<void> touchSwipe(WidgetTester tester, Offset at) async {
    final gesture = await tester.startGesture(
      at,
      kind: PointerDeviceKind.touch,
    );
    for (var i = 1; i <= 8; i++) {
      await gesture.moveBy(
        const Offset(-30, 0),
        timeStamp: Duration(milliseconds: 20 * i),
      );
      await tester.pump(const Duration(milliseconds: 20));
    }
    await gesture.up(timeStamp: const Duration(milliseconds: 180));
    await tester.pumpAndSettle();
  }

  final desktop = TargetPlatformVariant({
    TargetPlatform.windows,
    TargetPlatform.linux,
  });

  testWidgets(
    'trackpad: תשובה ישנה "לא נגלל" אינה מעבירה כרטיסייה מעל תפריט גולל',
    (tester) async {
      await pumpPluginTabs(tester);
      await trackpadSwipe(tester, menu);
      expect(controller.page, 1);
      expect(webViewPans, isNotEmpty);
    },
    variant: desktop,
  );

  testWidgets(
    'מגע: תשובה ישנה "לא נגלל" אינה מעבירה כרטיסייה מעל תפריט גולל',
    (tester) async {
      await pumpPluginTabs(tester);
      await touchSwipe(tester, menu);
      expect(controller.page, 1);
      expect(webViewTouchMoves, greaterThan(0));
    },
    variant: desktop,
  );

  testWidgets(
    'trackpad: תשובה ישנה "נגלל" אינה חוסמת מעבר מעל תוכן סטטי',
    (tester) async {
      await pumpPluginTabs(tester);
      await trackpadSwipe(tester, staticText);
      expect(controller.page, 2);
    },
    variant: desktop,
  );

  testWidgets(
    'מגע: תשובה ישנה "נגלל" אינה חוסמת מעבר מעל תוכן סטטי',
    (tester) async {
      await pumpPluginTabs(tester);
      await touchSwipe(tester, staticText);
      expect(controller.page, 2);
    },
    variant: desktop,
  );

  testWidgets(
    'תשובה על המחווה הקודמת (תפריט) אינה חוסמת את הבאה (תוכן סטטי)',
    (tester) async {
      await pumpPluginTabs(tester);
      await trackpadSwipe(tester, menu);
      expect(controller.page, 1);
      await trackpadSwipe(tester, staticText);
      expect(controller.page, 2);
    },
    variant: desktop,
  );
}
