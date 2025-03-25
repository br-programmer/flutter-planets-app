import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planets/core/core.dart';
import 'package:planets/features/features.dart';

part 'planet_model.freezed.dart';
part 'planet_model.g.dart';

@freezed
class PlanetModel with _$PlanetModel, EntityConvertible<Planet> {
  @JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
  factory PlanetModel({
    required String id,
    required String name,
    required String highlight,
    required String image,
    int? orbitalDistanceKm,
    int? equatorialRadiusKm,
    String? volumeKm3,
    String? massKg,
    double? densityGCm3,
    double? surfaceGravityMS2,
    int? escapeVelocityKmh,
    double? dayLengthEarthDays,
    int? yearKengthEarthDays,
    int? orbitalSpeedKmh,
    int? moons,
    String? atmosphereComposition,
    String? description,
    @Default(false) bool favorite,
  }) = _PlanetModel;

  factory PlanetModel.fromEntity(Planet entity) {
    return PlanetModel(
      id: entity.id,
      name: entity.name,
      highlight: entity.highlight,
      image: entity.image,
      orbitalDistanceKm: entity.orbitalDistanceKm,
      equatorialRadiusKm: entity.equatorialRadiusKm,
      volumeKm3: entity.volumeKm3,
      massKg: entity.massKg,
      densityGCm3: entity.densityGCm3,
      surfaceGravityMS2: entity.surfaceGravityMS2,
      escapeVelocityKmh: entity.escapeVelocityKmh,
      dayLengthEarthDays: entity.dayLengthEarthDays,
      yearKengthEarthDays: entity.yearKengthEarthDays,
      moons: entity.moons,
      atmosphereComposition: entity.atmosphereComposition,
      description: entity.description,
      favorite: entity.favorite,
    );
  }

  PlanetModel._();

  factory PlanetModel.fromJson(Map<String, dynamic> json) =>
      _$PlanetModelFromJson(json);

  @override
  Planet toEntity() => Planet(
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
        favorite: favorite,
      );
}
