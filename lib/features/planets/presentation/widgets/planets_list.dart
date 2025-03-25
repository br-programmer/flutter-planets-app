import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

class PlanetsList extends StatelessWidget {
  const PlanetsList({super.key, required this.planets});

  final List<Planet> planets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: planets.length,
      itemBuilder: (_, index) => PlanetListItem(planet: planets[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class PlanetListItem extends ConsumerWidget {
  const PlanetListItem({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: SizedBox.square(
          dimension: 60,
          child: PlanetsImage(imageUrl: planet.image),
        ),
        title: Text(planet.name),
        trailing: FavoriteIcon(
          favorite: planet.favorite,
          onPressed: () {
            ref.read(planetsProvider.notifier).favoriteFlow(
                  planet.id,
                  !planet.favorite,
                );
          },
        ),
        subtitle: Text(planet.highlight),
        onTap: () => context.pushNamed(
          PlanetsRoutes.planet.name,
          pathParameters: {'id': planet.id},
          extra: {'favorite': planet.favorite},
        ),
      ),
    );
  }
}
