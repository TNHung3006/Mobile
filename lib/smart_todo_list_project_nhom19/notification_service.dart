import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'dart:io' show Platform;
import 'dart:typed_data';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    tz_data.initializeTimeZones();
    // Sử dụng UTC làm gốc để tính toán khoảng cách thời gian, tránh lệch múi giờ
    tz.setLocalLocation(tz.UTC);

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    await _notifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (details) {
        debugPrint("🔔 Thông báo được nhấn!");
      },
    );

    if (Platform.isAndroid) {
      final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      
      // Tạo kênh báo thức "Cấp độ khẩn cấp" v100
      const channel = AndroidNotificationChannel(
        'smart_todo_alarm_v100', 
        'Báo Thức Nhắc Nhở Công Việc',
        description: 'Kênh này dùng để nhắc nhở có chuông và rung mạnh',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        audioAttributesUsage: AudioAttributesUsage.alarm,
      );
      await androidPlugin?.createNotificationChannel(channel);

      // Xin quyền (Rất quan trọng cho Android 13+)
      await androidPlugin?.requestNotificationsPermission();
      await androidPlugin?.requestExactAlarmsPermission();
    }
    debugPrint("✅ Notification Service: Sẵn sàng!");
  }

  // Hiện thông báo tức thì (Dùng để TEST nhanh xem app có quyền hiện chưa)
  Future<void> showInstantNotification({required String title, required String body}) async {
    const details = AndroidNotificationDetails(
      'smart_todo_alarm_v100', 'Báo Thức Nhắc Nhở Công Việc',
      importance: Importance.max, priority: Priority.max, playSound: true,
      enableVibration: true, fullScreenIntent: true,
    );
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, 
      title, 
      body, 
      const NotificationDetails(android: details)
    );
  }

  // TEST nổ chuông sau 5 giây (Bản sửa lỗi delay)
  Future<void> test5Seconds() async {
    final scheduledTime = tz.TZDateTime.now(tz.UTC).add(const Duration(seconds: 5));
    await _execute(999, "🔔 TEST CHUÔNG OK", "Báo thức đã hoạt động hoàn hảo!", scheduledTime);
  }

  // Lập lịch nhắc nhở chính thức (Thuật toán chống lệch múi giờ)
  Future<int?> scheduleReminder({
    required String title,
    required String body,
    required String dueDate,
    required String reminderTime,
    int? existingNotificationId,
  }) async {
    try {
      if (existingNotificationId != null) {
        await cancelReminder(existingNotificationId);
      }

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final dateParts = dueDate.split('/');
      final timeParts = reminderTime.split(':');
      
      // Tính toán dựa trên thời gian thực tại của máy
      final now = DateTime.now();
      final scheduledDate = DateTime(
        int.parse(dateParts[2]), int.parse(dateParts[1]), int.parse(dateParts[0]),
        int.parse(timeParts[0]), int.parse(timeParts[1]),
      );

      final difference = scheduledDate.difference(now);
      
      // Nếu giờ hẹn là ngay bây giờ hoặc vừa qua 1 chút, nổ ngay sau 1 giây
      final effectiveDelay = (difference.inSeconds < -5) ? null : (difference.isNegative ? const Duration(seconds: 1) : difference);
      
      if (effectiveDelay == null) {
        debugPrint("⚠️ Thời gian hẹn đã qua: $scheduledDate");
        return null;
      }

      // Đặt báo thức bằng cách cộng khoảng thời gian chờ (delay)
      final tzDate = tz.TZDateTime.now(tz.UTC).add(effectiveDelay);

      await _execute(id, "⏰ NHẮC NHỞ: $title", body, tzDate);
      debugPrint("🚀 Đã đặt báo thức lúc: $scheduledDate (Sau ${effectiveDelay.inMinutes} phút)");
      return id;
    } catch (e) {
      debugPrint("❌ Lỗi: $e");
      return null;
    }
  }

  Future<void> _execute(int id, String title, String body, tz.TZDateTime time) async {
    final vibrationPattern = Int64List.fromList([0, 1000, 500, 1000, 500, 1000]);
    await _notifications.zonedSchedule(
      id, title, body, time,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'smart_todo_alarm_v100', 'Báo Thức Nhắc Nhở Công Việc',
          importance: Importance.max, priority: Priority.max, playSound: true,
          enableVibration: true, vibrationPattern: vibrationPattern,
          fullScreenIntent: true, category: AndroidNotificationCategory.alarm,
          visibility: NotificationVisibility.public,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(presentSound: true, presentAlert: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelReminder(int id) async => await _notifications.cancel(id);

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  Future<bool> hasNotificationPermission() async {
    if (Platform.isAndroid) {
      final androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.areNotificationsEnabled() ?? false;
    }
    return true;
  }
}
