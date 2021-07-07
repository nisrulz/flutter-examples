import 'package:covid19_mobile_app/resources/fetch_data_functions.dart';
import 'package:covid19_mobile_app/widgets/foldable_cell_widgets.dart';

import '../screens/searchCountry.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:folding_cell/folding_cell.dart';

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> results;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Affected Countries"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CountrySearchDelegate(results),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAllCountriesData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasError)
            return Center(
              child: Text("Error! please check you wifi connection"),
            );
          results = jsonDecode(snapshot.data);
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) {
              var _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
              return Container(
                color: Color(0xFF2e282a),
                alignment: Alignment.topCenter,
                child: SimpleFoldingCell(
                  key: _foldingCellKey,
                  frontWidget: Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          SimpleFoldingCellState foldingCellState =
                              context.findAncestorStateOfType();
                          foldingCellState?.toggleFold();
                        },
                        child: Container(
                            color: Color(0xff000000),
                            child: buildFrontWidget(
                                context,
                                results[index]['countryInfo']['flag'],
                                results[index]['country'],
                                results[index]['cases'].toString())),
                      );
                    },
                  ),
                  innerTopWidget: buildInnerTopWidget(
                    results[index]['country'],
                    results[index]['todayCases'].toString(),
                    results[index]['deaths'].toString(),
                    results[index]['todayDeaths'].toString(),
                    results[index]['recovered'].toString(),
                    results[index]['critical'].toString(),
                    results[index]['casesPerOneMillion'].toString(),
                  ),
                  innerBottomWidget: buildInnerBottomWidget(
                      results[index]['cases'].toString()),
                  cellSize: Size(MediaQuery.of(context).size.width, 125),
                  padding: EdgeInsets.all(15),
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: 10,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
