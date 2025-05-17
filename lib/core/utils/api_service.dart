import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiService{
  final _baseUrl= 'https://banker-v2.banker-eg.live/api';
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get({required String endpoint,  Map<String, dynamic>? queryParameters}) async{
    log("Endpoint: $endpoint");
    _dio.options.headers.addAll(
      {
        'Authorization': 'Bearer 3478|vshFQy0WAjguJR5LF5b9beadBOcXpzmrel9wF7UH',
        "Accept": 'application/json',
        'lang': "ar",
        'client-type': Platform.isIOS ? "ios" : "android",
        'client-version': 1,
      },
    );
    var response = await _dio.get('$_baseUrl$endpoint', queryParameters: queryParameters);
    log("Response: $response");
    return response;
  }

  Future<Map<String, dynamic>> post({required String endpoint, Map<String, dynamic>? queryParameters}) async {
    log("response$endpoint");
    _dio.options.headers.addAll(

      {
        'Authorization': 'Bearer 3478|vshFQy0WAjguJR5LF5b9beadBOcXpzmrel9wF7UH',
        "Accept": 'application/json',
        'lang': "ar",
        'client-type': Platform.isIOS ? "ios" : "android",
        'client-version': 1,
      },
    );
    var response = await _dio.post('$_baseUrl$endpoint', queryParameters: queryParameters);
    log("response${response.data}");
    return response.data;

  }
}