import 'package:unit_testing/model/lat_long.dart';
import 'package:unit_testing/model/location.dart';

class PlacesAPI {
  final List<Location> _locations = [
    Location(
      id: 1,
      name: "Kumarakom Backwaters",
      country: "India",
      info: "Kerala’s scenic backwaters, "
          "edged with coconut palms, "
          "lush green rice paddies and picturesque villages,"
          "make for a beautiful escape from hectic city life.",
      image: "assets/1.jpeg",
      latlong: LatLong(
        latitude: 9.9540358,
        longitude: 76.2671037,
      ),
    ),
    Location(
      id: 2,
      name: "Angel Falls",
      country: "Venezuela",
      info: "Venezuela overflows with natural wonders, "
          "including the world's highest waterfall—the 3,212-foot cascades of Angel Falls,"
          " located in the UNESCO-protected Canaima National Park. "
          "Canaima is by far the country's most popular attraction,"
          " and the falls stretch an astounding 19 times higher than Niagara Falls. ",
      image: "assets/2.jpg",
      latlong: LatLong(
        latitude: 5.9689135,
        longitude: -62.5376132,
      ),
    ),
    Location(
      id: 3,
      name: "Avenue of the Baobabs",
      country: "Madagascar",
      info:
          "Separated from continental Africa by 250 miles of water, Madagascar "
          "is the greatest adventure"
          " you haven't had yet. The island nation's secrets include giant moths, "
          "bug-eyed lemurs, and places like the surreal Avenue of the Baobabs,"
          " where the centuries-old trees reach heights of nearly 100 feet.",
      image: "assets/3.jpg",
      latlong: LatLong(
        latitude: -20.2498059,
        longitude: 44.4172047,
      ),
    ),
    Location(
      id: 4,
      name: "Denali National Park",
      country: " Alaska",
      info: "Despite controversies over name changes and a shrinking elevation,"
          " Denali's beauty is worth braving the extreme low temperatures. Make a "
          "road trip out of your visit, seeing as "
          "much of the 6 million acres of shimmering lakes and jagged mountains as you can.",
      image: "assets/4.jpg",
      latlong: LatLong(
        latitude: 63.2092486,
        longitude: -152.2366999,
      ),
    ),
  ];

  Future<List<Location>> fetchAllPlaces() {
    return Future.delayed(Duration(seconds: 3), () {
      return _locations;
    });
  }
}
