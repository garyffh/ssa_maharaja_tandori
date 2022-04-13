import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/strings/progress_widget.constants.dart';


class CategoriesProgressDialog extends StatelessWidget {
  const CategoriesProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                progressWidgetText,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
