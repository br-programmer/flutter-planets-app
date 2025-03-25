import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

extension on Planet {
  bool matches(String query) {
    return name.toLowerCase().contains(query) ||
        highlight.toLowerCase().contains(query);
  }
}

class PlanetsLoadedState extends ConsumerWidget {
  const PlanetsLoadedState({super.key, required this.planets});

  final List<Planet> planets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(queryNotifier).toLowerCase();
    final planets = this.planets.where((p) => p.matches(query)).toList();
    return PlanetsResponsiveScreen(
      mobile: PlanetsList(planets: planets),
      tablet: PlanetsGrid(planets: planets, crossAxisCount: 4),
      desktop: PlanetsGrid(planets: planets, crossAxisCount: 5),
    );
  }
}
