import 'package:flutter/material.dart';

import 'todo_list_item_display.dart';
import 'todo_list_item_toggle_button.dart';


class TodoListItemWdt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuilding ToDo List Item: ');

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TodoListItemDisplay(),
        TodoListItemToggleButton(),
      ],
    );
  }
}
