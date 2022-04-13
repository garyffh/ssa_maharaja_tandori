import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';

class ListHeaderWidget extends StatelessWidget {
  const ListHeaderWidget({
    required this.category,
    Key? key,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      color: Theme.of(context).titleBackgroundColor,
      width: double.infinity,
      child: Text(
        category,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
