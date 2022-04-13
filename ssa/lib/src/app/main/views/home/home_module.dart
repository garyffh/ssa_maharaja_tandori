import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/address_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/categories_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/checkout_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/dashboard_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/orders_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/privacy_policy_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/sitem_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/trading_hours_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/transactions_repo.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/main/services/address/address_bloc.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

import 'home_route.dart';
import 'order/views/categories/categories_bloc.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CategoriesRepo>(
          create: (context) => CategoriesRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<SitemRepo>(
          create: (context) => SitemRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<DashboardRepo>(
          create: (context) => DashboardRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<PaymentMethodRepo>(
          create: (context) => PaymentMethodRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<AddressRepo>(
          create: (context) => AddressRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<CheckoutRepo>(
          create: (context) => CheckoutRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<TransactionsRepo>(
          create: (context) => TransactionsRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<UserRepo>(
          create: (context) => UserRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<OrdersRepo>(
          create: (context) => OrdersRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<TradingHoursRepo>(
          create: (context) => TradingHoursRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<PrivacyPolicyRepo>(
          create: (context) => PrivacyPolicyRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoriesBloc(
              categoriesRepo:
                  RepositoryProvider.of<CategoriesRepo>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AddressBloc(
              addressRepo:
              RepositoryProvider.of<AddressRepo>(context),
            ),
          ),

        ],
        child: HomeRoute(
          appFloatingButtonCubit: BlocProvider.of<AppFloatingButtonCubit>(context),
        ),
      ),
    );
  }
}
