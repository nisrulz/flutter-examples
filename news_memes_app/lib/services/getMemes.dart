import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> showMemes() async {
  Uri uri = Uri.parse('https://meme-api.herokuapp.com/gimme/10');
  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print(response.body);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> memes = map['memes'];
    List<dynamic> memeUrls =
        memes.map((e) => e['preview'][e['preview'].length - 1]).toList();
    return memeUrls;
  } else {
    print('Error - ${response.statusCode}');
    return [''];
  }
}
