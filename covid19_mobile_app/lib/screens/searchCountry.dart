import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class CountrySearchDelegate extends SearchDelegate {
  List<dynamic> results;
  CountrySearchDelegate(this.results);

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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionsList = results
        .where((element) => element['country']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: suggestionsList.length,
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
                          suggestionsList[index]['countryInfo']['flag'],
                          suggestionsList[index]['country'],
                          suggestionsList[index]['cases'].toString())),
                );
              },
            ),
            innerTopWidget: _buildInnerTopWidget(
              suggestionsList[index]['country'],
              suggestionsList[index]['todayCases'].toString(),
              suggestionsList[index]['deaths'].toString(),
              suggestionsList[index]['todayDeaths'].toString(),
              suggestionsList[index]['recovered'].toString(),
              suggestionsList[index]['critical'].toString(),
              suggestionsList[index]['casesPerOneMillion'].toString(),
            ),
            innerBottomWidget: _buildInnerBottomWidget(
                suggestionsList[index]['cases'].toString()),
            cellSize: Size(MediaQuery.of(context).size.width, 125),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
          ),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Search Country';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      textTheme: Theme.of(context).textTheme.apply(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = results
        .where((element) => element['country']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: suggestionsList.length,
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
                          suggestionsList[index]['countryInfo']['flag'],
                          suggestionsList[index]['country'],
                          suggestionsList[index]['cases'].toString())),
                );
              },
            ),
            innerTopWidget: _buildInnerTopWidget(
              suggestionsList[index]['country'],
              suggestionsList[index]['todayCases'].toString(),
              suggestionsList[index]['deaths'].toString(),
              suggestionsList[index]['todayDeaths'].toString(),
              suggestionsList[index]['recovered'].toString(),
              suggestionsList[index]['critical'].toString(),
              suggestionsList[index]['casesPerOneMillion'].toString(),
            ),
            innerBottomWidget: _buildInnerBottomWidget(
                suggestionsList[index]['cases'].toString()),
            cellSize: Size(MediaQuery.of(context).size.width, 125),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 10,
          ),
        );
      },
    );
  }
}
