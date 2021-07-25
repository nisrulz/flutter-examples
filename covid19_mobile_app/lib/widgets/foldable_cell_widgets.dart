import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:number_display/number_display.dart';

// To display data in a width-limited component
// Eg: converts 2,000,000 to 2M
String updateNumberDisplay(String number) {
  final display = createDisplay(length: 4);
  // we are converting number to an integer because it is a string
  // and display expects an integer
  return display(int.parse(number));
}

// the front widget for the foldable cell(when cell is collapsed)
Widget buildFrontWidget(
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
              Text("Total Cases: ${updateNumberDisplay(cases)}"),
            ],
          ),
        ),
      ],
    ),
  );
}

// the inner top widget for the foldable cell(when cell is expanded)
Widget buildInnerTopWidget(String country, String todayCases, String deaths,
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
                  "Today Cases: ${updateNumberDisplay(todayCases)}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Deaths: ${updateNumberDisplay(deaths)}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Cases/Million: ${updateNumberDisplay(cpm)}",
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
                  "Recovered: ${updateNumberDisplay(recovered)}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Today Deaths: ${updateNumberDisplay(todayDeaths)}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Critical: ${updateNumberDisplay(critical)}",
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

// the inner bottom widget for the foldable cell(when cell is expanded)
Widget buildInnerBottomWidget(String cases) {
  return Builder(builder: (context) {
    return Container(
      color: Color(0xfff44e3f),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Text(
            "Total Cases:\n${updateNumberDisplay(cases)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
            ),
          )),
          FlatButton(
            onPressed: () {
              SimpleFoldingCellState foldingCellState =
                  context.findAncestorStateOfType();
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
  });
}
