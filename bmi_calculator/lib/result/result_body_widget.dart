import 'package:flutter/material.dart';

import '../palette.dart';
import 'result_content_widget.dart';

class ResultBodyWidget extends StatelessWidget {
  const ResultBodyWidget({
    super.key,
    required this.result,
  });

  final double result;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(72.0),
        child: ResultContentWidget(result: result),
      ),
    );
  }
}
