import 'package:flutter/material.dart';
import 'package:news_memes_app/services/getNews.dart';

class NewsScreen extends StatefulWidget {
  //const NewsScreen({Key? key}) : super(key: key);
  List<NewsModel> news;

  NewsScreen(this.news);

  @override
  _NewsScreenState createState() => _NewsScreenState(news);
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> news;

  _NewsScreenState(this.news);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF28496E),
      body: Center(
        child: Center(
          child: InteractiveViewer(
            child: ListWheelScrollView(
              // magnification: 1.2,
              children: news
                  .map((e) => Container(
                        width: size.width * 0.88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            e.imageUrl == 'NoImage'
                                ? Container(
                                    height: 40,
                                    color: Colors.grey,
                                    child: Text(
                                      'No Preview Available!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  )
                                : Image(image: NetworkImage(e.imageUrl)),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                e.description,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              itemExtent: 400,
              diameterRatio: 3,
            ),
          ),
        ),
      ),
    );
  }
}
