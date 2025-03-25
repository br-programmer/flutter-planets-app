import 'package:planets/core/core.dart';

typedef Json = Map<String, dynamic>;

typedef VoidResult<E> = Result<void, E>;
typedef FutureVoidResult<E> = Future<Result<void, E>>;
typedef FutureResult<T, E> = Future<Result<T, E>>;
typedef FutureHttpRequest<T> = Future<Result<T, HttpRequestFailure>>;
typedef FutureVoidHttpRequest = Future<Result<void, HttpRequestFailure>>;
typedef FutureLocalStorageRequest<T> = Future<Result<T, StorageFailure>>;
typedef FutureVoidLocalStorageRequest = Future<Result<void, StorageFailure>>;
