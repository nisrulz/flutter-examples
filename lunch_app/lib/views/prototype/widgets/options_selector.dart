import 'package:flutter/material.dart';

class OptionsSelector extends StatefulWidget {
  final Function(String) onChange;

  const OptionsSelector({Key key, @required this.onChange}) : super(key: key);

  @override
  _OptionsSelectorState createState() => _OptionsSelectorState();
}

class _OptionsSelectorState extends State<OptionsSelector> {
  final List<String> options = ["Offers", "Foods", "Drinks"];

  int _current;

  @override
  void initState() {
    super.initState();
    _current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Row(
          children: List.generate(
            options.length,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _current = i;
                  });
                  widget.onChange(options[i]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 5,
                        color:
                            (i == _current) ? Colors.amber : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    options[i],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
