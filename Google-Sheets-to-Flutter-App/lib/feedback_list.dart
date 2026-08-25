import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'form.dart';

class FormController {

  // Google App Script Web URL.
  static const String URL = "YOUR LINK";

  Future<List<FeedbackForm>> getFeedbackList() async {
    final response = await http
        .get(Uri.parse(URL));
    if (response.statusCode == 200) {

      var jsonFeedback = jsonDecode(response.body.toString()) as List;
      print(jsonFeedback.toString());

      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load album');
    }
  }
}

