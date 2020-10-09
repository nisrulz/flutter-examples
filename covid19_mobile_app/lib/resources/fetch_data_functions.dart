import 'dart:convert';
import 'package:http/http.dart' as http;

// function to fetch global Corona Virus(all countries together)
// to fetch data of a particular country(in this case, India)
Future getAllData() async {
  try {
    var allCountriesUrl = 'https://corona.lmao.ninja/v2/all';
    var allCountriesResponse = await http.get(allCountriesUrl);

    var particularCountryUrl = 'https://corona.lmao.ninja/v2/historical/India';
    var particularCountryResponse = await http.get(particularCountryUrl);

    // a list to store the data points
    List<Map<String, dynamic>> dataPoints = [];
    jsonDecode(particularCountryResponse.body)['timeline']['cases']
        .forEach((k, v) {
      List a = k.split('/');
      DateTime b = DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
      dataPoints.add({"date": b, "value": v});
    });
    List<Map<String, dynamic>> dataPoints1 = [];
    jsonDecode(particularCountryResponse.body)['timeline']['deaths']
        .forEach((k, v) {
      List a = k.split('/');
      DateTime b = DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
      dataPoints1.add({"date": b, "value": v});
    });
    List<Map<String, dynamic>> dataPoints2 = [];
    jsonDecode(particularCountryResponse.body)['timeline']['recovered']
        .forEach((k, v) {
      List a = k.split('/');
      DateTime b = DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
      dataPoints2.add({"date": b, "value": v});
    });
    return {
      "all": allCountriesResponse.body,
      "country": dataPoints,
      "deaths": dataPoints1,
      "recovered": dataPoints2
    };
  } catch (e) {
    print(e);
  }
}

// function to fetch data of all countries(country wise)
Future getAllCountriesData() async {
  try {
    var url = 'https://corona.lmao.ninja/v2/countries?sort=country';
    var response = await http.get(url);
    return response.body;
  } catch (e) {
    print(e);
  }
}
