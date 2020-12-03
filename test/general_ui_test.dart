import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/main.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:prephq_connect/views/auth/login.dart';
import 'package:prephq_connect/registrationscreen.dart';
import 'package:prephq_connect/views/mentor/home.dart';
import 'package:prephq_connect/views/mentor/mentorscreen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:prephq_connect/notifiers/mentor_meetings_notifier.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Validate login screen widgets initialize correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(MaterialButton), findsOneWidget);

    // Verify our hint text
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Not_There'), findsNothing);
  });

  testWidgets('Validate registration screen widgets initialize correctly',
      (WidgetTester tester) async {
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

  testWidgets(
      'Validate navigation to registration page from login screen works',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(),
        navigatorObservers: [mockObserver],
      ),
    );

    //Tap the button with they key 'registration_button'
    await tester.tap(find.byKey(Key('register_button')));

    // Wait until no more frames are scheduled
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(mockObserver.didPush(any, any));

    // Expect that the page is now present
    expect(find.byType(RegistrationForm), findsOneWidget);
  });

  testWidgets(
    'Validate that Mentor Home widgets are initialized',
    (WidgetTester tester) async {
      // Needed to mock network images
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          // Needed to create the provider context
          ChangeNotifierProvider(
            create: (context) => MentorMeetingNotifier(),
            child: MaterialApp(
              home: MentorHome(),
            ),
          ),
          Duration(
              seconds: 1), // Needed for the implicit timer used in mentor home
        );

        expect(find.byType(Text), findsWidgets);
        expect(find.byType(GestureDetector), findsWidgets);
        expect(find.text('Today '), findsOneWidget);
        expect(find.text('Upcoming '), findsOneWidget);
        await tester.pumpAndSettle(Duration(seconds: 1)); // Advances fake timer
      });
    },
  );

  testWidgets(
    'Validate that Mentor Screen widget constructs all three mentor tabs',
    (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ChangeNotifierProvider(
            create: (context) => MentorMeetingNotifier(),
            child: MaterialApp(
              home: MentorScreen(),
            ),
          ),
          Duration(
            seconds: 1),
        );

        expect(find.byType(MentorHome), findsOneWidget);
        expect(find.text('Second Screen for Mentor'), findsOneWidget);
        expect(find.text('Third Screen for Mentor'), findsOneWidget);
        await tester.pumpAndSettle(Duration(seconds: 1));
      });
    },
  );

}
