import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class PrimaryView extends StatelessWidget {
  const PrimaryView({
    required this.child,
    required this.title,
    this.textLeft = true,
    this.leadPadding = true,
    this.trailingWidget,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool textLeft;
  final bool leadPadding;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ViewTitleWidget(
                  title: title,
                  textLeft: textLeft,
                  leadPadding: leadPadding,
                  trailingWidget: trailingWidget,
                ),
                Expanded(
                  child: Container(
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
