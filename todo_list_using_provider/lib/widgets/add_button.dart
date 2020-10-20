import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../notifiers/todo_list.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context, listen: false);
    print('build IncrementButton');

    return FloatingActionButton(
      onPressed: () {
        todoList.add(
          new Todo(id: '${todoList.list.length}', title: 'tituloTodo${todoList.list.length}')
        );
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
