import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_bloc.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_event.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_state.dart';
import 'package:single_store_app/src/app/select/widgets/business_information_widget.dart';
import 'package:single_store_app/src/app/select/widgets/select_banner_image_widget.dart';
import 'package:single_store_app/src/app/select/widgets/select_status_widget.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_event.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_continue_widget.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

class StoreSelectView extends StatelessWidget {
  const StoreSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreSelectBloc(
        businessSelectBloc: BlocProvider.of<BusinessSelectBloc>(context),
      )..add(StoreSelectEventGetViewModel()),
      child: BlocBuilder<StoreSelectBloc, StoreSelectState>(
          builder: (viewContext, state) {
        return Column(
          children: [
            ViewTitleWidget(
              title: viewContext.read<BusinessSelectBloc>().state.title,
            ),
            Expanded(
              child: _view(viewContext, state),
            ),
          ],
        );
      }),
    );
  }

  Widget _view(BuildContext viewContext, StoreSelectState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _stores(viewContext, viewState as StoreSelectStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<StoreSelectBloc>()
                .add(StoreSelectEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorContinueWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            continueCallback: () => viewContext
                .read<StoreSelectBloc>()
                .add(StoreSelectEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _stores(
    BuildContext viewContext,
    StoreSelectStateViewModel viewModel,
  ) {
    return viewModel.multiStoreSettings.stores.isEmpty
        ? const EmptyListWidget(label: 'No Stores')
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: viewModel.multiStoreSettings.stores.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () => viewContext
                      .read<BusinessSelectBloc>()
                      .add(BusinessSelectEventSelect(
                        selectedIdentity: viewModel
                            .multiStoreSettings.stores[index].businessIdentity,
                      )),
                  child: Column(
                    children: [
                      SelectBannerImageWidget(
                        storeSettings:
                            viewModel.multiStoreSettings.stores[index],
                      ),
                      if (!viewContext.watch<MediaSettingsBloc>().state.gtLg)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BusinessInformationWidget(
                                storeSettings:
                                    viewModel.multiStoreSettings.stores[index],
                                fullWidth: true,
                              ),
                              viewContext
                                  .watch<MediaSettingsBloc>()
                                  .state
                                  .formFieldPaddingH,
                              SelectStatusWidget(
                                storeSettings:
                                    viewModel.multiStoreSettings.stores[index],
                              ),
                            ],
                          ),
                        ),
                      if (viewContext.watch<MediaSettingsBloc>().state.gtLg)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BusinessInformationWidget(
                                storeSettings:
                                    viewModel.multiStoreSettings.stores[index],
                                fullWidth: false,
                              ),
                              Expanded(
                                  child: SelectStatusWidget(
                                storeSettings:
                                    viewModel.multiStoreSettings.stores[index],
                              )),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
