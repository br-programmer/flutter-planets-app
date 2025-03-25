part of 'planet_provider.dart';

sealed class PlanetState {
  const PlanetState();
}

class PlanetLoading extends PlanetState {
  const PlanetLoading();
}

class PlanetLoaded extends PlanetState {
  const PlanetLoaded(this.planet);
  final Planet planet;
}

class PlanetError extends PlanetState {
  const PlanetError(this.exception);

  final PlanetException exception;
}
