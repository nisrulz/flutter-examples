import 'package:flutter/material.dart';
import 'index.dart';

class CustomPieChart extends StatefulWidget {
  final List<PieChartSectionData> sections;
  final double? height;
  final bool overrideColor;
  final Function(int index)? onAreaTouched;
  final double? centerSpaceRadius;
  final double? sectionsSpace;

  const CustomPieChart({
    super.key,
    required this.sections,
    this.height = 200,
    this.overrideColor = false,
    this.onAreaTouched,
    this.centerSpaceRadius,
    this.sectionsSpace,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int _touchedIndex = -1;
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.teal.shade600,
    Colors.blue,
    Colors.cyan,
    Colors.deepPurple,
    Colors.red.shade800,
    Colors.orange.shade800,
    Colors.green.shade800,
    Colors.blue.shade800,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PieChart(PieChartData(
        sectionsSpace: widget.sectionsSpace,
        centerSpaceRadius: widget.centerSpaceRadius,
        sections: widget.sections
            .asMap()
            .map((i, data) {
              return MapEntry(
                i,
                data.copyWith(
                  titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: i == _touchedIndex ? 19 : null,
                  ),
                  color: widget.overrideColor ? data.color : _colors[i],
                  radius: i == _touchedIndex ? 50 : null,
                ),
              );
            })
            .values
            .toList(),
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                widget.onAreaTouched?.call(_touchedIndex);
                _touchedIndex = -1;
                return;
              }
              _touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
      )),
    );
  }
}
