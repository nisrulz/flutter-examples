import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_memes_app/services/getMemes.dart';
import 'package:share/share.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({Key? key}) : super(key: key);

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  List<dynamic> memeUrl = ['loading'];
  bool memeLoading = true;
  int index = 0;

  void getMeme() async {
    memeUrl = await showMemes();
    setState(() {
      memeLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeme();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF28496E),
        appBar: AppBar(
          title: Text(
            'Memes',
            style: GoogleFonts.kanit(),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(memeUrl[index]);
                },
                icon: Icon(Icons.share_rounded))
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Swipe Up for more!',
                style: GoogleFonts.changa(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        body: memeLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Dismissible(
                key: Key(memeUrl[index]),
                direction: DismissDirection.up,
                onDismissed: (direction) {
                  if (direction == DismissDirection.up) {
                    setState(() {
                      index++;
                      if (index == 10) {
                        index = 0;
                        memeUrl = ['loading'];
                        memeLoading = true;
                        getMeme();
                      }
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image:
                          DecorationImage(image: NetworkImage(memeUrl[index]))),
                ),
              ));
  }
}
