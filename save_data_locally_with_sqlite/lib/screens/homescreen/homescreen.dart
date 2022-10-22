import 'package:flutter/material.dart';
import 'package:save_data_locally_with_sqlite/database/database_queries.dart';
import 'package:save_data_locally_with_sqlite/screens/homescreen/widgets/note_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String note = '';
  List<Map> notes = [];
  TextEditingController textEditingController = TextEditingController();
  void AddDatatoDatabase(String note) async {
    String datetime =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    await InsertData(note, datetime);
    UpdateNotesList();
  }

  void DeleteDataFromDatabase(String datetime) async {
    print(datetime);
    await DeleteData(datetime);
    UpdateNotesList();
  }

  void UpdateNotesList() async {
    notes = await GetData();
    print(notes);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print('init');
    UpdateNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Text('Save Data locally using sqlite'),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 140,
                width: 350,
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (text) {
                          note = text;
                        },
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Enter Text',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AddDatatoDatabase(note);
                        textEditingController.clear();
                        note = '';
                      },
                      child: Container(
                        width: 60,
                        height: 30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        DeleteDataFromDatabase(notes[index]['datetime']);
                      },
                      child: NoteContainer(
                        text: notes[index]['note'],
                        datetime: notes[index]['datetime'],
                      ),
                    );
                  },
                  itemCount: notes.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
