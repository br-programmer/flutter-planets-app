import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:riverpod/riverpod.dart';

part 'planet_state.dart';

final planetProvider = NotifierProvider.autoDispose
    .family<PlanetProvider, PlanetState, PlanetArgs>(
  PlanetProvider.new,
);

class PlanetProvider
    extends AutoDisposeFamilyNotifier<PlanetState, PlanetArgs> {
  late final PlanetArgs _args;
  late final IPlanetsRepository _repository;

  @override
  PlanetState build(PlanetArgs args) {
    _args = args;
    _repository = ref.read(Repositories.planets);
    byId();
    return const PlanetLoading();
  }

  Future<void> byId() async {
    final result = await _repository.byId(
      _args.planetId,
      _args.favorite,
    );
    state = switch (result) {
      Success(:final data) => PlanetLoaded(data),
      Failure(:final error) => PlanetError(error),
    };
  }

  Future<void> favoriteFlow() async {
    final planet = switch (state) {
      PlanetLoaded(:final planet) => planet,
      _ => null,
    };
    if (planet == null) return;
    final newPlanet = planet.copyWith(favorite: !planet.favorite);
    state = PlanetLoaded(newPlanet);
    final result = await _repository.save(newPlanet);
    state = switch (result) {
      Success() => state,
      Failure() => PlanetLoaded(planet),
    };
  }
}
