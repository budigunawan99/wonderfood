import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/local/notification_shared_preferences_service.dart';

class NotificationSharedPreferencesProvider extends ChangeNotifier {
  final NotificationSharedPreferencesService _service;

  NotificationSharedPreferencesProvider(this._service);

  String _message = "";
  String get message => _message;

  bool? _status;
  bool? get status => _status;

  Future<void> saveNotificationStatus(bool status) async {
    try {
      await _service.saveNotificationStatus(status);
      _message = "Pengaturan anda sudah tersimpan";
    } catch (e) {
      _message = "Pengaturan anda gagal tersimpan";
    }
    notifyListeners();
  }

  void getNotificationStatus() async {
    try {
      _status = _service.getNotificationStatus();
      _message = "Berhasil membuka pengaturan";
    } catch (e) {
      _message = "Gagal membuka pengaturan";
    }
    notifyListeners();
  }
}
