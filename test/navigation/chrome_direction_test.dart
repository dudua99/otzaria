import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/settings/l10n/settings_l10n_exports.dart';
import 'package:otzaria/widgets/layout/context_overlay_panel.dart';
import 'package:otzaria/widgets/layout/floating_panel.dart';

/// עוטף [child] בסביבה RTL כמו האפליקציה, עם שפת ממשק [language].
Widget _app(SettingsLanguage language, Widget child) => MaterialApp(
  home: Directionality(
    textDirection: TextDirection.rtl,
    child: SettingsTextScope(
      language: language,
      child: Scaffold(body: child),
    ),
  ),
);

TextDirection _directionAt(WidgetTester tester, Key key) =>
    Directionality.of(tester.element(find.byKey(key)));

void main() {
  group('כיווניות כרום התוכנה', () {
    const probe = Key('probe');

    testWidgets('שפה RTL — הכרום נשאר RTL', (tester) async {
      await tester.pumpWidget(
        _app(
          SettingsLanguage.hebrew,
          const ChromeDirectionality(child: SizedBox(key: probe)),
        ),
      );
      expect(_directionAt(tester, probe), TextDirection.rtl);
    });

    testWidgets('יידיש (RTL) — הכרום נשאר RTL', (tester) async {
      await tester.pumpWidget(
        _app(
          SettingsLanguage.yiddish,
          const ChromeDirectionality(child: SizedBox(key: probe)),
        ),
      );
      expect(_directionAt(tester, probe), TextDirection.rtl);
    });

    testWidgets('שפה LTR — הכרום עובר ל-LTR', (tester) async {
      await tester.pumpWidget(
        _app(
          SettingsLanguage.english,
          const ChromeDirectionality(child: SizedBox(key: probe)),
        ),
      );
      expect(_directionAt(tester, probe), TextDirection.ltr);
    });

    testWidgets('ללא scope — RTL, כך שאר האפליקציה אינה משתנה', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: ChromeDirectionality(child: SizedBox(key: probe)),
          ),
        ),
      );
      expect(_directionAt(tester, probe), TextDirection.rtl);
    });

    testWidgets('תוכן המסכים נשאר RTL בתוך כרום LTR', (tester) async {
      await tester.pumpWidget(
        _app(
          SettingsLanguage.english,
          const ChromeDirectionality(
            child: ContentDirectionality(child: SizedBox(key: probe)),
          ),
        ),
      );
      expect(_directionAt(tester, probe), TextDirection.rtl);
    });
  });

  group('ContextOverlayPanel — הצד הפיזי לפי הכיווניות', () {
    Future<double> panelLeft(
      WidgetTester tester,
      TextDirection direction,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: direction,
            child: Scaffold(
              body: Stack(
                children: [
                  const SizedBox.expand(),
                  ContextOverlayPanel(
                    isOpen: true,
                    onClose: () {},
                    alignment: AlignmentDirectional.centerStart,
                    width: 200,
                    child: const Text('תוכן'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return tester.getTopLeft(find.byType(FloatingPanel)).dx;
    }

    testWidgets('centerStart ב-RTL — הפאנל בצד ימין', (tester) async {
      final left = await panelLeft(tester, TextDirection.rtl);
      final screenWidth =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;
      expect(left, greaterThan(screenWidth / 2));
    });

    testWidgets('centerStart ב-LTR — הפאנל בצד שמאל', (tester) async {
      final left = await panelLeft(tester, TextDirection.ltr);
      final screenWidth =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;
      expect(left, lessThan(screenWidth / 2));
    });
  });
}
