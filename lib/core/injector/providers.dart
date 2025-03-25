// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:planets/core/core.dart';
import 'package:riverpod/riverpod.dart';

final class Providers {
  const Providers._();

  static final env = Provider<Environment>(
    (_) => throw UnimplementedError(),
  );

  static final http = Provider(
    (ref) {
      final enableLogging = ref.read(Providers.env).enableLogging;
      final baseOptions = BaseOptions(
        baseUrl: const String.fromEnvironment('baseUrl'),
        validateStatus: (status) => status != null,
      );
      final dio = Dio(baseOptions);
      dio.interceptors.addAll([
        const AuthInterceptor(),
        RetryInterceptor(dio: dio, enableLogging: enableLogging),
      ]);
      return Http(dio: dio, enableLogging: enableLogging);
    },
  );

  static final localStorage = Provider<LocalStorage>(
    (_) => throw UnimplementedError(),
  );
}
