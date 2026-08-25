import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:soap_application/feedback_list.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FulldetailofMembers.dart';
import 'form.dart';

class ShowMemberDetails extends StatefulWidget {
  const ShowMemberDetails({Key? key}) : super(key: key);

  @override
  State<ShowMemberDetails> createState() => _ShowMemberDetailsState();
}

class _ShowMemberDetailsState extends State<ShowMemberDetails> {

  final TextEditingController _search = TextEditingController();
  ScrollController _controller = new ScrollController();

  List<FeedbackForm> feedbackItems = <FeedbackForm>[];
  List<FeedbackForm> filterSearch = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        filterSearch = List.from(feedbackItems);
        this.feedbackItems = feedbackItems;
      });
    });
  }

  void updateList(String Value) {
    setState(() {
      filterSearch = feedbackItems
          .where((element) =>
              element.name!.toLowerCase().contains(Value.toLowerCase()) ||
              element.type.toLowerCase().contains(Value.toLowerCase()) ||
              element.Village!.toLowerCase().contains(Value.toLowerCase()) ||
              element.number!.toLowerCase().contains(Value.toLowerCase()) ||
              element.MobileNo1!.toLowerCase().contains(Value.toLowerCase()))
          .toList();
    });
  }

  Future<Null> _refresh() {

    return FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.filterSearch = feedbackItems;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Update Successfully"),
        ));
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _makePhoneCall(String s) async {
      var url = Uri.parse(s);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("All Contact List"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.refresh,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: _refresh,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: size.height / 10,
                          width: size.width / 1,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: size.height / 16,
                            width: size.width / 1.1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (Value) => updateList(Value),
                                    controller: _search,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white70,
                                      prefixIcon: Icon(Icons.search),
                                      hintText: "Search",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder (
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    shrinkWrap: true,
                    itemCount: filterSearch.length,
                    itemBuilder: (context, index) {
                      print(filterSearch[index].name.toString());
                      return ListTile(
                        onLongPress: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Fulldetailsofmembers(type: filterSearch[index].type,
                            number: this.filterSearch[index].number,name: this.filterSearch[index].name,MobileNo1: this.filterSearch[index].MobileNo1,MobileNo2: this.filterSearch[index].MobileNo2,Village: this.filterSearch[index].Village,member: this.filterSearch[index].member,)));},
                        onTap: () {
                          setState(() {
                            print(filterSearch[index].MobileNo1.toString());
                            _makePhoneCall(
                                'tel:' + filterSearch[index].MobileNo1);
                          });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Expanded(
                              child: Text(
                                  "${filterSearch[index].name} (${filterSearch[index].Village})(${filterSearch[index].member + 'G'})"),
                            )
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(Icons.folder_open),
                            Expanded(
                              child: Text(filterSearch[index].number),
                            ),
                            Icon(Icons.call),
                            Expanded(
                                child: Text(
                                    "${filterSearch[index].MobileNo1} ${filterSearch[index].MobileNo2}"))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
