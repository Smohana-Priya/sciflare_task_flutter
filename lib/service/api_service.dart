// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final secureStorage = const FlutterSecureStorage();
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
        final data = json.encode(response.data);

        /// Store the response

        await secureStorage.write(key: 'api_response', value: data);

        return response.data;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (error) {
      throw Exception('Failed to create user: $error');
    }
  }

  Future<Map<String, dynamic>?> retrieveApiResponse() async {
    try {
      String? apiResponse = await secureStorage.read(key: 'api_response');

      if (apiResponse != null) {
        Map<String, dynamic> responseData = json.decode(apiResponse);
        return responseData;
      } else {
        print('No API response data found.');
        return null;
      }
    } catch (e) {
      print('Error retrieving API response: $e');
      return null;
    }
  }
}
