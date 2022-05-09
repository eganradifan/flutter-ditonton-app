import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('should have text and icon', (WidgetTester tester) async {
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(), child: MaterialApp(home: AboutPage()));
    await tester.pumpWidget(testWidget);

    expect(find.byType(Text), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
