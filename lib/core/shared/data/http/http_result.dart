sealed class HttpResult<T> {
  factory HttpResult.success(int statusCode, T data) = HttpSuccess<T>;
  factory HttpResult.failed(int? statusCode, Object? data) = HttpFailure<T>;
}

class HttpSuccess<T> implements HttpResult<T> {
  HttpSuccess(this.statusCode, this.data);

  final int statusCode;
  final T data;
}

class HttpFailure<T> implements HttpResult<T> {
  HttpFailure(this.statusCode, this.error);

  final int? statusCode;
  final Object? error;
}

typedef FutureHttpResult<T> = Future<HttpResult<T>>;
