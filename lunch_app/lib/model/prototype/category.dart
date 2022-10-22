import 'package:flutter/cupertino.dart';

class Category {
  final String title;
  final IconData icon;

  Category(this.title, this.icon);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.title == title && other.icon == icon;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode;
}
