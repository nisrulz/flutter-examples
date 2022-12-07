import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
          middle: Text("Main Screen"),
        ),
         child: SafeArea(
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Container(
                   height: size.height / 10,
                   width: size.width,
                   alignment: Alignment.center,
                   padding: const EdgeInsets.only(top: 20),
                   child: Container(
                     height: size.height / 14,
                     width: size.width / 1.15,
                     child: TextField(
                       controller: _search,
                       decoration: InputDecoration(
                         hintText: "Search",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: size.height / 50,
                 ),
                 ElevatedButton(
                   onPressed: (){},
                   child: const Text("Search"),
                 ),
                 SizedBox(
                   height: size.height / 50,
                 ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Text("Hello ssdfsffsff"),
                        ),
                      ],
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Member",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Type",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Village",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Mobile No.1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Mobile No.2",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                           ),
                         ],
                       ),
                       const VerticalDivider(
                         color: Colors.black,
                         thickness: 2,
                       ),
                       Column(
                         children: const [
                           Padding(
                             padding: EdgeInsets.only(left: 20,right: 20),
                             child: Text("Hello ssdfsffsff"),
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
                       children:[
                         RawMaterialButton(
                           onPressed: ()
                           {
                             setState(() {
                               _makePhoneCall('tel:9426945981');
                             });
                           },
                           elevation: 2.0,
                           fillColor: Colors.white,
                           padding: const EdgeInsets.all(15.0),
                           shape: const CircleBorder(),
                           child: const Icon(
                             Icons.call,
                             size: 35.0,
                             color: Colors.black,
                           ),
                         ),
                         const Padding( padding: EdgeInsets.only(top:15.0),
                         child:Text("Number 1"),),
                       ],),

                       Column(
                         children:[
                           RawMaterialButton(
                             onPressed: ()
                             {
                               setState(() {
                                 _makePhoneCall('tel:9426945981');
                               });
                             },
                             elevation: 2.0,
                             fillColor: Colors.white,
                             padding: const EdgeInsets.all(15.0),
                             shape:const CircleBorder(),
                             child:const Icon(
                               Icons.call,
                               size: 35.0,
                               color: Colors.black,
                             ),
                           ),

                           const Padding( padding: EdgeInsets.only(top:15.0),
                             child:Text("Number 2"),),
                         ],),
                     ],
                   ),
                 )
               ],
             ),
           ),
         )
      ),
    );
  }
}
