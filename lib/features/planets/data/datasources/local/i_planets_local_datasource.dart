import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

abstract interface class IPlanetsLocalDatasource {
  FutureLocalStorageRequest<List<PlanetModel>?> all();
  FutureLocalStorageRequest<PlanetModel?> byId(String id);
  FutureVoidLocalStorageRequest saveAll(List<PlanetModel> planets);
  FutureVoidLocalStorageRequest save(PlanetModel planet);
}
