import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/location.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  const CharacterEntity(
      {required this.id,
      required this.name,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.episode,
      required this.url,
      required this.created});

  @override
  List<Object> get props => [
        id,
        name,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
      ];
}
