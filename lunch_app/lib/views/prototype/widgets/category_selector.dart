import 'package:flutter/material.dart';
import 'package:lunch_app/model/prototype/category.dart';
import 'package:lunch_app/views/prototype/widgets/main_btn.dart';

class CategorySelector extends StatefulWidget {
  final Function(Category) onChange;

  const CategorySelector({Key key, @required this.onChange}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<Category> categories = [
    Category("All", null),
    Category("Foods", Icons.local_pizza),
    Category("Drinks", Icons.local_drink_sharp),
  ];

  int _current;

  @override
  void initState() {
    super.initState();
    _current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categories.length,
            (i) {
              var cur = categories[i];
              return Padding(
                padding: (i == 0)
                    ? const EdgeInsets.symmetric(horizontal: 15.0)
                    : const EdgeInsets.only(right: 15),
                child: MainBtn(
                  onTap: () {
                    setState(() {
                      _current = i;
                    });
                    widget.onChange(categories[i]);
                  },
                  title: cur.title,
                  icon: cur.icon,
                  active: i == _current,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
