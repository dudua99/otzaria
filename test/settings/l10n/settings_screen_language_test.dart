import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/navigation/bloc/navigation_bloc.dart';
import 'package:otzaria/navigation/bloc/navigation_event.dart';
import 'package:otzaria/navigation/bloc/navigation_state.dart';
import 'package:otzaria/settings/engine/settings_bloc.dart';
import 'package:otzaria/settings/engine/settings_event.dart';
import 'package:otzaria/settings/engine/settings_repository.dart';
import 'package:otzaria/settings/engine/settings_state.dart';
import 'package:otzaria/settings/l10n/settings_l10n_exports.dart';
import 'package:otzaria/settings/view/settings_screen.dart';
import 'package:otzaria/widgets/misc/app_dropdown_field.dart';
import 'package:otzaria/widgets/navigation/sidebar_nav_item.dart';

import '../../test_helpers/memory_cache_provider.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockNavigationBloc extends MockBloc<NavigationEvent, NavigationState>
    implements NavigationBloc {}

class _FakeSettingsRepository extends Fake implements SettingsRepository {
  @override
  bool hasProtectedModePassword() => false;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Settings.init(cacheProvider: MemoryCacheProvider());
  });

  group('MySettingsScreen — שפת ההגדרות', () {
    late MockSettingsBloc settingsBloc;
    late MockNavigationBloc navigationBloc;
    late _FakeSettingsRepository settingsRepository;

    setUp(() {
      settingsBloc = MockSettingsBloc();
      navigationBloc = MockNavigationBloc();
      settingsRepository = _FakeSettingsRepository();
      whenListen(
        navigationBloc,
        const Stream<NavigationState>.empty(),
        initialState: const NavigationState(currentScreen: Screen.settings),
      );
    });

    void givenLanguageCode(String code) {
      whenListen(
        settingsBloc,
        const Stream<SettingsState>.empty(),
        initialState: SettingsState.initial().copyWith(
          settingsLanguageCode: code,
        ),
      );
    }

    /// קובע את שפת המערכת שהמסך יראה במצב "אוטומטי".
    void givenSystemLocale(WidgetTester tester, Locale locale) {
      tester.platformDispatcher.localeTestValue = locale;
      tester.platformDispatcher.localesTestValue = [locale];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    }

    // הספרייה והקורא נשארים RTL, ולכן העץ שמחוץ למסך מדמה את המצב האמיתי.
    Widget buildScreen() => MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: RepositoryProvider<SettingsRepository>.value(
          value: settingsRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SettingsBloc>.value(value: settingsBloc),
              BlocProvider<NavigationBloc>.value(value: navigationBloc),
            ],
            child: const MySettingsScreen(),
          ),
        ),
      ),
    );

    Future<void> pumpScreen(WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1400, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(buildScreen());
      await tester.pump(); // SaferModeGuard postFrame
      await tester.pump();
    }

    // "קיצורי מקשים" מוצג רק בדסקטופ, וברירת המחדל בבדיקות היא Android.
    testWidgets('עברית — לשוניות בעברית והמסך RTL', (tester) async {
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsOneWidget);
      expect(
        find.widgetWithText(SidebarNavItem, 'קיצורי מקשים'),
        findsOneWidget,
      );
      expect(find.text('הגדרות'), findsWidgets);

      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.rtl,
      );
    }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

    testWidgets('אנגלית — לשוניות באנגלית והמסך LTR', (tester) async {
      givenLanguageCode(SettingsLanguage.english.code);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'Appearance'), findsOneWidget);
      expect(
        find.widgetWithText(SidebarNavItem, 'Keyboard Shortcuts'),
        findsOneWidget,
      );
      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsNothing);
      expect(find.text('Settings'), findsWidgets);

      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.ltr,
      );
    }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

    testWidgets('אנגלית — העץ שמחוץ למסך ההגדרות נשאר RTL', (tester) async {
      givenLanguageCode(SettingsLanguage.english.code);
      await pumpScreen(tester);

      // ה-MaterialApp שמעל המסך מייצג את שאר האפליקציה.
      expect(
        Directionality.of(tester.element(find.byType(MySettingsScreen))),
        TextDirection.rtl,
      );
    });

    testWidgets('אנגלית — תוכן לשונית מראה מתורגם', (tester) async {
      givenLanguageCode(SettingsLanguage.english.code);
      await pumpScreen(tester);

      expect(find.text('Settings Language'), findsWidgets);
      expect(find.text('Theme'), findsWidgets);
      expect(find.text('ערכת נושא'), findsNothing);
    });

    testWidgets('יידיש — לשוניות ביידיש והמסך RTL', (tester) async {
      final yi = kSettingsCatalogs[SettingsLanguage.yiddish.code]!;
      givenLanguageCode(SettingsLanguage.yiddish.code);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, yi['מראה']!), findsOneWidget);
      expect(
        find.widgetWithText(SidebarNavItem, yi['קיצורי מקשים']!),
        findsOneWidget,
      );
      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsNothing);
      expect(find.text(yi['הגדרות']!), findsWidgets);

      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.rtl,
      );
    }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

    testWidgets('יידיש — תוכן לשונית מראה מתורגם, בלי נפילה לעברית', (
      tester,
    ) async {
      final yi = kSettingsCatalogs[SettingsLanguage.yiddish.code]!;
      givenLanguageCode(SettingsLanguage.yiddish.code);
      await pumpScreen(tester);

      expect(find.text(yi['שפת ההגדרות']!), findsWidgets);
      expect(find.text(yi['ערכת נושא']!), findsWidgets);
      expect(find.text('ערכת נושא'), findsNothing);

      // טקסט שמוצג כמו המפתח העברי שלו, כשיש לו תרגום שונה, הוא נפילה
      // ל-fallback — מפתח שחסר בקטלוג היידי.
      final translations = yi.values.toSet();
      final untranslated = tester
          .widgetList<Text>(find.byType(Text))
          .map((text) => text.data)
          .whereType<String>()
          .where(
            (data) =>
                yi.containsKey(data) &&
                yi[data] != data &&
                !translations.contains(data),
          )
          .toSet();
      expect(untranslated, isEmpty);
    });

    testWidgets('הבורר סגור מציג את השפה הנבחרת בלבד', (tester) async {
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      expect(find.byType(AppDropdownField<String>), findsOneWidget);
      expect(find.text('עברית'), findsOneWidget);
      // האפשרויות האחרות מוסתרות עד לפתיחת התפריט.
      expect(find.text('English'), findsNothing);
    });

    testWidgets('פתיחת הבורר מציגה אוטומטי וכל שפה נתמכת בשמה שלה', (
      tester,
    ) async {
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      await tester.tap(find.byType(AppDropdownField<String>));
      await tester.pumpAndSettle();

      for (final language in SettingsLanguage.values) {
        expect(
          find.text(language.label),
          findsWidgets,
          reason: 'השפה ${language.code} חסרה בתפריט',
        );
      }
      expect(find.text('אוטומטי'), findsWidgets);
    });

    testWidgets('בחירה בתפריט משדרת את קוד השפה שנבחר', (tester) async {
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      await tester.tap(find.byType(AppDropdownField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('English').last);
      await tester.pumpAndSettle();

      verify(
        () => settingsBloc.add(
          UpdateSettingsLanguageCode(SettingsLanguage.english.code),
        ),
      ).called(1);
    });

    testWidgets('בחירת יידיש בתפריט משדרת את קוד השפה', (tester) async {
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      await tester.tap(find.byType(AppDropdownField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text(SettingsLanguage.yiddish.label).last);
      await tester.pumpAndSettle();

      verify(
        () => settingsBloc.add(
          UpdateSettingsLanguageCode(SettingsLanguage.yiddish.code),
        ),
      ).called(1);
    });

    testWidgets('אוטומטי — מערכת בעברית מציגה הגדרות בעברית ו-RTL', (
      tester,
    ) async {
      givenSystemLocale(tester, const Locale('he', 'IL'));
      givenLanguageCode(kSettingsLanguageSystemCode);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.rtl,
      );
    });

    testWidgets('אוטומטי — מערכת באנגלית מציגה הגדרות באנגלית ו-LTR', (
      tester,
    ) async {
      givenSystemLocale(tester, const Locale('en', 'US'));
      givenLanguageCode(kSettingsLanguageSystemCode);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'Appearance'), findsOneWidget);
      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsNothing);
      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.ltr,
      );
    });

    testWidgets('אוטומטי — מערכת ביידיש מציגה הגדרות ביידיש ו-RTL', (
      tester,
    ) async {
      final yi = kSettingsCatalogs[SettingsLanguage.yiddish.code]!;
      givenSystemLocale(tester, const Locale('yi'));
      givenLanguageCode(kSettingsLanguageSystemCode);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, yi['מראה']!), findsOneWidget);
      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsNothing);
      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.rtl,
      );
    });

    testWidgets('אוטומטי — שפת מערכת שאינה עברית נופלת לאנגלית', (
      tester,
    ) async {
      givenSystemLocale(tester, const Locale('fr', 'FR'));
      givenLanguageCode(kSettingsLanguageSystemCode);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'Appearance'), findsOneWidget);
    });

    testWidgets('בחירה מפורשת גוברת על שפת המערכת', (tester) async {
      givenSystemLocale(tester, const Locale('en', 'US'));
      givenLanguageCode(SettingsLanguage.hebrew.code);
      await pumpScreen(tester);

      expect(find.widgetWithText(SidebarNavItem, 'מראה'), findsOneWidget);
      expect(
        Directionality.of(tester.element(find.byType(SidebarNavItem).first)),
        TextDirection.rtl,
      );
    });
  });
}
