import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class SubViewScroll extends StatelessWidget {
  const SubViewScroll({
    required this.child,
    required this.title,
    this.trailingWidget,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String title;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: context.watch<MediaSettingsBloc>().state.sp(32),
        backgroundColor: Theme.of(context).titleBackgroundColor,
        foregroundColor: Theme.of(context).titleColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).titleColor,
            size: context.watch<MediaSettingsBloc>().state.sp(20),
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        title: ViewTitleWidget(
          title: title,
          leadPadding: false,
          trailingWidget: trailingWidget,
        ),
      ),
      body: child,
    );
  }
}
