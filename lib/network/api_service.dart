import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';
import 'client_network.dart';

class ApiService {
  static Future<LoginModel> login(String username, String password) async {
    final url = Uri.parse("${ClientNetwork.baseUrl}/login");

    final response = await http.post(
      url,
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      throw Exception("Failed to login: ${response.reasonPhrase}");
    }
  }
}
