import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Time {
  String time;

  void setupTime() async {
    Response response =
        await get('http://worldtimeapi.org/api/timezone/Asia/Kolkata');
    Map timeData = jsonDecode(response.body);
    String datetime = timeData['datetime'];
    String offset = timeData['utc_offset'];
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(
        hours: int.parse(offset.substring(1, 3)),
        minutes: int.parse(offset.substring(4, 6))));
    time = DateFormat.jm().format(now);
  }
}
