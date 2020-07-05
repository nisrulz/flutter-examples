import 'lat_long.dart';

class Location {
  final int id;
  final String name;
  final String image;
  final LatLong latlong;
  final String country;
  final String info;
  Location({
    this.id,
    this.name,
    this.image,
    this.latlong,
    this.country,
    this.info,
  });
}
