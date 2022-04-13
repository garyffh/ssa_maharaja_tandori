import 'dart:async';
import 'dart:math';

import 'package:elevated_progress_button/elevated_progress_button.dart';
import 'package:elevated_progress_button/elevated_progress_button_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevated Progress Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProgressButtonHomePage(title: 'APP Progress Button'),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {
   const ProgressButtonHomePage({Key? key, required this.title})
      : super(key: key);

  final String title;
  double get size => 28;
  double get radius => 26; // related to size
  double get iconSize => 32;
  double get padding => 12;
  double get spacing => 8;

  double get minWidth => 200.0;
  double get maxWidth => 400.0;

  double get minWidthIconButton => 58.0;
  double get maxWidthIconButton => 170.0;

  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState();
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  ProgressButtonState buttonState = ProgressButtonState.idle;
  ProgressButtonState iconButtonState = ProgressButtonState.idle;

  Widget buildButton() {
    return ElevatedProgressButton(
      progressButtonStates: {
        ProgressButtonState.idle: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.idle,
          spacing: widget.spacing,
          text: 'Idle',
          icon: null,
        ),
        ProgressButtonState.progress: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.progress,
          spacing: widget.spacing,
          text: 'Sending',
          icon: null,
        ),
        ProgressButtonState.fail: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.fail,
          spacing: widget.spacing,
          text: 'Fail',
          icon: null,
        ),
        ProgressButtonState.success: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.success,
          spacing: widget.spacing,
          text: 'Success',
          icon: null,
        ),
      },
      size: widget.size,
      radius: widget.radius,
      padding: widget.padding,
      minWidth: widget.minWidth,
      maxWidth: widget.maxWidth,
      state: buttonState,
      onPressed: onPressedButton,
      progressIndicatorColor: Theme.of(context).primaryTextTheme.button!.color!,
    );
  }

  Widget buildIconButton() {
    return ElevatedProgressButton(
      progressButtonStates: {
        ProgressButtonState.idle: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.idle,
          spacing: widget.spacing,
          text: 'Send',
          icon: Icon(Icons.send, size: widget.iconSize,),
        ),
        ProgressButtonState.progress: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.progress,
          spacing: widget.spacing,
          text: '',
          icon: null,
        ),
        ProgressButtonState.fail: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.fail,
          spacing: widget.spacing,
          text: 'Fail',
          icon: Icon(Icons.cancel, size: widget.iconSize,),
        ),
        ProgressButtonState.success: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.success,
          spacing: widget.spacing,
          text: '',
          icon: Icon(Icons.check_circle, size: widget.iconSize,),
        ),
      },
      size: widget.size,
      radius: widget.radius,
      padding: widget.padding,
      minWidth: widget.minWidthIconButton,
      maxWidth: widget.maxWidthIconButton,
      state: iconButtonState,
      onPressed: onPressedIconButton,
      progressIndicatorColor: Theme.of(context).primaryTextTheme.button!.color!,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(),
            Container(
              height: 32,
            ),
            buildIconButton(),
          ],
        ),
      ),
    );
  }

  void onPressedButton() {
    setState(() {
      switch (buttonState) {
        case ProgressButtonState.idle:
          buttonState = ProgressButtonState.progress;
          break;
        case ProgressButtonState.progress:
          buttonState = ProgressButtonState.fail;
          break;
        case ProgressButtonState.success:
          buttonState = ProgressButtonState.idle;
          break;
        case ProgressButtonState.fail:
          buttonState = ProgressButtonState.success;
          break;
      }
    });
  }

  void onPressedIconButton() {
    setState(() {
      switch (iconButtonState) {
        case ProgressButtonState.idle:
          iconButtonState = ProgressButtonState.progress;
          break;
        case ProgressButtonState.progress:
          iconButtonState = ProgressButtonState.fail;
          break;
        case ProgressButtonState.success:
          iconButtonState = ProgressButtonState.idle;
          break;
        case ProgressButtonState.fail:
          iconButtonState = ProgressButtonState.success;
          break;
      }
    });
  }

  void onPressedIconButton2() {
    switch (iconButtonState) {
      case ProgressButtonState.idle:
        iconButtonState = ProgressButtonState.progress;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            iconButtonState = Random.secure().nextBool()
                ? ProgressButtonState.success
                : ProgressButtonState.fail;
          });
        });

        break;
      case ProgressButtonState.progress:
        break;
      case ProgressButtonState.success:
        iconButtonState = ProgressButtonState.idle;
        break;
      case ProgressButtonState.fail:
        iconButtonState = ProgressButtonState.idle;
        break;
    }
    setState(() {
      iconButtonState = iconButtonState;
    });
  }

}
