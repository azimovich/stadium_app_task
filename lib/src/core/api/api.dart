import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stadium_app_task/src/core/api/api_contstans.dart';

enum ApiResult {
  success,
  error,
}

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

@immutable
sealed class DioService {
  /// Options
  static BaseOptions _options = BaseOptions();

  static Dio _dio = Dio();

  static Dio init() {
    _options = BaseOptions(
      connectTimeout: ApiConstants.duration,
      receiveTimeout: ApiConstants.duration,
      sendTimeout: ApiConstants.duration,
      baseUrl: ApiConstants.baseUrl,
      contentType: ApiConstants.contentType,
      validateStatus: ApiConstants.validate,
    );
    _dio = Dio(_options);
    return _dio;
  }

  static Future<String?> request(
    String api,
    RequestMethod method, [
    Map<String, dynamic>? param,
    Map<String, Object?> data = const {},
    String? id,
  ]) async {
    try {
      Response response = await init().request(
        id == null ? api : "$api/$id",
        data: jsonEncode(data),
        options: Options(
          method: method.name,
        ),
      );
      return jsonEncode(response.data);
    } on DioException catch (e) {
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      Future.delayed(Duration.zero).then((value) {});
      return null;
    }
  }
}
