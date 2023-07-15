import 'package:dio/dio.dart';
import 'package:myinvoice/data/endpoint/endpoint.dart';
import 'package:myinvoice/models/auth/auth_model.dart';
import '../viewmodel/auth_provider.dart';

class AuthService {
  static final dio = Dio();
  static Future<void> signOut() async {
    AuthProvider().signOut;
  }

  static Future<SignInResponse> signIn(String email, String password) async {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) {
        if (error.response!.statusCode! == 401) {
          AuthProvider().signOut;
        }
        return handler.next(error);
      },
    ));
    try {
      print(Endpoint.login);
      final res = await Dio().post(Endpoint.login,
          data: {"email": email, "password": password, "device_id": "436257"});
      print(res.statusCode);
      print(res.data);

      return SignInResponse(
          statusCode: res.statusCode, data: res.data, error: res.data);
    } on DioError catch (e) {
      print(e.response!.data);

      if (e.response!.statusCode! > 500) {
        return SignInResponse(
          statusCode: e.response?.statusCode,
          data: {
            'error': {'message': 'Server error'}
          },
        );
      } else {
        return SignInResponse(
            statusCode: e.response?.statusCode,
            data: e.response?.data,
            error: e.response?.data);
      }
    }
  }

  static Future<SignUpResponse> signUp(
      String fullname, String email, String password) async {
    try {
      final res = await Dio().post(
        Endpoint.register,
        data: {"email": email, "password": password, "full_name": fullname},
      );

      print(res.data);
      print(res.statusCode);

      return SignUpResponse(
          statusCode: res.statusCode,
          data: res.data['data'],
          error: res.data['error']);
    } on DioError catch (e) {
      if (e.response!.statusCode! > 500) {
        return SignUpResponse(
            statusCode: e.response?.statusCode,
            error: {'message': 'Server error'});
      } else {
        print(e.response?.data);
        return SignUpResponse(
            statusCode: e.response?.statusCode,
            error: e.response?.data['error']);
      }
    }
  }

  static Future<Verification> verifEmail(String email, String code) async {
    try {
      final res = await Dio()
          .post(Endpoint.verification, data: {'email': email, 'code': code});
      print(res.data);

      return Verification(
          statusCode: res.statusCode,
          data: res.data['data'],
          error: res.data['error']);
    } on DioError catch (e) {
      if (e.response!.statusCode! > 500) {
        return Verification(
            statusCode: e.response?.statusCode,
            error: {'message': 'Server error'});
      } else {
        return Verification(
            statusCode: e.response?.statusCode,
            data: e.response?.data['data'],
            error: e.response?.data['error']);
      }
    }
  }

  static Future<bool?> resetPassword(String email) async {
    try {
      final res = await Dio().post(Endpoint.resetPassword, data: {
        'email': email,
      });

      print(res.data);

      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return null;
  }
}
