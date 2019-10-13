import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class Note {
  String id;
  String content;
  String createdOn;

  Note(content) {
    this.content = content;
    this.createdOn = DateTime.now().toString();
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final notesRef = FirebaseDatabase.instance.reference().child('notes');
  final inputController = TextEditingController();
  StreamSubscription<Event> _noteAddedStream;
  var items;

  @override
  void initState() {
    super.initState();

    items = new List();
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
  void _onNoteAdded(Event event) {
    setState(() {
      var note = Note(event.snapshot.value["content"]);
      note.id = event.snapshot.key;
      note.createdOn = event.snapshot.value["created_on"];
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
