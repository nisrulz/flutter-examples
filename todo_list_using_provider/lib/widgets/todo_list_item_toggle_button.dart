import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';

class TodoListItemToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Toggle Item Button');

    return Consumer<Todo>(
      builder: (context, todo, child) {
        print('rebuilding Consumer Todo List Item Toggle Item Button');

        return new RaisedButton(
          onPressed: (){
            todo.toggle();
          },
          color: todo.done ? Colors.blue : Colors.red,
          child: new Icon(Icons.refresh, color: Colors.white70,),
        );
      },
    );
  }
}
