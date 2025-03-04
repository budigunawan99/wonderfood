import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationSharedPreferencesService {
  final SharedPreferences _preferences;

  NotificationSharedPreferencesService(this._preferences);

  static const String notificationKey = 'WONDERFOOD_NOTIFICATION_STATUS';

  Future<void> saveNotificationStatus(bool status) async {
    try {
      await _preferences.setBool(notificationKey, status);
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  bool getNotificationStatus() {
    return _preferences.getBool(notificationKey) ?? false;
  }
}
