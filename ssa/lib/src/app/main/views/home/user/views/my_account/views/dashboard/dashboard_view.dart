import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/dashboard_repo.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_notification_update.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/address/user_address_edit.dart';
import 'package:single_store_app/src/app/widgets/error/error_dialog.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_loading_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_edit.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'dashboard_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        dashboardRepo: RepositoryProvider.of<DashboardRepo>(context),
      )..add(DashboardEventGetViewModel()),
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (viewContext, state) {
          if (state.type == ProgressErrorStateType.progressError &&
              state.hasError) {
            _showErrorMessageDialog(
              viewContext: viewContext,
              errorMessage: state.stateErrorMessage()!,
            );
          }
        },
        builder: (viewContext, viewState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ViewTitleWidget(title: 'My Account'),
              _view(viewContext, viewState),
            ],
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, DashboardState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.progressError:
        {
          return _viewModel(viewContext, viewState as DashboardStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return Expanded(
            child: Center(
              child: FormLoadingErrorWidget(
                progressFormView: viewState,
                dataDirection: DataDirection.receiving,
                tryAgainCallback: () =>
                    BlocProvider.of<DashboardBloc>(viewContext)
                        .add(DashboardEventGetViewModel()),
              ),
            ),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
      BuildContext viewContext, DashboardStateViewModel viewModel) {
    late AuthenticationStateAuthenticated? authenticationState;

    if (viewContext.read<AuthenticationBloc>().state
        is AuthenticationStateAuthenticated) {
      authenticationState = viewContext.read<AuthenticationBloc>().state
          as AuthenticationStateAuthenticated;
    } else {
      authenticationState = null;
    }

    return Expanded(
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: viewContext.watch<MediaSettingsBloc>().state.sp(88),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.userDashboard.points != 0)
                  NameValueEdit(
                    name: 'Loyalty Points',
                    value: Formats.points(viewModel.userDashboard.points),
                  ),
                _notifications(viewContext, viewModel),
                if (authenticationState != null)
                  NameValueEdit(
                    name: 'Name',
                    value:
                        '${authenticationState.firstName} ${authenticationState.lastName}',
                  ),
                if (authenticationState != null)
                  NameValueEdit(
                    name: 'Email',
                    value: authenticationState.email,
                  ),
                NameValueEdit(
                  name: 'Mobile',
                  value: viewModel.userDashboard.phone,
                  onEdit: () =>
                      viewContext.read<MyAccountNavCubit>().showPhoneUpdate(),
                ),
                NameValueEdit(
                  name: 'Payment Methods',
                  onEdit: () =>
                      viewContext.read<MyAccountNavCubit>().showPaymentMethods(),
                ),
                NameValueEdit(
                  name: 'Password',
                  value: '********',
                  onEdit: () =>
                      viewContext.read<MyAccountNavCubit>().showPasswordUpdate(),
                ),
                UserAddressEdit(
                  userAddress: viewModel.userDashboard.address,
                  onEdit: () =>
                      viewContext.read<MyAccountNavCubit>().showAddressUpdate(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notifications(
      BuildContext viewContext, DashboardStateViewModel viewModel) {
    return Container(
      padding:
          EdgeInsets.all(viewContext.watch<MediaSettingsBloc>().state.sp10),
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: EdgeInsets.only(
                  bottom: viewContext.watch<MediaSettingsBloc>().state.sp8),
              child: Text(
                'Notifications',
                style:
                    viewContext.watch<MediaSettingsBloc>().state.subtitle2.bold,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: viewContext.watch<MediaSettingsBloc>().state.sp22,
            ),
            child: Container(
            constraints: BoxConstraints(minHeight: viewContext.watch<MediaSettingsBloc>().state.sp32),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Special Offers',
                  style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
                  textAlign: TextAlign.left,
                ),
                if (viewModel.inProgress)
                     Transform.scale(
                      scale: viewContext.watch<MediaSettingsBloc>().state.sp(3),
                      child: CircularProgressIndicator(
                        strokeWidth:
                            viewContext.watch<MediaSettingsBloc>().state.sp10,
                      ),
                    ),
                if (!viewModel.inProgress)
                  Transform.scale(
                    scale: viewContext.watch<MediaSettingsBloc>().state.sp(4),
                    child: Switch(
                      value: viewModel.userDashboard.specialDeals,
                      onChanged: (value) {
                        viewContext.read<DashboardBloc>().add(
                              DashboardEventUserNotificationUpdate(
                                userNotificationUpdate: UserNotificationUpdate(
                                  typeId: 0,
                                  enabled: value,
                                ),
                              ),
                            );
                      },
                    ),
                  ),
              ],
            ),
            ),
          ),
          SizedBox(height: viewContext.watch<MediaSettingsBloc>().state.sp10),
          const Divider(
            thickness: 3,
          ),
        ],
      ),
    );
  }

  void _showErrorMessageDialog({
    required BuildContext viewContext,
    required List<String> errorMessage,
  }) =>
      showDialog<ErrorDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ErrorDialog(
              errorMessage: errorMessage,
              onContinue: () {
                Navigator.pop(context);
                BlocProvider.of<DashboardBloc>(viewContext)
                    .add(DashboardEventGetViewModel());
              },
            );
          });
}
