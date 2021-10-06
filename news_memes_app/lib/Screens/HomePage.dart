import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_memes_app/Screens/MemeScreen.dart';
import 'package:news_memes_app/Screens/NewsScreen.dart';
import 'package:news_memes_app/services/getNews.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> news = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News-Memes',
          style: GoogleFonts.gafata(),
        ),
        actions: [
          // IconButton(onPressed: (){
          //   print('Logout pressed');
          //   final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
          //   provider.googleLogout();
          //   Navigator.popUntil(context, (route) => false);
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          // }, icon: Icon(Icons.logout_rounded)),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg2.gif'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                print('Loading news');
                news = await showNews();
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsScreen(news)));
                  // showingNews = true;
                });
              },
              child: Text(
                'Read some News',
                style: GoogleFonts.lato(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                //memeUrl = await showMemes();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemeScreen()));
              },
              child: Text(
                'Have Some Fun!',
                style: GoogleFonts.lato(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
