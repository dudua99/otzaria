import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:otzaria/plugins/models/plugin_manifest.dart';
import 'package:otzaria/plugins/models/plugin_network_permission_mode.dart';
import 'package:otzaria/plugins/repository/plugin_registry_repository.dart';
import 'package:otzaria/plugins/services/plugin_network_access_resolver.dart';
import 'package:otzaria/plugins/services/plugin_network_gate.dart';
import 'package:otzaria/plugins/services/plugin_network_policy.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria/settings/engine/settings_repository.dart';

import '../../helpers/memory_settings_cache.dart';

const _remote = 'https://api.example.com/v1/updates';
const _local = 'http://127.0.0.9:8080/api';

final _manifest = PluginManifest(
  schemaVersion: 1,
  id: 'test.store',
  name: 'Test Store',
  version: '1.0.0',
  description: '',
  author: '',
  homepage: '',
  entrypoint: 'index.html',
  minAppVersion: '0.0.0',
  sdkVersion: '1.x',
  permissions: const ['network.access', 'network.localhost'],
  networkEnabled: true,
  networkAllowlist: const ['https://api.example.com', '127.0.0.9'],
  toolTabTitle: 'Test Store',
  toolTabOrder: 1,
  defaultPinned: true,
  publishedDataTypes: const [],
);

class _GrantAll implements PluginRegistryRepository {
  @override
  Future<bool?> getPermission(String pluginId, String permission) async => true;

  @override
  dynamic noSuchMethod(Invocation i) => super.noSuchMethod(i);
}

void main() {
  late PluginNetworkAccessResolver resolver;

  setUpAll(() => Settings.init(cacheProvider: MemorySettingsCache()));

  setUp(() async {
    PluginNetworkPermissionMode.debugSetAppVersion('0.9.98.1');
    resolver = PluginNetworkAccessResolver(
      client: MockClient(
        (_) async => http.Response(
          'https://api.example.com\n',
          200,
          headers: const {'content-type': 'text/plain; charset=utf-8'},
        ),
      ),
    );
    await resolver.loadOfficialAllowlist();
    PluginNetworkAccessResolver.instance = resolver;
  });

  tearDown(() async {
    PluginNetworkPermissionMode.debugSetAppVersion(null);
    PluginNetworkAccessResolver.instance = PluginNetworkAccessResolver();
    await Settings.setValue<bool>(SettingsRepository.keyOfflineMode, false);
  });

  Future<PluginNetworkDecision> decide(String url) =>
      evaluatePluginNetworkAccess(
        uri: Uri.parse(url),
        pluginId: _manifest.id,
        manifest: _manifest,
        registry: _GrantAll(),
      );

  Future<PluginNetworkPolicy> policy() => resolvePluginNetworkPolicy(
    pluginId: _manifest.id,
    manifest: _manifest,
    registry: _GrantAll(),
    resolver: resolver,
  );

  test('במצב מנותק תוסף לא ניגש לאינטרנט גם עם הרשאה (#6066)', () async {
    expect(await decide(_remote), PluginNetworkDecision.allowed);

    await Settings.setValue<bool>(SettingsRepository.keyOfflineMode, true);
    expect(await decide(_remote), isNot(PluginNetworkDecision.allowed));
  });

  test('במצב מנותק שירות מקומי (loopback) נשאר מותר', () async {
    await Settings.setValue<bool>(SettingsRepository.keyOfflineMode, true);
    expect(await decide(_local), PluginNetworkDecision.allowed);
  });

  test('במצב מנותק מדיניות ה-WebView בלי יעדים מרוחקים', () async {
    expect((await policy()).prefixes, ['https://api.example.com']);

    await Settings.setValue<bool>(SettingsRepository.keyOfflineMode, true);
    final offline = await policy();
    expect(offline.prefixes, isEmpty);
    expect(offline.loopbackHosts, ['127.0.0.9']);
  });
}
