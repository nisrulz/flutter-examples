import '../screens/searchCountry.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:folding_cell/folding_cell.dart';

class CountryList extends StatelessWidget {
  Future getAllCountriesData() async {
    try {
      var url = 'https://corona.lmao.ninja/v2/countries?sort=country';
      var response = await http.get(url);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  Widget _buildFrontWidget(
      BuildContext context, String flagUrl, String country, String cases) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
              child: Image.network(
            flagUrl,
            width: MediaQuery.of(context).size.width * 0.2,
            fit: BoxFit.cover,
          )),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Country: $country",
                ),
                Text("Total Cases: $cases"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnerTopWidget(String country, String todayCases, String deaths,
      String todayDeaths, String recovered, String critical, String cpm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Color(0xfff44e3f),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            country,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Today Cases: $todayCases",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Deaths: $deaths",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Cases/Million: $cpm",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Recovered: $recovered",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Today Deaths: $todayDeaths",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Critical: $critical",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInnerBottomWidget(String cases) {
    return Builder(builder: (context) {
      return Container(
        color: Color(0xfff44e3f),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Text(
              "Total Cases:\n$cases",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            )),
            FlatButton(
              onPressed: () {
                SimpleFoldingCellState foldingCellState = context
                    .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
                foldingCellState?.toggleFold();
              },
              child: Text(
                "Close",
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              splashColor: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      );
      Container(
        color: Color(0xfff44e3f),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FlatButton(
            onPressed: () {
              SimpleFoldingCellState foldingCellState = context
                  .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
              foldingCellState?.toggleFold();
            },
            child: Text(
              "Close",
            ),
            color: Colors.black,
            shape: StadiumBorder(),
            splashColor: Colors.white.withOpacity(0.5),
          ),
        ),
      );
    });
  }

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
                              context.ancestorStateOfType(
                                  TypeMatcher<SimpleFoldingCellState>());
                          foldingCellState?.toggleFold();
                        },
                        child: Container(
                            color: Color(0xff000000),
                            child: _buildFrontWidget(
                                context,
                                results[index]['countryInfo']['flag'],
                                results[index]['country'],
                                results[index]['cases'].toString())),
                      );
                    },
                  ),
                  innerTopWidget: _buildInnerTopWidget(
                    results[index]['country'],
                    results[index]['todayCases'].toString(),
                    results[index]['deaths'].toString(),
                    results[index]['todayDeaths'].toString(),
                    results[index]['recovered'].toString(),
                    results[index]['critical'].toString(),
                    results[index]['casesPerOneMillion'].toString(),
                  ),
                  innerBottomWidget: _buildInnerBottomWidget(
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
