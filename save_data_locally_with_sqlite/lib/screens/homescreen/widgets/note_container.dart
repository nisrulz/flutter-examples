import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NoteContainer extends StatelessWidget {
  final String text;
  final String datetime;
  NoteContainer({Key? key, this.text = '', this.datetime = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(.4),
            spreadRadius: 2.5,
            blurRadius: 2.5,
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              '$datetime',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    '$text',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
