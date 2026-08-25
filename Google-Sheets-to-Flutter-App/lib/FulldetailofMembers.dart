import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Fulldetailsofmembers extends StatefulWidget {
  final String name;
  final String number;
  final String member;
  final String type;
  final String Village;
  final String MobileNo1;
  final String MobileNo2;

  const Fulldetailsofmembers({
    Key? key,
    required this.name,
    required this.number,
    required this.member,
    required this.type,
    required this.Village,
    required this.MobileNo1,
    required this.MobileNo2,
  }) : super(key: key);

  @override
  State<Fulldetailsofmembers> createState() => _FulldetailsofmembersState();
}

class _FulldetailsofmembersState extends State<Fulldetailsofmembers> {
  @override
  Widget build(BuildContext context) {
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
        navigationBar: const CupertinoNavigationBar(
        middle: Text("Members Details"),
    ),
    child:Padding(
      padding: const EdgeInsets.only(top:90.0),
      child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(child: Text("${widget.name} Details",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Expanded(
                    child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child:Text(widget.name),
                          ),
                        ],
                      ),

                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Number",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Expanded(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child:Text(widget.number),
                          ),
                        ],
                      ),

                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Member",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(widget.member),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Type",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(widget.type),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Village",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(widget.Village),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Mobile No.1",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(widget.MobileNo1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Mobile No.2",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(widget.MobileNo2),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              _makePhoneCall( 'tel:${widget.MobileNo1}');
                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child:const Icon(
                            Icons.call,
                            size: 35.0,
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text("Number 1"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              _makePhoneCall('tel:${widget.MobileNo2}');
                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child:const Icon(
                            Icons.call,
                            size: 35.0,
                            color: Colors.black,
                          ),
                        ),
                        const   Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text("Number 2"),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    ),
    ));
  }
}
