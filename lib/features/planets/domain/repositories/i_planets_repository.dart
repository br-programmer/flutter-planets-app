import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

abstract interface class IPlanetsRepository {
  FutureResult<List<Planet>, PlanetException> all();
  FutureResult<Planet, PlanetException> byId(String id, bool? favorite);
  FutureVoidResult<PlanetException> saveAll(List<Planet> planets);
  FutureVoidResult<PlanetException> save(Planet planet);
}
