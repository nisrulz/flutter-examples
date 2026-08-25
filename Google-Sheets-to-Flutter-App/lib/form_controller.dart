import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {

  // Google App Script Web URL.

  static const String URL = "YOUR LINK";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";


  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {

      await http.get(Uri.parse(URL)).then((response) async {
            callback(convert.jsonDecode(response.body)['status']);
          });
        }
     catch (e) {
      print(e);
    }
  }
}