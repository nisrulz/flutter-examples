import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final Widget l;
  final String s;
  double radius = 8;
  NewWidget({this.size, this.l, this.s});
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.elasticInOut,
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 5),
            blurRadius: radius,
            color: Color(0XFF585858).withOpacity(.3),
//            color: Color(0XFF383838).withOpacity(.4),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 25),
          leading: l,
          trailing: Text(
            s,
            style: TextStyle(
                fontSize: 21,
                color: Colors.white54,
                fontWeight: FontWeight.w200),
          ),
        ),
      ),
    );
  }
}
