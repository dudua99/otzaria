import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/navigation/bloc/navigation_bloc.dart';
import 'package:otzaria/navigation/bloc/navigation_state.dart';
import 'package:otzaria/navigation/navigation_repository.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria/settings/engine/settings_bloc.dart';
import 'package:otzaria/settings/engine/settings_event.dart';
import 'package:otzaria/settings/engine/settings_repository.dart';
import 'package:otzaria/tabs/models/tab.dart' show OpenedTab;
import 'package:otzaria/tabs/tabs_repository.dart';

import '../helpers/memory_settings_cache.dart';

/// issue #5853: סגירת התוכנה בתוך ספר פותחת אותו ספר בהפעלה הבאה, ואין
/// אפשרות להתחיל ממסך הבית. ההגדרה "התחל במסך הבית" קובעת שהמסך
/// הראשון הוא הספרייה גם כשיש כרטיסיות שמורות — הכרטיסיות עצמן נשמרות
/// (TabsBloc טוען אותן כרגיל), והספר האחרון נשאר במרחק לחיצה.

class _DummyTab extends OpenedTab {
  _DummyTab() : super('ספר');

  @override
  OpenedTab clone() => this;

  @override
  Map<String, dynamic> toJson() => {'title': title};
}

class _FakeNavigationRepository implements NavigationRepository {
  @override
  Future<bool> checkLibraryIsEmpty() async => false;

  @override
  Future<void> refreshLibrary() async {}
}

class _FakeTabsRepository implements TabsRepository {
  _FakeTabsRepository({required this.hasTabs});

  final bool hasTabs;

  @override
  List<OpenedTab> loadTabs({bool newRuntime = false}) =>
      hasTabs ? [_DummyTab()] : [];

  @override
  Future<void> flushPendingWrites() async {}

  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

/// הפעלה "מחדש": NavigationBloc נבנה מחדש מול הכרטיסיות השמורות, עם ההגדרה
/// כפי שהספק של החלון (window_scope_providers) קורא אותה.
NavigationBloc _launch({required bool hasTabs}) {
  final bloc = NavigationBloc(
    repository: _FakeNavigationRepository(),
    tabsRepository: _FakeTabsRepository(hasTabs: hasTabs),
    startOnHomeScreen:
        Settings.getValue<bool>(SettingsRepository.keyStartOnHomeScreen) ??
        false,
  );
  addTearDown(bloc.close);
  return bloc;
}

void main() {
  setUp(() async {
    await Settings.init(cacheProvider: MemorySettingsCache());
  });

  group('הפעלה עם כרטיסיות שמורות', () {
    test('ההגדרה דלוקה: המסך הראשון הוא מסך הבית (הספרייה)', () async {
      await Settings.setValue<bool>(
        SettingsRepository.keyStartOnHomeScreen,
        true,
      );
      expect(_launch(hasTabs: true).state.currentScreen, Screen.library);
    });

    test('ההגדרה כבויה (ברירת המחדל): נפתח בספר האחרון כמו קודם', () {
      expect(_launch(hasTabs: true).state.currentScreen, Screen.reading);
    });

    test('בלי כרטיסיות שמורות: מסך הבית בשני המצבים', () async {
      expect(_launch(hasTabs: false).state.currentScreen, Screen.library);
      await Settings.setValue<bool>(
        SettingsRepository.keyStartOnHomeScreen,
        true,
      );
      expect(_launch(hasTabs: false).state.currentScreen, Screen.library);
    });
  });

  group('SettingsBloc', () {
    SettingsBloc newBloc() {
      final repository = SettingsRepository();
      final bloc = SettingsBloc(
        repository: repository,
        initialSettings: repository.readSettings(),
        ensureFontLoaded: (_) async {},
      );
      addTearDown(bloc.close);
      return bloc;
    }

    test('ברירת המחדל כבויה', () {
      expect(newBloc().state.startOnHomeScreen, isFalse);
    });

    test('האירוע נשמר במפתח ומעדכן את המצב', () async {
      final bloc = newBloc()..add(const UpdateStartOnHomeScreen(true));
      await bloc.stream.firstWhere((s) => s.startOnHomeScreen);
      expect(
        Settings.getValue<bool>(SettingsRepository.keyStartOnHomeScreen),
        isTrue,
      );
      expect(newBloc().state.startOnHomeScreen, isTrue);
    });
  });
}
