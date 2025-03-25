class Planet {
  Planet({
    required this.id,
    required this.name,
    required this.highlight,
    required this.image,
    required this.orbitalDistanceKm,
    required this.equatorialRadiusKm,
    required this.volumeKm3,
    required this.massKg,
    required this.densityGCm3,
    required this.surfaceGravityMS2,
    required this.escapeVelocityKmh,
    required this.dayLengthEarthDays,
    required this.yearKengthEarthDays,
    required this.orbitalSpeedKmh,
    required this.moons,
    required this.atmosphereComposition,
    required this.description,
    this.favorite = false,
  });

  final String id;
  final String name;
  final String highlight;
  final String image;
  final int? orbitalDistanceKm;
  final int? equatorialRadiusKm;
  final String? volumeKm3;
  final String? massKg;
  final double? densityGCm3;
  final double? surfaceGravityMS2;
  final int? escapeVelocityKmh;
  final double? dayLengthEarthDays;
  final int? yearKengthEarthDays;
  final int? orbitalSpeedKmh;
  final int? moons;
  final String? atmosphereComposition;
  final String? description;
  final bool favorite;

  Planet copyWith({bool? favorite}) => Planet(
        id: id,
        name: name,
        highlight: highlight,
        image: image,
        orbitalDistanceKm: orbitalDistanceKm,
        equatorialRadiusKm: equatorialRadiusKm,
        volumeKm3: volumeKm3,
        massKg: massKg,
        densityGCm3: densityGCm3,
        surfaceGravityMS2: surfaceGravityMS2,
        escapeVelocityKmh: escapeVelocityKmh,
        dayLengthEarthDays: dayLengthEarthDays,
        yearKengthEarthDays: yearKengthEarthDays,
        orbitalSpeedKmh: orbitalSpeedKmh,
        moons: moons,
        atmosphereComposition: atmosphereComposition,
        description: description,
        favorite: favorite ?? this.favorite,
      );
}
