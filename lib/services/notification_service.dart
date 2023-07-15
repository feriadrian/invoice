import 'package:dio/dio.dart';
import 'package:myinvoice/data/endpoint/endpoint.dart';
import 'package:myinvoice/data/pref.dart';
import 'package:myinvoice/models/notification/notification_model.dart';
import 'package:myinvoice/models/notification/unread_count.dart';

class NotificationServices {
  final Dio dio = Dio();
  // NotificationServices() {
  //   dio.interceptors.add(LogInterceptor(
  //       responseHeader: true, responseBody: true, requestBody: true));
  // }

  Future<NotificationData> fetchAllNotification() async {
    try {
      final String? token = await Pref.getToken();

      final Response response = await dio.get('${Endpoint.getNotification}',
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      NotificationData notification = NotificationData.fromJson(response.data);

      return notification;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<UnreadNotifCount> fetchNotifCount() async {
    try {
      final String? token = await Pref.getToken();

      final Response response = await dio.get('${Endpoint.getNotifCount}',
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      UnreadNotifCount unreadCount = UnreadNotifCount.fromJson(response.data);

      return unreadCount;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<NotificationData> markAsRead(int id) async {
    try {
      final String? token = await Pref.getToken();

      final Response response = await dio.put('${Endpoint.markAsRead}$id',
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      NotificationData isRead = NotificationData.fromJson(response.data);

      return isRead;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
