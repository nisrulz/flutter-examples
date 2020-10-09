import 'package:covid19_mobile_app/widgets/foldable_cell_widgets.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class CountrySearchDelegate extends SearchDelegate {
  List<dynamic> results;
  CountrySearchDelegate(this.results);

  // to put the 'Clear Icon(X)' in the traling part of the search text field
  // to clear the contents of the text field
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

  // to put the 'Back icon(<-)' in the leading part of the search text field
  // to go back
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  // to build results according to the query
  // it is when the user types something and presses enter
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
                        context.findAncestorStateOfType();
                    foldingCellState?.toggleFold();
                  },
                  child: Container(
                      color: Color(0xff000000),
                      child: buildFrontWidget(
                          context,
                          suggestionsList[index]['countryInfo']['flag'],
                          suggestionsList[index]['country'],
                          suggestionsList[index]['cases'].toString())),
                );
              },
            ),
            innerTopWidget: buildInnerTopWidget(
              suggestionsList[index]['country'],
              suggestionsList[index]['todayCases'].toString(),
              suggestionsList[index]['deaths'].toString(),
              suggestionsList[index]['todayDeaths'].toString(),
              suggestionsList[index]['recovered'].toString(),
              suggestionsList[index]['critical'].toString(),
              suggestionsList[index]['casesPerOneMillion'].toString(),
            ),
            innerBottomWidget: buildInnerBottomWidget(
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

  // to set a placeholder for the search text field
  @override
  String get searchFieldLabel => 'Search Country';

  // to set the theme for search bar
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      textTheme: Theme.of(context).textTheme.apply(),
    );
  }

  // to build suggestions according to the query
  // it is when the user types something but does not press enter
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
                        context.findAncestorStateOfType();
                    foldingCellState?.toggleFold();
                  },
                  child: Container(
                      color: Color(0xff000000),
                      child: buildFrontWidget(
                          context,
                          suggestionsList[index]['countryInfo']['flag'],
                          suggestionsList[index]['country'],
                          suggestionsList[index]['cases'].toString())),
                );
              },
            ),
            innerTopWidget: buildInnerTopWidget(
              suggestionsList[index]['country'],
              suggestionsList[index]['todayCases'].toString(),
              suggestionsList[index]['deaths'].toString(),
              suggestionsList[index]['todayDeaths'].toString(),
              suggestionsList[index]['recovered'].toString(),
              suggestionsList[index]['critical'].toString(),
              suggestionsList[index]['casesPerOneMillion'].toString(),
            ),
            innerBottomWidget: buildInnerBottomWidget(
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
