// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:elevated_progress_button/elevated_progress_button.dart';
import 'package:elevated_progress_button/elevated_progress_button_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('State Change idle to loading', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(
      currentState: ProgressButtonState.idle,
      nextState: ProgressButtonState.progress,
    ));

    expect(find.text('Send'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Send'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('State Change loading to success', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(
      currentState: ProgressButtonState.progress,
      nextState: ProgressButtonState.success,
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(CircularProgressIndicator));
    await tester.pump();

    expect(find.text('Success'), findsOneWidget);
  });

  testWidgets('State Change loading to fail', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(
      currentState: ProgressButtonState.progress,
      nextState: ProgressButtonState.fail,
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(CircularProgressIndicator));
    await tester.pump();

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('State Change fail to idle', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp(
      currentState: ProgressButtonState.fail,
      nextState: ProgressButtonState.idle,
    ));

    expect(find.text('Failed'), findsOneWidget);

    await tester.tap(find.byType(ElevatedProgressButton));
    await tester.pump();

    expect(find.text('Send'), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key, this.currentState, this.nextState}) : super(key: key);
  final ProgressButtonState? currentState;
  final ProgressButtonState? nextState;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevated Progress Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProgressButtonHomePage(
          currentState: currentState, nextState: nextState),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {

  const ProgressButtonHomePage({Key? key, this.currentState, this.nextState})
      : super(key: key);

  final ProgressButtonState? currentState;
  final ProgressButtonState? nextState;

  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState();
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  _ProgressButtonHomePageState() : super();

  ProgressButtonState? currentState;
  ProgressButtonState? nextState;

  ProgressButtonState? state;

  @override
  void initState() {
    super.initState();
    setState(() {
      state = currentState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedProgressButton(
              progressButtonStates: {
                ProgressButtonState.idle: ElevatedProgressButtonState(
                  progressButtonState: ProgressButtonState.idle,
                  spacing: 8,
                  text: 'Send',
                  icon: const Icon(Icons.send),
                ),
                ProgressButtonState.progress: ElevatedProgressButtonState(
                  progressButtonState: ProgressButtonState.progress,
                  spacing: 8,
                  text: '',
                  icon: null,
                ),
                ProgressButtonState.fail: ElevatedProgressButtonState(
                  progressButtonState: ProgressButtonState.fail,
                  spacing: 8,
                  text: 'Fail',
                  icon: const Icon(Icons.cancel),
                ),
                ProgressButtonState.success: ElevatedProgressButtonState(
                  progressButtonState: ProgressButtonState.success,
                  spacing: 8,
                  text: '',
                  icon: const Icon(Icons.check_circle),
                ),
              },
              size: 20, // TextStyle(fontSize: 20),
              radius: 18,
              padding: 8,
              minWidth: 150,
              maxWidth: 200,
              progressIndicatorColor: Theme.of(context).primaryTextTheme.button!.color!,
              onPressed: () {
                setState(() {
                  state = nextState;
                });
              },
              state: state)),
    );
  }
}
