import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image from Network"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            // Load image from network
            Image.network(
                'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/flutter_logo.png'),
            // even loads gifs
            // Gif image from Giphy, all copyrights are owned by Giphy
            Image.network(
                'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/loop_anim.gif'),
            
            CachedNetworkImage(
                  imageUrl: 'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/loop_anim.gif',
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url,downloadProgress) =>
                        Center(
                          child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                              ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                  )
          ],
        )),
      ),
    );
  }
}
