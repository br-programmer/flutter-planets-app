import 'package:dio/dio.dart';
import 'package:planets/i18n/translations.g.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const apiKey = String.fromEnvironment('planetsApiKey');
    final lang = LocaleSettings.currentLocale.languageCode;
    options.headers.addAll({'x-api-key': apiKey, 'x-lang': lang});
    super.onRequest(options, handler);
  }
}
