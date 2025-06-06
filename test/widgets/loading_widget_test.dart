import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petjournal/widgets/loading_widget.dart';

const key = Key('loading_widget_field');

Widget createWidget(String labelText) {
  return MaterialApp(
    home: Scaffold(body: LoadingWidget(key: key, labelText: labelText)),
  );
}

void main() {
  group('Test building widget', () {
    testWidgets('show the widget with initial text', (tester) async {
      String label = 'test loading widget';
      await tester.pumpWidget(createWidget(label));

      expect(find.bySemanticsLabel(label), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
