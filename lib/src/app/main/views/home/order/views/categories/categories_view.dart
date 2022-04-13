import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/categories_tab_widget.dart';
import 'package:single_store_app/src/app/main/views/home/order/widgets/store_status_widget.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<MediaSettingsBloc>().state.isMobile) {
      if (context.watch<MediaSettingsBloc>().state.orientation ==
          Orientation.portrait) {
        return _statusView(context);
      } else {
        return const CategoriesTabWidget();
      }
    } else {
      return _statusView(context);
    }
  }

  Widget _statusView(BuildContext context) {
    return Column(
      children: const [
        StoreStatusWidget(),
        Expanded(
          child: CategoriesTabWidget(),
        ),
      ],
    );
  }
}
