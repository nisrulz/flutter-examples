import 'package:unit_testing/api/Places.dart';
import 'package:unit_testing/model/location.dart';

class TouristPlaces {
  static Future<List<Location>> getData() async {
    // Here we can call a real API.
    return await PlacesAPI().fetchAllPlaces();
  }
}

class FormValidator {
  static String validateEmail(String email) {
    final pattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty) {
      return "please enter email";
    } else if (!pattern.hasMatch(email)) {
      return "please enter valid email";
    } else {
      return null;
    }
  }

  static String validatePassword(String password) {
    if (password.isEmpty) {
      return "please enter your password";
    } else if (password.length < 8) {
      return "minimum lenght of password must be 8 characters";
    } else {
      return null;
    }
  }
}
