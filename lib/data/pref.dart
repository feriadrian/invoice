import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    return token;
  }

  static Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
  }
}
