import 'package:expense_manager/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void gotoPage(
  BuildContext context,
  Widget destination, {
  Route? route,
}) {
  Navigator.of(context).push(route ??
      CupertinoPageRoute(builder: (_) {
        return destination;
      }));
}

void gotoPageAndClearStack(
  BuildContext context,
  Widget destination, {
  Route? route,
}) {
  Navigator.of(context).pushAndRemoveUntil(
      route ??
          CupertinoPageRoute(builder: (_) {
            return destination;
          }),
      (route) => false);
}

void goBack(BuildContext context) {
  Navigator.of(context).pop();
}

void showDecisionDialog(
  BuildContext context, {
  String? title,
  String? content,
  String? positiveButtonText,
  bool barrierDismissible = false,
  Function? onPositivePressed,
}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return AlertDialog(
          title: (title != null) ? Text(title) : null,
          content: (content != null) ? Text(content) : null,
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                goBack(context);
              },
            ),
            TextButton(
              child: Text(positiveButtonText ?? "OK"),
              onPressed: () {
                goBack(context);
                onPositivePressed?.call();
              },
            ),
          ],
        );
      });
}

void showCupertinoModal(
  BuildContext context, {
  required List<Widget> children,
  required ValueChanged<int> onSelectedItemChanged,
  bool top = false,
  double height = 216,
  double itemExtent = 36,
  int initialItem = 0,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Container(
      height: height,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: top,
        child: CupertinoPicker(
          itemExtent: itemExtent,
          onSelectedItemChanged: onSelectedItemChanged,
          scrollController: FixedExtentScrollController(
            initialItem: initialItem,
          ),
          children: children,
        ),
      ),
    ),
  );
}

String friendlyDate(DateTime? dt, {String? dateFormat}) {
  if (dt == null) return '';
  var format = DateFormat(dateFormat ?? "MMM d, yyyy");
  return format.format(dt);
}

String formatDate(DateTime dt, String format) {
  final now = DateTime.now();
  if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
    return "Today";
  } else if (dt.year == now.year &&
      dt.month == now.month &&
      dt.day == now.day - 1) {
    return "Yesterday";
  }
  return DateFormat(format).format(dt);
}

String formatMoney(num amount, {String? currency = 'RM'}) {
  return NumberFormat("$currency#,##0.00", "en_US").format(amount);
}

Color hexToColor(String hexColor) {
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}

String obfuscateText(String text, {bool obfuscate = false}) {
  return obfuscate ? '*****' : text;
}

num calculateChartInterval(num min, num max, {num interval = 6}) {
  final lowerBound = min ~/ 1000 * 1000;
  final upperBound = max ~/ 1000 * 1000;
  final xInterval = ((lowerBound + upperBound) / interval).round();
  return xInterval;
}

Future<void> loadDataWithState({
  required Future Function() data,
  required Function(DataLoaderState state) onStateChange,
}) async {
  bool dataLoaded = false;
  onStateChange(DataLoaderState.initiated);
  Future.delayed(Duration(milliseconds: 500), () {
    if (dataLoaded) return;
    onStateChange(DataLoaderState.loading);
  });

  await data();
  dataLoaded = true;
  onStateChange(DataLoaderState.loaded);
}

class Utils {}
