import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/registrationscreen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Registration Screen Test', (WidgetTester tester) async {
    // Build registration form
    await tester.pumpWidget(MaterialApp(home: RegistrationForm()));

    // Verify our hint text is populated
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Re-Enter Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Not_There'), findsNothing);
  });
}