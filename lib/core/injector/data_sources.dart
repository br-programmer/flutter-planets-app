import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:riverpod/riverpod.dart';

final class DataSources {
  const DataSources._();

  static final planetsLocal = Provider<IPlanetsLocalDatasource>(
    (ref) => PlanetsLocalDatasource(
      localStorage: ref.read(Providers.localStorage),
    ),
  );

  static final planetsRemote = Provider<IPlanetsRemoteDatasource>(
    (ref) => PlanetsRemoteDatasource(http: ref.read(Providers.http)),
  );
}
