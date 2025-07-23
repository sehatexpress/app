import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/constants.dart';
import '../config/string_constants.dart';
import '../services/remote_config_service.dart';

final remoteConfigProvider = FutureProvider<RemoteConfigData>((ref) async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: Duration.zero,
  ));

  await remoteConfig.setDefaults({
    RemoteConfigConstant.minimumVersion: RemoteConfigConstant.defaultVersion,
    RemoteConfigConstant.updateTitle: Strings.updateAvailableTitle,
    RemoteConfigConstant.updateBody: Strings.updateAvailableMessage,
  });

  await remoteConfig.fetchAndActivate();

  return RemoteConfigData(remoteConfig);
});
