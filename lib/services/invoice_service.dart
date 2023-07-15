import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:myinvoice/data/endpoint/endpoint.dart';
import 'package:myinvoice/models/bank/bank_model.dart';
import 'package:myinvoice/models/invoice/invoice_model.dart';
import 'package:myinvoice/models/invoice_detail/invoice_detail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/pref.dart';

class InvoiceServices {
  // function get all invoice
  Future<List<Invoice>> getAllInvoice(
    int limit, {
    int isPaid = -1,
  }) async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      String path;

      if (isPaid == -1) {
        path = "${Endpoint.invoice}customers?limit=$limit&offset=0";
      } else {
        path =
            "${Endpoint.invoice}customers?limit=$limit&offset=0&payment_status_id=$isPaid";
      }

      var response = await Dio().get(
        path,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data['data']['invoices'];

        List<Invoice> invoices = [];

        for (var item in data) {
          invoices.add(Invoice.fromJson(item));
        }

        return invoices;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

// function untuk get invoice berdasarkan id
  Future<InvoiceDetail> getInvoiceById(int id) async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await Dio().get(
        '${Endpoint.invoice}$id/customers',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        var data = response.data['data'];

        InvoiceDetail invoiceDetail = InvoiceDetail.fromJson(data);
        return invoiceDetail;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

// function untuk mendapatkan list bank si merchant

  Future<List<BankModel>> getAllBank(int id) async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
      };

      var response = await Dio().get(
        '${Endpoint.baseUrl}merchants/$id/banks',
        options: Options(headers: headers),
      );

      // print(response.data);

      if (response.statusCode == 200) {
        var data = response.data['data'];
        List<BankModel> bankModel = [];

        for (var item in data) {
          bankModel.add(BankModel.fromJson(item));
        }
        print('susces');
        return bankModel;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<void> confirmPaymentByid(int id, File file) async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await Dio().put(
        '${Endpoint.invoice}$id/confirm',
        options: Options(headers: headers),
      );

      print('success 001');

      FormData formData = FormData.fromMap({
        'payment':
            await MultipartFile.fromFile(file.path, filename: "image.jpg")
      });

      final responseMultiPart = await Dio().patch(
        '${Endpoint.invoice}$id/payments/upload',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('success 002');

      print(responseMultiPart.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  // function untuk download invoice

  Future<bool> downloadInvoiceKakAde(int id) async {
    try {
      final String? token = await Pref.getToken();
      var headers = {
        'accept': 'application/pdf',
        'Authorization': 'Bearer $token',
      };

      var response = await Dio().getUri(
        Uri.parse('https://api.my-invoice.me/api/v1/invoices/1/download'),
        options: Options(headers: headers),
      );

      await launchUrl(response.realUri);

      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<void> downloadPDF(int id) async {
    Dio dio = Dio();

    try {
      final String? token = await Pref.getToken();

      var response = await dio.get(
        'https://api.my-invoice.me/api/v1/invoices/$id/download',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Content-Disposition': 'attachment; filename=file.pdf',
            'accept': 'application/pdf',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final Uint8List bytes = response.data;

      final String filename = 'file.pdf';
      final String mimeType = 'application/pdf';
      final html.Blob blob = html.Blob([bytes], mimeType);
      final anchor = html.document.createElement('a') as html.AnchorElement;

      anchor.href = html.Url.createObjectUrl(blob);
      anchor.download = filename;
      anchor.click();

      html.Url.revokeObjectUrl(anchor.href!);
    } catch (e) {
      print(e);
    }
  }
}
