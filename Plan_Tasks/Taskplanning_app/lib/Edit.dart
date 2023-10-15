import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  final String taskId;
  final String initialTitle;
  final String initialDescription;
  final String initialTaskType;
  final String initialCategory;

  Edit({
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialTaskType,
    required this.initialCategory,
  });

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String selectedTaskType = '';
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
    selectedTaskType = widget.initialTaskType;
    selectedCategory = widget.initialCategory;
  }

  void updateTask() async {
    try {
      CollectionReference todos =
          FirebaseFirestore.instance.collection('todos');

      await todos.doc(widget.taskId).update({
        'title': titleController.text,
        'description': descriptionController.text,
        'type': selectedTaskType,
        'category': selectedCategory,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task updated successfully.'),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update the task: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
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
                            selected: selectedTaskType == 'important',
                            onSelected: (selected) {
                              setState(() {
                                selectedTaskType = 'important';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('Planner'),
                            selected: selectedTaskType == 'planner',
                            onSelected: (selected) {
                              setState(() {
                                selectedTaskType = 'planner';
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
                            selected: selectedCategory == 'food',
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'food';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Workout'),
                            selected: selectedCategory == 'workout',
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'workout';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Run'),
                            selected: selectedCategory == 'run',
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'run';
                              });
                            },
                          ),
                          FilterChip(
                            label: Text('Design'),
                            selected: selectedCategory == 'design',
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'design';
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
                child: ElevatedButton(
                  onPressed: updateTask,
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
