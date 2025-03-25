import 'package:planets/core/shared/shared.dart';
import 'package:planets/features/features.dart';

abstract interface class IPlanetsRemoteDatasource {
  FutureHttpRequest<List<PlanetModel>> all();
  FutureHttpRequest<PlanetModel> byId(String id);
}
