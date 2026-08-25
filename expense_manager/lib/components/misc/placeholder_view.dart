import 'package:flutter/material.dart';

class PlaceholderView extends StatelessWidget {
  final bool show;
  final bool loading;
  final String title;
  final String description;
  final Widget? child;

  const PlaceholderView({
    super.key,
    this.show = false,
    this.loading = false,
    required this.title,
    required this.description,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // loading indicator
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // placeholder
    if (show) {
      return Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    // render actual content
    return child ?? SizedBox();
  }
}
