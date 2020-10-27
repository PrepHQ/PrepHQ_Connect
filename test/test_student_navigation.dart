import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prephq_connect/main.dart';
import 'package:prephq_connect/mentor/mentorscreen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Validate navigation to mentor page',
          (WidgetTester tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: MyApp(),
            navigatorObservers: [mockObserver],
          ),
        );

        //Tap the button with they key 'mentor_button'
        await tester.tap(find.byKey(Key('mentor_button')));

        // Wait until no more frames are scheduled
        await tester.pumpAndSettle();

        // Verify that a push event happened
        verify(mockObserver.didPush(any, any));

        // Expect that the page is now present
        expect(find.byType(MentorScreen), findsOneWidget);
      });
}