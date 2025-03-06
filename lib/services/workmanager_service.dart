import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wonderfood/data/api/api_services.dart';
import 'package:wonderfood/data/local/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final apiServices = ApiServices();
    final localNotificationService = LocalNotificationService()..init();
    if (task == "com.example.wonderfood") {
      try {
        final randomRestaurant = await apiServices.getRandomRestaurant();
        await localNotificationService.showDailyNotification(randomRestaurant);
      } catch (e) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
    : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Duration setScheduleTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    final initialDelay = scheduledDate.difference(now);
    return initialDelay;
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      "com.example.wonderfood",
      "com.example.wonderfood",
      frequency: const Duration(days: 1),
      initialDelay: setScheduleTime(11, 0),
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
