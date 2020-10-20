import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/main.dart';

void main() {
  testWidgets('Login Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify our hint text
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Not_There'), findsNothing);
  });
}
