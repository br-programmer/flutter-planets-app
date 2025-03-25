/// A sealed class representing a result that can either be a success or a failure.
///
/// - `T`: The type of the data in case of success.
/// - `E`: The type of the error in case of failure.
sealed class Result<T, E> {}

/// A class representing a successful result, containing the data of type `T`.
///
/// - `T`: The type of the data returned in the success case.
class Success<T, E> extends Result<T, E> {
  Success(this.data);
  final T data;
}

/// A class representing a failure result, containing the error of type `E`.
///
/// - `E`: The type of the error returned in the failure case.
class Failure<T, E> extends Result<T, E> {
  Failure(this.error);
  final E error;
}
