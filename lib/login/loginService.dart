import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/utils/ApiExeption.dart';

class LoginService {
  const LoginService();

  static Future login(
    String username,
    String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final domain = prefs.getString('domain');
    final url = Uri.https(domain!, 'api/auth/sign-in');
    final response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data['accessToken'];
    } else {
      final data = convert.jsonDecode(response.body);
      return ApiException(data['message']);
    }
  }

  static Future checkAPI({required String api}) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final domain = prefs.getString('domain');
    final url = Uri.https(api);
    final response = await http
        .get(
          url,
        )
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data['status'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }
}
