import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_state.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_state.dart';
import 'package:single_store_app/src/app/widgets/view/primary_scaffold.dart';

class DriverScaffold extends StatelessWidget {
  const DriverScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverNavCubit(),
      child: BlocBuilder<DriverNavCubit, DriverNavState>(
          builder: (context, state) {
        return PrimaryScaffold(
          body: BlocListener<AppSnackBarCubit, AppSnackBarState>(
            listener: (scaffoldContext, snackBarState) {
              if (snackBarState.snackBar != null) {
                ScaffoldMessenger.of(scaffoldContext)
                    .showSnackBar(snackBarState.snackBar!);
              }
            },
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: state.bottomNavBarActive()
                ? null
                : Theme.of(context).bottomNavigationUnselectedColor,
            selectedLabelStyle: state.bottomNavBarActive()
                ? null
                : Theme.of(context).bottomNavigationUnselectedStyle,
            unselectedIconTheme: state.bottomNavBarActive()
                ? null
                : Theme.of(context).bottomNavigationUnselectedIconTheme,
            selectedIconTheme: state.bottomNavBarActive()
                ? null
                : Theme.of(context).bottomNavigationUnselectedIconTheme,
            currentIndex: state.bottomNavigationIndex(),
            type: BottomNavigationBarType.fixed,
            onTap: (int value) {
              switch (value) {
                case 0:
                  context.read<DriverNavCubit>().showTransactions();
                  break;

                case 2:
                  context.read<DriverNavCubit>().showVehicles();
                  break;

                default:
                  context.read<DriverNavCubit>().showDeliveries();
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_shipping),
                label: 'Deliveries',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'Vehicles',
              ),
            ],
          ),
        );
      }),
    );
  }
}
