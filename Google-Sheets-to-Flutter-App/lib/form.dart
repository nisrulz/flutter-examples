import 'dart:convert';

import 'package:http/http.dart' as http;


class FeedbackForm {
 String name;
  String number;
  String member;
  String type;
  String Village;
  String MobileNo1;
  String MobileNo2;

  FeedbackForm( this.number,this.name, this.member, this.type,this.Village,this.MobileNo1,this.MobileNo2);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm( "${json['Number']}","${json['name']}",
        "${json['Member']}", "${json['Type']}","${json['Village']}","${json['Mobile No.1']}","${json['Mobile No.2']}");
  }

  // Method to make GET parameters.
  Map toJson(String s) => {
    'Name': name,
    'Number': int.parse(number),
    'Member': int.parse(member),
    'Type': type.toString(),
    'Village': Village,
    'MobileNo1': int.parse(MobileNo1),
    'MobileNo2': int.parse(MobileNo2),

  };
}



