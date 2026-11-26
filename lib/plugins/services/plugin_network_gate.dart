import 'package:otzaria/plugins/models/plugin_manifest.dart';
import 'package:otzaria/plugins/models/plugin_network_permission_mode.dart';
import 'package:otzaria/plugins/repository/plugin_registry_repository.dart';
import 'package:otzaria/plugins/services/plugin_network_access_resolver.dart';
import 'package:otzaria/plugins/models/plugin_network_allowlist.dart';
import 'package:otzaria/settings/engine/app_settings_store.dart';
import 'package:otzaria/settings/engine/settings_repository.dart';

/// תוצאת בדיקת הגישה של תוסף ל-URL.
enum PluginNetworkDecision {
  allowed,

  /// המניפסט אינו מצהיר על גישה לרשת.
  notDeclared,

  /// הרשאת הרשת המתאימה ליעד לא הוענקה.
  permissionMissing,

  /// היעד אינו ברשימת ההיתר (המניפסט או הרשימה הרשמית).
  notAllowlisted,

  /// אוצריא במצב מנותק; יעד מקומי (loopback) אינו אינטרנט ונשאר מותר.
  offlineMode,
}

/// האם אוצריא במצב מנותק. Settings שלא אותחל (בדיקות) נחשב מחובר.
bool isPluginNetworkOffline() {
  try {
    return Settings.getValue<bool>(SettingsRepository.keyOfflineMode) ?? false;
  } catch (_) {
    return false;
  }
}

/// הבדיקה היחידה של "האם תוסף רשאי לפנות ל-[uri]" — משמשת גם את גשר ה-RPC
/// (network.*) וגם את שערי הניווט/הבקשות של ה-WebView, כדי ששלושת השערים לא
/// ייפרדו זה מזה.
Future<PluginNetworkDecision> evaluatePluginNetworkAccess({
  required Uri uri,
  required String pluginId,
  required PluginManifest manifest,
  required PluginRegistryRepository registry,
}) async {
  if (!manifest.networkEnabled) return PluginNetworkDecision.notDeclared;
  if (!isLoopbackHost(uri.host) && isPluginNetworkOffline()) {
    return PluginNetworkDecision.offlineMode;
  }
  final accepted = acceptedNetworkPermissionsFor(
    uri,
    strict: await PluginNetworkPermissionMode.isStrict(),
  );
  var granted = false;
  for (final permission in accepted) {
    if (await registry.getPermission(pluginId, permission) == true) {
      granted = true;
      break;
    }
  }
  if (!granted) return PluginNetworkDecision.permissionMissing;
  final allowed = await PluginNetworkAccessResolver.instance
      .isUriAllowedForPlugin(uri, manifest);
  return allowed
      ? PluginNetworkDecision.allowed
      : PluginNetworkDecision.notAllowlisted;
}

/// גרסה בוליאנית ל-[evaluatePluginNetworkAccess], לשערים שאין להם מה לומר
/// למשתמש מעבר ל"נחסם".
Future<bool> isPluginNetworkAccessAllowed({
  required Uri uri,
  required String pluginId,
  required PluginManifest manifest,
  required PluginRegistryRepository registry,
}) async =>
    await evaluatePluginNetworkAccess(
      uri: uri,
      pluginId: pluginId,
      manifest: manifest,
      registry: registry,
    ) ==
    PluginNetworkDecision.allowed;
