import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Delete extends StatelessWidget {
  final String taskId;

  const Delete({required this.taskId, Key? key}) : super(key: key);

  void _deleteTask() {
    final CollectionReference tasks =
        FirebaseFirestore.instance.collection('todos');

    tasks.doc(taskId).delete().then((value) {
      Get.back();
      Get.snackbar(
        'Success',
        'Task updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }).catchError((error) {
      print('Error deleting task in Firestore: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Task'),
      content: Text('Are you sure you want to delete this task?'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _deleteTask,
          child: Text('Delete'),
        ),
      ],
    );
  }
}
