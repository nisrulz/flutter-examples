import 'package:flutter/material.dart';
import '../../misc/debouncer.dart';
import '../form/custom_text_field.dart';

class CustomSearchBar extends StatelessWidget {
  final String? label;
  final ValueChanged<String>? onSearch;
  final bool enabled;
  final Color? fillColor;

  final _debouncer = Debouncer(500);

  CustomSearchBar({
    super.key,
    this.label,
    this.onSearch,
    this.enabled = true,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      filled: true,
      fillColor: fillColor,
      prefixIcon: Icon(Icons.search),
      hint: label ?? 'Search',
      enabled: enabled,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      onChanged: (value) {
        _debouncer.run(() {
          onSearch?.call(value);
        });
      },
    );
  }
}
