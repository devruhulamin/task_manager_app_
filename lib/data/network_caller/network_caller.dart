import 'dart:convert';

import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:http/http.dart' as http;

class NetworkCaller {
  Future<NetworkResponse> postRequest({
    required String url,
    required dynamic data,
  }) async {
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        // print(response.body);
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
