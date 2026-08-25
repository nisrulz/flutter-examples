import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/material.dart';

enum ImageSourceType {
  network,
  file,
}

class ImagePage extends StatelessWidget {
  final String imageSource;
  final ImageSourceType sourceType;

  const ImagePage({
    super.key,
    required this.imageSource,
    this.sourceType = ImageSourceType.network,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Center(
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(imageSource),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64, left: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => goBack(context),
                  icon: Icon(
                    Icons.close,
                    size: 39,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
