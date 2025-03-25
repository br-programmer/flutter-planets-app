/// Represents all possible failures when accessing local storage.
sealed class StorageFailure {
  const StorageFailure();
}

/// Failure when reading from local storage.
final class ReadFailure extends StorageFailure {
  const ReadFailure();
}

/// Failure when writing to local storage.
final class WriteFailure extends StorageFailure {
  const WriteFailure();
}

/// Failure when updating local storage.
final class UpdateFailure extends StorageFailure {
  const UpdateFailure();
}

/// Failure when deleting from local storage.
final class DeleteFailure extends StorageFailure {
  const DeleteFailure();
}

/// Unhandled or unknown local storage failure.
final class UnhandledStorageFailure extends StorageFailure {
  const UnhandledStorageFailure(this.error);
  final Object error;
}
