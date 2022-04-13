import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SubView extends StatelessWidget {
  const SubView({
    required this.child,
    required this.title,
    this.textLeft = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool textLeft;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: !textLeft,
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
        title: Text(
          title,
          style: context
              .watch<MediaSettingsBloc>()
              .state
              .headline6
              .apply(color: Theme.of(context).titleColor),
        ),
      ),
      body: LayoutBuilder(
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
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     top: BorderSide(
                      //       color: Theme.of(context).primaryColor,
                      //       width: 1,
                      //     ),
                      //   ),
                      // ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
