import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ICT107 app basic widget test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(' Auto Silent'),
          ),
        ),
      ),
    );

    expect(find.text(' Auto Silent'), findsOneWidget);
  });
}
