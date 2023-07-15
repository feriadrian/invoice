import 'package:dio/dio.dart';
import 'package:myinvoice/data/endpoint/endpoint.dart';
import 'package:myinvoice/models/report/report_model.dart';

import '../data/pref.dart';

class ReportServices {
  Future<ReportModel> getReport() async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await Dio().get(
        Endpoint.report,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        var data = response.data['data'];

        ReportModel reportModel = ReportModel.fromJson(data);
        return reportModel;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
