import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:planets/i18n/translations.g.dart';

typedef PlanetArgs = ({String planetId, bool? favorite});

class PlanetScreen extends ConsumerWidget {
  const PlanetScreen._(this.args);
  final PlanetArgs args;

  static Widget builder(BuildContext _, GoRouterState state) {
    final extra = state.extra as Json?;
    final favorite = extra?['favorite'] as bool?;
    final args = (planetId: state.pathParameters['id']!, favorite: favorite);
    return PlanetScreen._(args);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      planetProvider(args),
      (_, state) {
        final callback = switch (state) {
          PlanetLoaded(:final planet) => () {
              ref.read(planetsProvider.notifier).favoriteFlow(
                    planet.id,
                    planet.favorite,
                  );
            },
          _ => null,
        };
        callback?.call();
      },
    );
    final state = ref.watch(planetProvider(args));

    return Scaffold(
      appBar: AppBar(
        title: switch (state) {
          PlanetLoaded(:final planet) => Text(planet.name),
          _ => null,
        },
        actions: [
          FavoriteIcon(
            favorite: switch (state) {
              PlanetLoaded(:final planet) => planet.favorite,
              _ => args.favorite ?? false,
            },
            onPressed: ref.read(planetProvider(args).notifier).favoriteFlow,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: switch (state) {
        PlanetLoading() => const Center(child: CircularProgressIndicator()),
        PlanetLoaded(:final planet) => PlanetLoadedState(planet: planet),
        PlanetError() => Center(
            child: TextButton(
              onPressed: () => context.goNamed(PlanetsRoutes.planets.name),
              child: Text(context.texts.planets.details.notFound),
            ),
          ),
      },
    );
  }
}
