import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:planets/core/core.dart';
import 'package:sembast/sembast_io.dart' as sembast_io;
import 'package:sembast_web/sembast_web.dart';

export 'constants/constants.dart';
export 'failures/failures.dart';
export 'local_storage_result.dart';
export 'perform_local_storage_request.dart';

enum LocalStorageMethod { read, write, update, delete }

class LocalStorage {
  LocalStorage({required bool enableLogging, required String dbPath})
      : _enableLogging = enableLogging,
        _dbPath = dbPath;

  final bool _enableLogging;
  final String _dbPath;
  Database? _db;

  FutureLocalStorageResult<T> send<T>(
    String storeName,
    String key, {
    dynamic value,
    required T Function(dynamic data) parser,
    LocalStorageMethod method = LocalStorageMethod.read,
  }) async {
    try {
      _db ??= switch (kIsWeb) {
        true => await databaseFactoryWeb.openDatabase(_dbPath),
        false => await sembast_io.databaseFactoryIo.openDatabase(_dbPath),
      };
      final store = StoreRef<String, dynamic>(storeName);
      final future = switch (method) {
        LocalStorageMethod.read => () => store.record(key).get(_db!),
        LocalStorageMethod.write => () => store.record(key).put(_db!, value),
        LocalStorageMethod.update => () => store.record(key).put(_db!, value),
        LocalStorageMethod.delete => () => store.record(key).delete(_db!),
      };
      final data = await future();
      if (_enableLogging) {
        log(
          const JsonEncoder.withIndent(' ').convert({
            'action': method.name,
            'store': storeName,
            'key': key,
            'value': value,
            'response': data,
          }),
        );
      }
      return LocalStorageResult.success(parser(data));
    } catch (e, s) {
      if (_enableLogging) {
        log(e.toString(), stackTrace: s);
      }
      return LocalStorageResult.failed(method.name, e);
    }
  }
}
