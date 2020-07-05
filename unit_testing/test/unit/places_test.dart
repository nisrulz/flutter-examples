import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/helpers.dart';
import 'package:unit_testing/model/location.dart';

void main() {
  test(
    "fetched places",
    () async {
      print("test is running");
      print("called API for feching Locations");
      final places = await TouristPlaces.getData();
      expect(places.length, greaterThan(0));

      for (var i in places) {
        final Location place = i;
        expect(place.id, isNotNull);
      }
    },
  );
}
