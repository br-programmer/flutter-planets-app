import 'dart:io';

import 'package:planets/core/core.dart';

const _network = HttpRequestFailure.network();
const _unauthorized = HttpRequestFailure.unauthorized();
const _internalServer = HttpRequestFailure.internalServer();
const _notFound = HttpRequestFailure.notFound();
const _serviceUnavailable = HttpRequestFailure.serviceUnavailable();
const _unhandledException = HttpRequestFailure.unhandledException();

FutureHttpRequest<T> performHttpRequest<T>(FutureHttpResult<T> future) async {
  final result = await future;
  return switch (result) {
    HttpSuccess(:final data) => Success(data),
    HttpFailure(:final error) when _socket(error) => Failure(_network),
    HttpFailure(:final statusCode) => switch (statusCode) {
        HttpStatus.unauthorized => Failure(_unauthorized),
        HttpStatus.internalServerError => Failure(_internalServer),
        HttpStatus.serviceUnavailable => Failure(_serviceUnavailable),
        HttpStatus.notFound => Failure(_notFound),
        _ => Failure(_unhandledException)
      },
  };
}

bool _socket(Object? error) => error is SocketException;
