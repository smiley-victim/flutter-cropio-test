// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('HomepageWidget', () {
//     testWidgets('displays correctly and contains expected elements', (WidgetTester tester) async {
//       // Build our widget and trigger a frame.
//       await tester.pumpWidget(MaterialApp(home: myHomepage()));

//       // Verify that the app bar title is correct
//       expect(find.text('My App'), findsOneWidget);

//       // Verify that the body contains the expected text
//       expect(find.text('This is the homepage.'), findsOneWidget);

//       // Verify that the floating action button is present
//       expect(find.byType(FloatingActionButton), findsOneWidget);
//     });

//     testWidgets('AppBar title is correct', (WidgetTester tester) async {
//       await tester.pumpWidget(const MaterialApp(home: HomepageWidget()));

//       // Find the AppBar widget
//       final appBar = find.byType(AppBar);
//       expect(appBar, findsOneWidget);

//       // Find the Text widget within the AppBar that displays the title
//       final titleText = find.descendant(
//         of: appBar,
//         matching: find.byType(Text),
//       );
//       expect(titleText, findsOneWidget);

//       // Verify that the title text is correct
//       final titleWidget = tester.widget<Text>(titleText);
//       expect(titleWidget.data, 'My App');
//     });
//   });
// }
