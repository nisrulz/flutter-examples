// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:project/main.dart';

void main() {
  testWidgets('Checks on tap dismissal of bottom sheet', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('BottomSheet'), findsNothing);

    await tester.tap(find.text('BottomSheet'));
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 1)); 
    await tester.pump(const Duration(seconds: 1)); 
    expect(find.text('BottomSheet'), findsNothing);

  });
}
