import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ultima_pos/main.dart';

void main() {
  testWidgets('Login screen renders username and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(const UltimaPosApp());

    expect(find.text('Login'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
