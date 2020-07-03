import 'package:unit_testing/api/Places.dart';
import 'package:unit_testing/model/location.dart';

class TouristPlaces {
  static Future<List<Location>> getData() async {
    // Here we can call a real API.
    return await PlacesAPI().fetchAllPlaces();
  }
}
