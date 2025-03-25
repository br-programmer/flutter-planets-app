import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

class PlanetsLocalDatasource implements IPlanetsLocalDatasource {
  PlanetsLocalDatasource({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  FutureLocalStorageRequest<List<PlanetModel>?> all() {
    return performLocalStorageRequest(
      _localStorage.send(
        StoresName.all,
        StoresKey.all,
        parser: (list) => (list as List<dynamic>?)
            ?.mapList((json) => PlanetModel.fromJson(json as Json)),
      ),
    );
  }

  @override
  FutureLocalStorageRequest<PlanetModel?> byId(String id) {
    return performLocalStorageRequest(
      _localStorage.send(
        StoresName.one,
        id,
        parser: (json) => switch (json) {
          final Json data => PlanetModel.fromJson(data),
          _ => null,
        },
      ),
    );
  }

  @override
  FutureVoidLocalStorageRequest save(PlanetModel planet) {
    return performLocalStorageRequest(
      _localStorage.send(
        StoresName.one,
        planet.id,
        value: planet.toJson(),
        parser: (_) {},
        method: LocalStorageMethod.write,
      ),
    );
  }

  @override
  FutureVoidLocalStorageRequest saveAll(List<PlanetModel> planets) {
    return performLocalStorageRequest(
      _localStorage.send(
        StoresName.all,
        StoresKey.all,
        value: planets.mapList((planet) => planet.toJson()),
        parser: (_) {},
        method: LocalStorageMethod.write,
      ),
    );
  }
}
