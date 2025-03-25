import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

final class Repositories {
  const Repositories._();

  static final planets = Provider<IPlanetsRepository>(
    (ref) => PlanetsRepository(
      remoteDatasource: ref.read(DataSources.planetsRemote),
      localDatasource: ref.read(DataSources.planetsLocal),
    ),
  );
}
