import 'package:rick_and_morty/feature/domain/entities/location.dart';

class Location extends LocationEntity {
  Location({required name, required url}) : super(name: name, url: url);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
