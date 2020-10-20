import 'package:flutter/foundation.dart';
import 'package:flutter_new_provider_todo/models/todo.dart';

/// This class represents a model
/// that notify listeners when it has some changes
class TodoList extends ChangeNotifier {
  List<Todo> _list = new List<Todo>();

  List<Todo> get list => _list;

  void add(Todo newItem) {
    this._list.add(newItem);
    notifyListeners();
  }

  void remove(Todo removedItem) {
    this._list.remove(removedItem);
    notifyListeners();
  }

  void clearDoneItems() {
    this._list.removeWhere((Todo element) => element.done);
    notifyListeners();
  }
}
