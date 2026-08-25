import 'package:flutter/material.dart';

class ActionDeleteIcon extends StatelessWidget {
  final VoidCallback onTap;

  const ActionDeleteIcon({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
