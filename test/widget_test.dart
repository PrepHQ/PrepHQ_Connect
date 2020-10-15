import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/main.dart';

void main() {
  testWidgets('Sample Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that one of our input box hints is email
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Not_There'), findsNothing);
  });
}
