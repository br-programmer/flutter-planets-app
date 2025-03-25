sealed class LocalStorageResult<T> {
  const LocalStorageResult();

  factory LocalStorageResult.success(T data) = LocalStorageSuccess<T>;
  factory LocalStorageResult.failed(String code, Object error) =
      LocalStorageFailure<T>;
}

final class LocalStorageSuccess<T> extends LocalStorageResult<T> {
  const LocalStorageSuccess(this.data);
  final T data;
}

final class LocalStorageFailure<T> extends LocalStorageResult<T> {
  const LocalStorageFailure(this.code, this.error);
  final String code;
  final Object error;
}

typedef FutureLocalStorageResult<T> = Future<LocalStorageResult<T>>;
