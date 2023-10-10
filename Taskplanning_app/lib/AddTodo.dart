import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Home.dart';

class AppTodo extends StatefulWidget {
  const AppTodo({Key? key}) : super(key: key);

  @override
  State<AppTodo> createState() => _AppTodoState();
}

class _AppTodoState extends State<AppTodo> {
  String type = 'food';
  String SelectedCategory1 = 'important';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void saveTodoToFirebase() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Map<String, dynamic> todoData = {
          'title': titleController.text,
          'description': descriptionController.text,
          'category': SelectedCategory1,
          'type': type,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
        };

        CollectionReference todos =
            FirebaseFirestore.instance.collection('todos');

        await todos.add(todoData);

        titleController.clear();
        descriptionController.clear();

        Get.snackbar(
          "Added successfully",
          "You have added",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );

        Get.to(() => HomePage());
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.all(16.0),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter Title',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          ChoiceChip(
                            label: Text('Important'),
                            selected: SelectedCategory1 == 'important',
                            onSelected: (selected) {
                              setState(() {
                                SelectedCategory1 = 'important';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('Planner'),
                            selected: SelectedCategory1 == 'planner',
                            onSelected: (selected) {
                              setState(() {
                                SelectedCategory1 = 'planner';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter Description',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          FilterChip(
                            label: Text('Food'),
                            selected: type == 'food',
                            onSelected: (selected) {
                              setState(() {
                                type = 'food';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Workout'),
                            selected: type == 'workout',
                            onSelected: (selected) {
                              setState(() {
                                type = 'workout';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Run'),
                            selected: type == 'run',
                            onSelected: (selected) {
                              setState(() {
                                type = 'run';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Design'),
                            selected: type == 'design',
                            onSelected: (selected) {
                              setState(() {
                                type = 'design';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: saveTodoToFirebase,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
