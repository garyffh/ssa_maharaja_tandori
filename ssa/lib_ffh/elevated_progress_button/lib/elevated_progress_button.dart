import 'package:flutter/material.dart';

import 'elevated_progress_button_state.dart';

class ElevatedProgressButton extends StatefulWidget {
  ElevatedProgressButton({
    Key? key,
    required this.progressButtonStates,
    required this.size,
    required this.padding,
    required this.radius,
    required this.minWidth,
    required this.maxWidth,
    required this.progressIndicatorColor,
    this.state = ProgressButtonState.idle,
    this.onPressed,
    this.minWidthStates = const <ProgressButtonState>[
      ProgressButtonState.progress
    ],
  })  : assert(
  progressButtonStates.keys
      .toSet()
      .containsAll(ProgressButtonState.values.toSet()),
  'All progress states are required. Missing => ${ProgressButtonState.values.toSet().difference(progressButtonStates.keys.toSet())}',
  ),
        super(key: key);

  final Map<ProgressButtonState, ElevatedProgressButtonState>
  progressButtonStates;
  final double size;
  final Color progressIndicatorColor;
  final VoidCallback? onPressed;
  final ProgressButtonState? state;
  final double padding;
  final List<ProgressButtonState> minWidthStates;
  final double minWidth;
  final double maxWidth;
  final double radius;


  @override
  State<StatefulWidget> createState() {
    return _ElevatedProgressButtonProgressState();
  }
}

class _ElevatedProgressButtonProgressState extends State<ElevatedProgressButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  double? width;
  Duration animationDuration = const Duration(milliseconds: 500);

  void startAnimations(
      ProgressButtonState? oldState, ProgressButtonState? newState) {
    if (widget.minWidthStates.contains(newState)) {
      width = widget.minWidth;
    } else {
      width = widget.maxWidth;
    }
  }

  @override
  void initState() {
    super.initState();

    width = widget.maxWidth;

    colorAnimationController =
        AnimationController(duration: animationDuration, vsync: this);
  }

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ElevatedProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      colorAnimationController?.reset();
      startAnimations(oldWidget.state, widget.state);
    }
  }

  Widget getButtonChild() {
    if (widget.state == ProgressButtonState.progress) {
      return Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  widget.progressIndicatorColor),
            ),
            width: widget.size,
            height:  widget.size,
          ),
          if(widget.progressButtonStates[widget.state!]!.hasProgressWidget)
            widget.progressButtonStates[widget.state!]!.uiState(),
        ],
      );
    } else {
      return widget.progressButtonStates[widget.state!]!.uiState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController!,
      builder: (context, child) {
        return AnimatedContainer(
          width: width,
          height: widget.size + (widget.padding * 2),
          duration: animationDuration,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: widget.size), // widget.textStyle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                side: const BorderSide(color: Colors.transparent, width: 0),
              ),
            ),
            onPressed: widget.onPressed,
            child: getButtonChild(),
          ),
        );
      },
    );
  }
}
