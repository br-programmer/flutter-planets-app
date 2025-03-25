import 'package:planets/core/core.dart';

FutureLocalStorageRequest<T> performLocalStorageRequest<T>(
  FutureLocalStorageResult<T> future,
) async {
  final result = await future;
  return switch (result) {
    LocalStorageSuccess(:final data) => Success(data),
    LocalStorageFailure(:final code, :final error) => switch (code) {
        'read' => Failure(const ReadFailure()),
        'write' => Failure(const WriteFailure()),
        'update' => Failure(const UpdateFailure()),
        'delete' => Failure(const DeleteFailure()),
        _ => Failure(UnhandledStorageFailure(error)),
      },
  };
}
