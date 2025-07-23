import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../config/constants.dart';

class RemoteConfigData {
  final FirebaseRemoteConfig _config;

  const RemoteConfigData(this._config);

  String get minimumVersion =>
      _config.getString(RemoteConfigConstant.minimumVersion);

  String get updateTitle => _config.getString(RemoteConfigConstant.updateTitle);

  String get updateBody => _config.getString(RemoteConfigConstant.updateBody);

  Map<String, RemoteConfigValue> get all => _config.getAll();
}

class RemoteConfigService {
  const RemoteConfigService();

  /// get current app info
  Future<PackageInfo> getAppInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info;
    } catch (e) {
      throw e.toString();
    }
  }
}

final remoteConfigServiceProvider = Provider((_) => RemoteConfigService());
