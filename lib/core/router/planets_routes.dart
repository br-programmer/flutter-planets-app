enum PlanetsRoutes {
  home._(name: 'Home', path: '/'),
  planets._(name: 'Planets', path: '/planets'),
  planet._(name: 'Planet', path: ':id');

  const PlanetsRoutes._({required this.name, required this.path});
  final String name;
  final String path;
}
