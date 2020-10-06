import 'dart:convert';
import '../widgets/drawer.dart';
import 'package:number_display/number_display.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bezier_chart/bezier_chart.dart';

class Home extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  Future getAllData() async {
    try {
      var url = 'https://corona.lmao.ninja/v2/all';
      var response = await http.get(url);
      var url2 = 'https://corona.lmao.ninja/v2/historical/India';
      var response2 = await http.get(url2);
      List<Map<String, dynamic>> dataPoints = [];
      jsonDecode(response2.body)['timeline']['cases'].forEach((k, v) {
        List a = k.split('/');
        DateTime b =
            DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
        dataPoints.add({"date": b, "value": v});
      });
      List<Map<String, dynamic>> dataPoints1 = [];
      jsonDecode(response2.body)['timeline']['deaths'].forEach((k, v) {
        List a = k.split('/');
        DateTime b =
            DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
        dataPoints1.add({"date": b, "value": v});
      });
      List<Map<String, dynamic>> dataPoints2 = [];
      jsonDecode(response2.body)['timeline']['recovered'].forEach((k, v) {
        List a = k.split('/');
        DateTime b =
            DateTime(int.parse(a[2]), int.parse(a[0]), int.parse(a[1]));
        dataPoints2.add({"date": b, "value": v});
      });
      return {
        "all": response.body,
        "country": dataPoints,
        "deaths": dataPoints1,
        "recovered": dataPoints2
      };
    } catch (e) {
      print(e);
    }
  }

  Widget sample1(
      BuildContext context, List<Map<String, dynamic>> datesAndValues) {
    final fromDate = datesAndValues[0]['date'];
    final toDate = datesAndValues.last['date'];

    List<DataPoint<DateTime>> dataPoints = [];
    for (final x in datesAndValues) {
      dataPoints.add(DataPoint<DateTime>(
          value: double.parse(x['value'].toString()), xAxis: x['date']));
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(40.0),
          color: Colors.red,
        ),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              data: dataPoints,
            ),
          ],
          config: BezierChartConfig(
            physics: BouncingScrollPhysics(),
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.transparent,
            footerHeight: 30.0,
          ),
        ),
      ),
    );
  }

  Widget cardWidget(BuildContext context, String title, String number) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            number,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      color: Color(0xfff44e3f),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text(
            "World Wide Cases",
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () => Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (context, a1, a2) => Home())),
          child: FutureBuilder(
              future: getAllData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Failed loading data. Please check you wifi connection!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                Map<String, dynamic> results =
                    json.decode(snapshot.data['all']);
                List<Map<String, dynamic>> results2 =
                    (snapshot.data['country']);
                List<Map<String, dynamic>> results3 = (snapshot.data['deaths']);
                List<Map<String, dynamic>> results4 =
                    (snapshot.data['recovered']);
                final updateNoDisplay = createDisplay(length: 4);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: <Widget>[
                          cardWidget(context, "Total Cases",
                              results['cases'].toString()),
                          cardWidget(
                              context, "Deaths", results['deaths'].toString()),
                          cardWidget(context, "Recovered",
                              results['recovered'].toString()),
                          cardWidget(
                              context, "Active", results['active'].toString()),
                          cardWidget(context, "Updated",
                              updateNoDisplay(results['updated'])),
                          cardWidget(context, "Affected Countries",
                              results['affectedCountries'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Weekly Cases in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      sample1(context, results2),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Weekly Deaths in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      sample1(context, results3),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Weekly Recoveries in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      sample1(context, results4),
                    ],
                  ),
                );
              }),
        ));
  }
}
