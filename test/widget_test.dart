import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:prephq_connect/widgets/appbar_action_btn.dart';

void main() {
  testWidgets('Validate AppBarActionBtn constructs as expected',
          (WidgetTester tester) async {
        // Build our app and trigger a frame.
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                actions: [
                  AppBarActionBtn(
                    icon: Icons.play_arrow,
                  )
                ],
              )),
        ));

        expect(find.byType(AppBarActionBtn), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.byIcon(Icons.ac_unit), findsNothing);
      });

}
