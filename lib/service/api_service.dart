// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sciflare_task_flutter/model/user_data_model.dart';

import '../const/api_const.dart';
import '../const/app_const.dart';

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
      var data = json.encode({
        AppConstants.name: name,
        AppConstants.email: email,
        AppConstants.mobile: mobile,
        AppConstants.gender: gender
      });

      var response = await _dio.post(
        ApiConstants.url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        final data = json.encode(response.data);

        await secureStorage.write(key: AppConstants.storageKey, value: data);

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
      String? apiResponse =
          await secureStorage.read(key: AppConstants.storageKey);

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

  Future<List<UserDataModal>> getUsers() async {
    try {
      final response = await _dio.get(
        ApiConstants.url,
      );

      if (response.statusCode == 200) {
        List<dynamic> list = response.data;

        return List<UserDataModal>.from(
            list.map((model) => UserDataModal.fromJson(model)));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
