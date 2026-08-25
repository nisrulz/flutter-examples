import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;
  final VoidCallback? onDeleted;

  const TagChip({
    super.key,
    required this.text,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: InputChip(
        label: Text(text),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey),
        ),
        deleteIconColor: Colors.grey,
        onPressed: () {},
        onDeleted: onDeleted,
      ),
    );
  }
}
