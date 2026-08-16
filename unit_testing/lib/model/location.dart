import 'lat_long.dart';

class Location {
  final int id;
  final String name;
  final String image;
  final LatLong latlong;
  final String country;
  final String info;
  Location({
    required this.id,
    required this.name,
    required this.image,
    required this.latlong,
    required this.country,
    required this.info,
  });
}
