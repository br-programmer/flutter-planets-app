import 'package:planets/core/core.dart';
import 'package:planets/core/shared/data/http/perform_http_request.dart';
import 'package:planets/features/features.dart';

class PlanetsRemoteDatasource implements IPlanetsRemoteDatasource {
  PlanetsRemoteDatasource({required Http http}) : _http = http;

  final Http _http;

  @override
  FutureHttpRequest<List<PlanetModel>> all() {
    return performHttpRequest(
      _http.send(
        APIPaths.all,
        parser: (_, list) => (list as List)
            .mapList((json) => PlanetModel.fromJson(json as Json)),
      ),
    );
  }

  @override
  FutureHttpRequest<PlanetModel> byId(String id) {
    return performHttpRequest(
      _http.send(
        APIPaths.byId(id),
        parser: (_, json) => PlanetModel.fromJson(json as Json),
      ),
    );
  }
}
