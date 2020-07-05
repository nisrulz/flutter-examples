import 'package:flutter/material.dart';
import 'package:unit_testing/model/location.dart';

class PlaceInfo extends StatelessWidget {
  final Location data;
  PlaceInfo({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Colors.black45,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.name + "\n" + data.country,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            data.image,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            data.info,
            style: TextStyle(fontSize: 23),
          ),
        ],
      ),
    );
  }
}
