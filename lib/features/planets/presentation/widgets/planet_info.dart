import 'package:flutter/material.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';
import 'package:planets/i18n/translations.g.dart';

class PlanetInfo extends StatelessWidget {
  const PlanetInfo({
    super.key,
    required this.planet,
    this.direction = Axis.horizontal,
    this.height,
  });

  final Planet planet;
  final Axis direction;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final details = context.texts.planets.details;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: PlanetsImage(imageUrl: planet.image, height: height),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          direction: direction,
          children: [
            _PlanetInfoItem(
              label: details.orbitalDistanceKm,
              value: planet.orbitalDistanceKm,
            ),
            _PlanetInfoItem(
              label: details.equatorialRadiusKm,
              value: planet.equatorialRadiusKm,
            ),
            _PlanetInfoItem(
              label: details.volumeKm3,
              value: planet.volumeKm3,
            ),
            _PlanetInfoItem(
              label: details.massKg,
              value: planet.massKg,
            ),
            _PlanetInfoItem(
              label: details.densityGCm3,
              value: planet.densityGCm3,
            ),
            _PlanetInfoItem(
              label: details.surfaceGravityMs2,
              value: planet.surfaceGravityMS2,
            ),
            _PlanetInfoItem(
              label: details.escapeVelocityKmh,
              value: planet.escapeVelocityKmh,
            ),
            _PlanetInfoItem(
              label: details.dayLengthEarthDays,
              value: planet.dayLengthEarthDays,
            ),
            _PlanetInfoItem(
              label: details.yearLengthEarthDays,
              value: planet.yearKengthEarthDays,
            ),
            _PlanetInfoItem(
              label: details.orbitalSpeedKmh,
              value: planet.orbitalSpeedKmh,
            ),
            _PlanetInfoItem(
              label: details.moons(n: planet.moons ?? 0),
              value: planet.moons,
            ),
            _PlanetInfoItem(
              label: details.atmosphereComposition,
              value: planet.atmosphereComposition,
            ),
          ],
        ),
      ],
    );
  }
}

class _PlanetInfoItem extends StatelessWidget {
  const _PlanetInfoItem({required this.label, this.value});
  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.bodyLarge;
    return Text.rich(
      TextSpan(
        text: '$label: ',
        style: style?.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: '${value ?? '-'},',
            style: style?.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
