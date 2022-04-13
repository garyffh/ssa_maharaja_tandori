import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/widgets/main_drawer.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_state.dart';

class PrimaryScaffold extends StatelessWidget {
  const PrimaryScaffold({
    required this.bottomNavigationBar,
    required this.body,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (themeContext, appThemeState) {
        return Scaffold(
          drawer: const MainDrawer(),
          appBar: appThemeState.appAppBar(),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: context.watch<AppFloatingButtonCubit>().state.floatingActionButton,
          floatingActionButtonLocation: context.watch<AppFloatingButtonCubit>().state.floatingActionButtonLocation,
        );
      }),
    );
  }
}
