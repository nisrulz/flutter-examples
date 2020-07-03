import 'package:flutter/material.dart';
import 'package:unit_testing/components/place_info_card.dart';
import 'package:unit_testing/model/location.dart';

import '../helpers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Test'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: TouristPlaces.getData(), // this functions calls API.
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final List<Location> data = snapshot.data;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) => PlaceInfo(
                data: data[index],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
