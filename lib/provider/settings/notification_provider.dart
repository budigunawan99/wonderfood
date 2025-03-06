import 'package:flutter/widgets.dart';
import 'package:wonderfood/data/local/local_notification_service.dart';

class NotificationProvider with ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  NotificationProvider(this.flutterNotificationService);

  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  bool? _permission = true;
  bool? get permission => _permission;

  void setEnabled(bool status) {
    _isEnabled = status;
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }
}
