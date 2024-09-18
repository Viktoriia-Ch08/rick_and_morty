import 'package:rick_and_morty/domain/entities/location.dart';

class Location extends LocationEntity {
  Location({required name, required url}) : super(name: name, url: url);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson(Location loc) {
    return {'name': loc.name, 'url': loc.url};
  }
}
