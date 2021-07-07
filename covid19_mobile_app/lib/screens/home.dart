import 'dart:convert';
import 'package:covid19_mobile_app/resources/fetch_data_functions.dart';
import 'package:covid19_mobile_app/widgets/graph.dart';
import 'package:covid19_mobile_app/widgets/info_card.dart';
import '../widgets/drawer.dart';
import 'package:number_display/number_display.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

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
          // pull to refresh
          key: refreshKey,
          onRefresh: () => Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (context, a1, a2) => Home())),
          child: FutureBuilder(
              future: getAllData(),
              builder: (context, snapshot) {
                // Display CircularProgressIndicator if data isn't fetched yet
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                // If in case an error occurs
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Failed to load data. Please check you wifi connection!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                // results of all countries(taken together)
                Map<String, dynamic> globalResults =
                    json.decode(snapshot.data['all']);

                // daily cases results
                List<Map<String, dynamic>> dailyCasesResults =
                    (snapshot.data['country']);

                // daily deaths results
                List<Map<String, dynamic>> dailyDeaths =
                    (snapshot.data['deaths']);

                // daily recoveries results
                List<Map<String, dynamic>> dailyRecoveries =
                    (snapshot.data['recovered']);

                // To display data in a width-limited component
                // Eg: converts 2,000,000 to 2M
                final updateNumberDisplay = createDisplay(length: 4);

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
                          infoCard(context, "Total Cases",
                              globalResults['cases'].toString()),
                          infoCard(context, "Deaths",
                              globalResults['deaths'].toString()),
                          infoCard(context, "Recovered",
                              globalResults['recovered'].toString()),
                          infoCard(context, "Active",
                              globalResults['active'].toString()),
                          infoCard(context, "Updated",
                              updateNumberDisplay(globalResults['updated'])),
                          infoCard(context, "Affected Countries",
                              globalResults['affectedCountries'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Daily Cases in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildGraph(context, dailyCasesResults),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Daily Deaths in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildGraph(context, dailyDeaths),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Daily Recoveries in India",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      buildGraph(context, dailyRecoveries),
                    ],
                  ),
                );
              }),
        ));
  }
}
