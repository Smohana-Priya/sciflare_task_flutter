import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<dynamic> createUser({
    required String name,
    required String email,
    required String mobile,
    required String gender,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode(
          {"name": name, "email": email, "mobile": mobile, "gender": gender});

      var response = await _dio.post(
        'https://crudcrud.com/api/3dd5f27a16f94897892fae2b91b14dd8/post',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (error) {
      throw Exception('Failed to create user: $error');
    }
  }
}
