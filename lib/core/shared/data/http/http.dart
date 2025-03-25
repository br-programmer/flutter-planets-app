import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:planets/core/core.dart';

export 'constants/constants.dart';
export 'failures/failures.dart';
export 'http_result.dart';
export 'interceptors/interceptors.dart';

enum HttpMethod { get, post, patch, put, delete }

class Http {
  Http({required Dio dio, required bool enableLogging})
      : _dio = dio,
        _enableLogging = enableLogging;

  final Dio _dio;
  final bool _enableLogging;

  FutureHttpResult<T> send<T>(
    String path, {
    required T Function(int statusCode, dynamic data) parser,
    HttpMethod method = HttpMethod.get,
    Json queryParameters = const {},
    Json headers = const {},
    Json body = const {},

    /// if autoDecodeResponse is false on the parser callback you will get response.bodyBytes (Uint8List)
    bool autoDecodeResponse = true,

    /// Timeout in milliseconds for receiving data.
    Duration? receiveTimeout,
  }) async {
    int? statusCode;

    try {
      final contentType = headers['content-type'] ?? headers['Content-Type'];

      final headerContentType = contentType == Headers.formUrlEncodedContentType
          ? Headers.formUrlEncodedContentType
          : Headers.jsonContentType;

      final response = await _dio.request<dynamic>(
        path,
        queryParameters: queryParameters,
        data: switch (method) { HttpMethod.get => null, _ => body },
        options: Options(
          receiveTimeout: receiveTimeout,
          contentType: headerContentType,
          responseType: autoDecodeResponse ? null : ResponseType.bytes,
          method: method.name,
          headers: headers,
        ),
      );
      if (_enableLogging) {
        log(
          const JsonEncoder.withIndent(' ').convert({
            'url': response.realUri.toString(),
            'headers': response.requestOptions.headers,
            'statusCode': response.statusCode,
            'body': body,
          }),
        );
      }

      statusCode = response.statusCode;
      final responseBody = response.data;

      if (autoDecodeResponse &&
          (responseBody is Map || responseBody is List) &&
          _enableLogging) {
        log(
          const JsonEncoder.withIndent(' ').convert({
            'url': response.realUri.toString(),
            'headers': response.requestOptions.headers,
            'statusCode': response.statusCode,
            'body': responseBody,
          }),
        );
      }

      if (statusCode != null && statusCode >= 200 && statusCode <= 399) {
        return HttpResult.success(
          statusCode,
          parser(statusCode, responseBody),
        );
      }

      return HttpResult.failed(statusCode, responseBody);
    } on DioException catch (e) {
      if (_enableLogging) {
        log(
          const JsonEncoder.withIndent(' ').convert({
            'url': e.requestOptions.uri.toString(),
            'headers': e.requestOptions.headers,
            'method': e.requestOptions.method,
            'request body': e.requestOptions.data,
            'response body': e.response?.data,
            'statusCode': e.response?.statusCode,
            'message': e.message,
          }),
          stackTrace: e.stackTrace,
        );
      }
      return HttpResult.failed(e.response?.statusCode, e.response?.data);
    } catch (e, s) {
      if (_enableLogging) {
        log(e.toString(), stackTrace: s);
      }
      return HttpResult.failed(statusCode, e);
    }
  }
}
