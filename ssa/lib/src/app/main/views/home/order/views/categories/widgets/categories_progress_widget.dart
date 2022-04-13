import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/strings/progress_widget.constants.dart';

class CategoriesProgressWidget extends StatelessWidget {
  const CategoriesProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const CircularProgressIndicator(),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Text(
            progressWidgetText,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ]),
    );
  }
}
