import 'package:flutter/material.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:planets/i18n/translations.g.dart';

class PlanetLoadedState extends StatelessWidget {
  const PlanetLoadedState({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        PlanetsResponsiveScreen(
          mobile: PlanetInfo(planet: planet, direction: Axis.vertical),
          tablet: PlanetInfo(planet: planet),
          desktop: PlanetInfo(
            planet: planet,
            height: context.planetsSize.height * .48,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          context.texts.planets.details.moreAbout(planet: planet.name),
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          planet.description ?? '',
          style: textTheme.titleMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
