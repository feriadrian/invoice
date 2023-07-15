import 'package:dio/dio.dart';
import 'package:myinvoice/data/endpoint/endpoint.dart';
import 'package:myinvoice/data/pref.dart';
import 'package:myinvoice/models/home/report.dart';

import '../viewmodel/auth_provider.dart';

class HomeService {
  static final dio = Dio();
  static Future<void> signOut() async {
    AuthProvider().signOut;
  }

  Future<HomeReport> getReport() async {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) {
        if (error.response!.statusCode! == 401) {
          AuthProvider().signOut;
        }
        return handler.next(error);
      },
    ));
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Response response = await Dio().get(
      Endpoint.getSummary,
        options: Options(headers: headers),
      );

      HomeReport homeReport = HomeReport.fromJson(response.data);

      return homeReport;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
