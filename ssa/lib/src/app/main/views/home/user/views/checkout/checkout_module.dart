import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout/checkout_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/services/checkout_stepper/checkout_stepper_event.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';

import 'checkout_nav_cubit.dart';
import 'checkout_route.dart';

class CheckoutModule extends StatelessWidget {
  const CheckoutModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckoutNavCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CheckoutStepperBloc(
            checkoutRepo: context.read<CheckoutRepo>(),
            storeStatusBloc: BlocProvider.of<StoreStatusBloc>(context),
            checkoutNavCubit: BlocProvider.of<CheckoutNavCubit>(context),
            appNavigatorCubit: BlocProvider.of<AppNavigatorCubit>(context),
          )..add(CheckoutStepperEventGetViewModel()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CheckoutBloc(
            checkoutRepo: RepositoryProvider.of<CheckoutRepo>(context),
            storeStatusBloc: BlocProvider.of<StoreStatusBloc>(context),
            cartBloc: BlocProvider.of<CartBloc>(context),
            homeNavCubit: BlocProvider.of<HomeNavCubit>(context),
            checkoutNavCubit: BlocProvider.of<CheckoutNavCubit>(context),
            appNavigatorCubit: BlocProvider.of<AppNavigatorCubit>(context),
            businessSettingsBloc: BlocProvider.of<BusinessSettingsBloc>(context),
          ),
        ),
      ],
      child: CheckoutRoute(
        appFloatingButtonCubit:
            BlocProvider.of<AppFloatingButtonCubit>(context),
      ),
    );
  }
}
