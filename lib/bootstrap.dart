import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planets/core/core.dart';
import 'package:planets/i18n/translations.g.dart';

Future<void> bootstrap(Environment env) async {
  final enableLogging = env.enableLogging;
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await LocaleSettings.useDeviceLocale();
      GoRouter.optionURLReflectsImperativeAPIs = true;

      final appDir = switch (kIsWeb) {
        true => Directory('local-storage'),
        false => await getApplicationSupportDirectory(),
      };

      final localStorage = LocalStorage(
        enableLogging: enableLogging,
        dbPath: join(appDir.path, 'planets.db'),
      );
      final planets = TranslationProvider(
        child: ProviderScope(
          overrides: [
            Providers.env.overrideWithValue(env),
            Providers.localStorage.overrideWithValue(localStorage),
          ],
          child: const Planets(),
        ),
      );
      runApp(planets);
      FlutterError.onError = (details) {
        if (enableLogging) {
          log(details.exceptionAsString(), stackTrace: details.stack);
        }
      };
    },
    (error, stack) {
      if (enableLogging) {
        log(error.toString(), stackTrace: stack);
      }
    },
  );
}
