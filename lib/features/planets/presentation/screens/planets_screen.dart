import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/features/features.dart';
import 'package:planets/i18n/translations.g.dart';

final queryNotifier = StateProvider((_) => '');

class PlanetsScreen extends ConsumerWidget {
  const PlanetsScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const PlanetsScreen._();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planets = context.texts.planets;
    return Scaffold(
      appBar: AppBar(
        title: Text(planets.title),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SearchPlanet(),
          const SizedBox(height: 4),
          Expanded(
            child: switch (ref.watch(planetsProvider)) {
              PlanetsLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              PlanetsLoaded(:final planets) => PlanetsLoadedState(
                  planets: planets,
                ),
              PlanetsError() => Center(child: Text(planets.error)),
            },
          ),
        ],
      ),
    );
  }
}
