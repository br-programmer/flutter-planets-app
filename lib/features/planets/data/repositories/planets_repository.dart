import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

class PlanetsRepository implements IPlanetsRepository {
  PlanetsRepository({
    required IPlanetsRemoteDatasource remoteDatasource,
    required IPlanetsLocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final IPlanetsRemoteDatasource _remoteDatasource;
  final IPlanetsLocalDatasource _localDatasource;

  @override
  FutureResult<List<Planet>, PlanetException> all() async {
    final localResult = await _localDatasource.all();
    final planetsLocal = switch (localResult) {
      Success(:final data) when data != null => data,
      _ => <PlanetModel>[],
    };
    if (planetsLocal.isNotEmpty) {
      return Success(planetsLocal.mapList((p) => p.toEntity()));
    }
    final remoteResult = await _remoteDatasource.all();
    final (planetsRemote, exception) = switch (remoteResult) {
      Success(:final data) => (data, null),
      Failure(:final error) => switch (error) {
          NotFound() => (null, const PlanetNotFoundException()),
          Unauthorized() => (null, const PlanetUnauthorizedException()),
          _ => (null, const PlanetServerException()),
        },
    };
    if (exception != null) {
      return Failure(exception);
    }
    await _localDatasource.saveAll(planetsRemote!);
    return Success(planetsRemote.mapList((p) => p.toEntity()));
  }

  @override
  FutureResult<Planet, PlanetException> byId(String id, bool? favorite) async {
    final localResult = await _localDatasource.byId(id);

    final planetLocal = switch (localResult) {
      Success(:final data) when data != null => data,
      _ => null,
    };

    if (planetLocal != null) {
      return Success(planetLocal.toEntity());
    }

    final remoteResult = await _remoteDatasource.byId(id);

    final (planetRemote, exception) = switch (remoteResult) {
      Success(:final data) => (
          data.copyWith(favorite: favorite ?? false),
          null
        ),
      Failure(:final error) => switch (error) {
          NotFound() => (null, const PlanetNotFoundException()),
          Unauthorized() => (null, const PlanetUnauthorizedException()),
          _ => (null, const PlanetServerException()),
        },
    };

    if (exception != null) {
      return Failure(exception);
    }

    await _localDatasource.save(planetRemote!);
    return Success(planetRemote.toEntity());
  }

  @override
  FutureVoidResult<PlanetException> saveAll(List<Planet> planets) async {
    final result = await _localDatasource.saveAll(
      planets.mapList((p) => PlanetModel.fromEntity(p)),
    );
    return switch (result) {
      Success() => Success(null),
      Failure() => Failure(const PlanetCacheException()),
    };
  }

  @override
  FutureVoidResult<PlanetException> save(Planet planet) async {
    final result = await _localDatasource.save(PlanetModel.fromEntity(planet));
    return switch (result) {
      Success() => Success(null),
      Failure() => Failure(const PlanetCacheException()),
    };
  }
}
