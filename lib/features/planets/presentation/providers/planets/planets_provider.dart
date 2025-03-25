import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:riverpod/riverpod.dart';

part 'planets_state.dart';

final planetsProvider = NotifierProvider<PlanetsProvider, PlanetsState>(
  PlanetsProvider.new,
);

class PlanetsProvider extends Notifier<PlanetsState> {
  late final IPlanetsRepository _planetsRepository;

  @override
  PlanetsState build() {
    _planetsRepository = ref.read(Repositories.planets);
    all();
    return const PlanetsLoading();
  }

  Future<void> all() async {
    final result = await _planetsRepository.all();
    state = switch (result) {
      Success(:final data) => PlanetsLoaded(data),
      Failure(:final error) => PlanetsError(error),
    };
  }

  Future<void> favoriteFlow(String planetId, bool favorite) async {
    final planets = switch (state) {
      PlanetsLoaded(:final planets) => planets,
      _ => <Planet>[],
    };

    final index = planets.indexWhere((p) => p.id == planetId);
    if (index == -1 || planets[index].favorite == favorite) return;

    final updatedPlanets = [
      ...planets.sublist(0, index),
      planets[index].copyWith(favorite: favorite),
      ...planets.sublist(index + 1),
    ];

    state = PlanetsLoaded(updatedPlanets);

    final result = await _planetsRepository.saveAll(updatedPlanets);
    state = switch (result) {
      Success() => state,
      Failure() => PlanetsLoaded(planets),
    };
  }
}
