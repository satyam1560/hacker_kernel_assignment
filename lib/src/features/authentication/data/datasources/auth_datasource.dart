import 'dart:convert';

import 'package:hacker_kernel_assignment/src/features/authentication/data/models/user_dto.dart';
import 'package:http/http.dart' as http;

class AuthDataSource {
  Future<UserDto?> login({
    required String email,
    required String password,
  }) async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        return UserDto.fromJson(jsonResponse as Map<String, dynamic>);
      }
    } catch (_) {
      rethrow;
    }
    return null;
  }
}
