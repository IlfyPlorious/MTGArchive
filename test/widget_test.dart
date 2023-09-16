// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/ui/main_page.dart';


void main() {
  testWidgets('Test main page title displayed', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: MainPage()));
    expect(find.text('Magic Archive'), findsOneWidget);
  });

  testWidgets("Test main page buttons' strings", (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MainPage(),
    ));
    expect(find.text('Your profile'), findsOneWidget);
    expect(find.text('Browse MTG sets'), findsOneWidget);
    expect(find.text('Search for cards'), findsOneWidget);
    expect(find.text('Your decks'), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/friends.png')),
        findsOneWidget);
  });
}
