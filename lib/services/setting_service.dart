import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler, StringExtensions;
import '../config/string_constants.dart' show CollectionConstants;
import '../models/setting_model.dart';

final _settingRef = CollectionConstants.settings;

class SettingService {
  // get city setting
  Stream<SettingModel?> getCitySettings(String? city) {
    if (city == null) return Stream.value(null);

    try {
      final finalCity = city.translatedCity.toUpperCase();
      return _settingRef
          .doc(finalCity)
          .snapshots(includeMetadataChanges: true)
          .map((doc) => doc.exists ? SettingModel.fromSnapshot(doc) : null);
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get list of all cities' settings
  Stream<List<SettingModel>> getCitySettingsList() {
    try {
      return _settingRef.snapshots(includeMetadataChanges: true).map((docs) =>
          docs.docs.map((doc) => SettingModel.fromSnapshot(doc)).toList());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final settingServiceProvider = Provider((_) => SettingService());
