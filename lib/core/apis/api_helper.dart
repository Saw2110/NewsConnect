import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_const.dart';

class APIProvider {
  static final APIProvider _instance = APIProvider._internal();
  factory APIProvider() => _instance;
  APIProvider._internal();

  Future<dynamic> _request(String endPoint, String method, String body) async {
    final apiUrl = ApiConst.baseUrl + endPoint;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'DeviceName',
    };

    try {
      late http.Response response;

      switch (method) {
        case 'GET':
          response = await http
              .get(Uri.parse(apiUrl), headers: headers)
              .timeout(const Duration(seconds: 20));
          break;
        case 'POST':
          response = await http
              .post(Uri.parse(apiUrl), headers: headers, body: body)
              .timeout(const Duration(seconds: 30));
          break;
        default:
          throw Exception('Invalid HTTP method');
      }

      if (response.statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed with status code: ${response.statusCode}, body: ${response.body}');
      }
    } on SocketException {
      throw const SocketException('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException('Connection Timed Out');
    } catch (e) {
      debugPrint('Error in API Request: $e');
      throw Exception();
    }
  }

  Future<dynamic> getAPI({required String endPoint}) async {
    return _request(endPoint, 'GET', '');
  }

  Future<dynamic> postAPI(
      {required String endPoint, required String body}) async {
    return _request(endPoint, 'POST', body);
  }
}
