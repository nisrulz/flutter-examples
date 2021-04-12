import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';

class TodoListItemDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuilding Todo List Item Display');

    return Consumer<Todo>(
      builder: (context, todo, child) {
        print('rebuilding Consumer Todo List Item Display');

        return Text(
          '${todo.title}: ${todo.done}',
          style: TextStyle(fontSize: 16.0),
        );
      },
    );
  }
}
