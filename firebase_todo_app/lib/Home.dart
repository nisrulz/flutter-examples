import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github.nisrulz.todo_app/AddTodo.dart';
import 'package:github.nisrulz.todo_app/Delete.dart';
import 'package:github.nisrulz.todo_app/Edit.dart';
import 'package:github.nisrulz.todo_app/Signin.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomePage({super.key});

  Future<void> _signOut() async {
    try {
      await _auth.signOut();

      Get.offAll(() => Signin());
    } catch (e) {
      print('Sign-out error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(() => AppTodo());
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: _buildTodoList(),
    );
  }

  Widget _buildTodoList() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(
        child: Text('User not logged in.'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('todos')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<Widget> todoWidgets = [];
        final todos = snapshot.data?.docs;

        for (var todo in todos!) {
          final title = todo['title'];
          final description = todo['description'];
          final taskType = todo['type'];
          final category = todo['category'];

          todoWidgets.add(
            Card(
              elevation: 4,
              margin: EdgeInsets.all(19.0),
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: $title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Description: $description'),
                    Text('Task Type: $taskType'),
                    Text('Category: $category'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => Edit(
                                  taskId: todo.id,
                                  initialTitle: todo['title'],
                                  initialDescription: todo['description'],
                                  initialTaskType: todo['type'],
                                  initialCategory: todo['category'],
                                ));
                          },
                          icon: Icon(Icons.edit),
                          label: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => Delete(taskId: todo.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.pink),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }

        return ListView(
          children: todoWidgets,
        );
      },
    );
  }
}
