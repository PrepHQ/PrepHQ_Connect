import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:prephq_connect/widgets/appbar_action_btn.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:prephq_connect/widgets/article_card.dart';

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

  testWidgets(
    'Test that article card constructs as expected',
    (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(MaterialApp(home: ArticleCard()));
        expect(find.byType(Text), findsNWidgets(2));
        expect(find.byType(FlatButton), findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);
      });
    },
  );
}