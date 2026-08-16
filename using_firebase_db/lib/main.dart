import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class Note {
  late String id;
  late String content;
  late String createdOn;

  Note(this.content) {
    createdOn = DateTime.now().toString();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final notesRef = FirebaseDatabase.instance.ref().child('notes');
  final inputController = TextEditingController();
  late StreamSubscription<DatabaseEvent> _noteAddedStream;
  List<Note> items = [];

  @override
  void initState() {
    super.initState();

    _noteAddedStream =
        notesRef.orderByChild("created_on").onChildAdded.listen(_onNoteAdded);
  }

  // Creates a new child under notes in the database
  void _addNote() {
    var note = Note(inputController.text);
    inputController.text = "";
    if (note.content.isNotEmpty) {
      notesRef.push().set({
        'content': note.content,
        'created_on': note.createdOn,
      });
    }
  }

  // Fired whenever the database sees a new child under the notes
  // database reference
  void _onNoteAdded(DatabaseEvent event) {
    setState(() {
      final value = event.snapshot.value as Map;
      var note = Note(value["content"] as String);
      note.id = event.snapshot.key!;
      note.createdOn = value["created_on"] as String;
      items.add(note);
    });
  }

  // The note has to be cleared from the database and the local list
  void _deleteNote(int position) {
    String id = items[position].id;
    notesRef.child(id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using Firebase DB"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                style: new TextStyle(
                    fontSize: 24.0, height: 2.0, color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Add a note'),
                controller: inputController,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                    itemCount: items.length,
                    padding: const EdgeInsets.all(10.0),
                    itemBuilder: (context, position) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.note),
                          title: Text(items[position].content),
                          onLongPress: () {
                            _deleteNote(position);
                          },
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}
