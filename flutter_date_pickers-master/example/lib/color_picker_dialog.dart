import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

/// Dialog with some Material colors ([materialColors]) to pick one of them.
class ColorPickerDialog extends StatefulWidget {

  /// Initially selected color.
  ///
  /// If pre-selected color is not from [materialColors] [Colors.blue] will be
  /// used.
  final Color selectedColor;

  ///
  const ColorPickerDialog({
    Key? key,
    required this.selectedColor
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _mainColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    bool isSelectedMaterial = materialColors.contains(widget.selectedColor);
    if (isSelectedMaterial) {
      _mainColor = widget.selectedColor;
    }
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(6.0),
      title: const Text("Color picker"),
      content: MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: _onMainColorChange,
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        TextButton(
          child: const Text('SUBMIT'),
          onPressed: () {
            Navigator.of(context).pop(_mainColor);
          },
        ),
      ],
    );
  }

  void _onMainColorChange (Color? newColor) {
    if (newColor == null) return;

    setState(() {
      _mainColor = newColor;
    });
  }
}
