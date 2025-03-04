import 'package:flutter/widgets.dart';

class NotificationProvider with ChangeNotifier {
  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  void setEnabled(bool status) {
    _isEnabled = status;
    notifyListeners();
  }
}
