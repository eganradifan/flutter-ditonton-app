import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should have text and icon', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AboutPage()));
    await tester.pumpWidget(testWidget);

    expect(find.byType(Text), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
