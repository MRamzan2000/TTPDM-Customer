import 'package:get/get.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;
  var todayNotifications = <Map<String, dynamic>>[].obs;
  var yesterdayNotifications = <Map<String, dynamic>>[].obs;
  var olderNotifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    notifications.value = await MySharedPreferences().getSavedNotifications();
    categorizeNotifications();
  }

  void categorizeNotifications() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));

    todayNotifications.value = notifications.where((notification) {
      DateTime receivedTime = DateTime.parse(notification['receivedTime']);
      return receivedTime.isAfter(todayStart) && receivedTime.isBefore(todayStart.add(const Duration(days: 1)));
    }).toList();

    yesterdayNotifications.value = notifications.where((notification) {
      DateTime receivedTime = DateTime.parse(notification['receivedTime']);
      return receivedTime.isAfter(yesterdayStart) && receivedTime.isBefore(todayStart);
    }).toList();

    olderNotifications.value = notifications.where((notification) {
      DateTime receivedTime = DateTime.parse(notification['receivedTime']);
      return receivedTime.isBefore(yesterdayStart);
    }).toList();
  }
}
