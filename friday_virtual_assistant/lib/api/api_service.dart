import 'dart:convert';
import 'package:friday_virtual_assistant/api_key.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future requestOpenAI(String userInput, String mode, int maximumTokens) async {
    const String url = "https://api.openai.com/";
    final String openAiApiUrl =
        mode == "chat" ? "v1/completions" : "v1/images/generations";

    final body = mode == "chat"
        ? {
            "model": "gpt-3.5-turbo-instruct",
            "prompt": userInput,
            "max_tokens": 7,
            "temperature": 0,
            "n": 1,
          }
        : {
            "prompt": userInput,
          };

    try {
      final responseFromOpenAPI = await http.post(
        Uri.parse(url + openAiApiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apikey"
        },
        body: jsonEncode(body),
      );
      print("!11111");
      print(jsonDecode(responseFromOpenAPI.body));
      print("!22222");
      return responseFromOpenAPI;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
