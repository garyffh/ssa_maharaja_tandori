import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_media_screen_size.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_state.dart';
import 'package:single_store_app/src/app/main/views/home/order/widgets/sitem_image_small_widget.dart';
import 'package:single_store_app/src/app/models/business/open_status.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SitemWidget extends StatelessWidget {
  const SitemWidget({required this.sitem, Key? key}) : super(key: key);

  final Sitem sitem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    sitem.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 90.0),
                  child: Text(
                      Formats.currency(
                        sitem.price(
                            context.watch<UserBusinessBloc>().state.priceLevel),
                      ),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SitemImageSmallWidget(sitem: sitem),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 107.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: context
                                      .watch<MediaSettingsBloc>()
                                      .state
                                      .deviceScreenWidth ==
                                  AppMediaScreenSize.xs
                              ? const SizedBox.shrink()
                              : Text(
                                  sitem.description,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                        ),
                        Container(
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.end,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _shoppingCartButton(context),
                              _moreButton(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextButton _shoppingCartButton(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).titleColor),
      ),
      icon: Text(
        'ADD',
        style: Theme.of(context).textTheme.button,
      ),
      label: const Icon(
        Icons.add_shopping_cart,
      ),
      onPressed: () {
        if (!context.read<StoreStatusBloc>().state.loaded) {
          return;
        }
        final OpenStatus openStatus =
            (context.read<StoreStatusBloc>().state as StoreStatusStateLoaded)
                .storeStatus
                .openStatus;
        if (openStatus == OpenStatus.open) {
          context.read<HomeNavCubit>().showCartAdd(
                postView: HomeView.categories,
                sitem: sitem,
              );
        } else {
          context
              .read<AppNavigatorCubit>()
              .showMessageDialog(openStatus.dialogMessage);
        }
      },
    );
  }

  TextButton _moreButton(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).titleColor),
      ),
      icon: Text(
        'MORE',
        style: Theme.of(context).textTheme.button,
      ),
      label: const Icon(
        Icons.navigate_next,
      ),
      onPressed: () =>
          context.read<HomeNavCubit>().showSitemDetail(sitem.sysSitemId),
    );
  }
}
