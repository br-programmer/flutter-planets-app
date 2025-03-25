import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

class PlanetsGrid extends StatelessWidget {
  const PlanetsGrid({
    super.key,
    required this.planets,
    required this.crossAxisCount,
  });

  final List<Planet> planets;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: planets.length,
      itemBuilder: (_, index) => PlanetGridItem(planet: planets[index]),
    );
  }
}

class PlanetGridItem extends ConsumerWidget {
  const PlanetGridItem({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      child: InkWell(
        onTap: () => context.pushNamed(
          PlanetsRoutes.planet.name,
          pathParameters: {'id': planet.id},
          extra: {'favorite': planet.favorite},
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(child: PlanetsImage(imageUrl: planet.image)),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(planet.name, style: context.textTheme.bodyLarge),
                        Text(
                          planet.highlight,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  FavoriteIcon(
                    favorite: planet.favorite,
                    onPressed: () {
                      ref.read(planetsProvider.notifier).favoriteFlow(
                            planet.id,
                            !planet.favorite,
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
