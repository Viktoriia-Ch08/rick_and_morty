import 'package:rick_and_morty/feature/data/models/location.dart';
import 'package:rick_and_morty/feature/domain/entities/character.dart';

class Character extends CharacterEntity {
  const Character(
      {required id,
      required status,
      required name,
      required species,
      required type,
      required gender,
      required origin,
      required location,
      required image,
      // required episode,
      required url,
      required created})
      : super(
          id: id,
          status: status,
          name: name,
          species: species,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          // episode: episode,
          url: url,
          created: created,
        );

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        status: json['status'],
        name: json['name'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin:
            json['origin'] != null ? Location.fromJson(json['origin']) : null,
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        image: json['image'],
        // episode: (json['episode'] as List<dynamic>).map((el) => el as String),
        url: json['url'],
        created: json['created']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'name': name,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': Location(name: origin.name, url: origin.url).toJson(),
      'location': Location(name: location.name, url: location.url).toJson(),
      'image': image,
      // 'episode': episode,
      'url': url,
      'created': created
    };
  }
}
