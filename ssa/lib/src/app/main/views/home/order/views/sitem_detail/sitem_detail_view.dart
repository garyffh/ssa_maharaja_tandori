import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/sitem_repo.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/order/widgets/sitem_detail_progress_error_widget.dart';
import 'package:single_store_app/src/app/main/views/home/order/widgets/sitem_image_widget.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_loading_error_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view_scroll.dart';

import 'sitem_detail_bloc.dart';
import 'sitem_detail_event.dart';
import 'sitem_detail_state.dart';

class SitemDetailView extends StatelessWidget {
  const SitemDetailView({
    required this.initialSitemId,
    Key? key,
  }) : super(key: key);

  final String initialSitemId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SitemDetailBloc(
        appNavigatorCubit: context.read<AppNavigatorCubit>(),
        storeStatusBloc: context.read<StoreStatusBloc>(),
        appFloatingButtonCubit: context.read<AppFloatingButtonCubit>(),
        homeNavCubit: context.read<HomeNavCubit>(),
        sitemRepo: context.read<SitemRepo>(),
      )..add(SitemDetailEventInitialViewModel(sysSitemId: initialSitemId)),
      child: BlocBuilder<SitemDetailBloc, SitemDetailState>(
        builder: (viewContext, state) {
          return SubViewScroll(
            title: state.title,
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, SitemDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.progressError:
        {
          return _viewModel(
              viewContext, viewState as SitemDetailStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(minHeight: 107.0),
              child: FormLoadingErrorWidget(
                progressFormView: viewState,
                dataDirection: DataDirection.receiving,
                tryAgainCallback: () => viewContext.read<SitemDetailBloc>().add(
                    SitemDetailEventInitialViewModel(
                        sysSitemId: initialSitemId)),
              ),
            ),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const SingleChildScrollView(
            child: UnhandledStateWidget(),
          );
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    SitemDetailStateViewModel viewState,
  ) {
    if (viewState.type == ProgressErrorStateType.progressError) {
      return SingleChildScrollView(
        child: SitemDetailProgressErrorWidget(
          progressFormView: viewState,
          continueCallback: () => viewContext
              .read<SitemDetailBloc>()
              .add(SitemDetailEventResetError()),
        ),
      );
    } else {
      return Stack(
        children: [
          _sitemDetail(viewContext, viewState),
          _buttons(viewContext, viewState),
        ],
      );
    }
  }

  Widget _sitemDetail(
      BuildContext viewContext, SitemDetailStateViewModel viewState) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 8) {
          viewContext.read<SitemDetailBloc>().add(
                SitemDetailEventPrevious(
                    pagePosition: viewState.sitemDetail.pagePosition),
              );
        } else if (details.delta.dx < -8) {
          viewContext.read<SitemDetailBloc>().add(
                SitemDetailEventNext(
                    pagePosition: viewState.sitemDetail.pagePosition),
              );
        }
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SitemImageWidget(
                  sysSitemId: viewState.sitemDetail.sysSitemId,
                  hasImage: viewState.sitemDetail.hasImage,
                ),
                _sitemText(viewContext, viewState),
                SizedBox(
                  height: viewContext.watch<MediaSettingsBloc>().state.sp(38),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _sitemText(
      BuildContext viewContext, SitemDetailStateViewModel viewState) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(viewContext.watch<MediaSettingsBloc>().state.sp12),
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          Text(
            viewState.sitemDetail.description,
            textAlign: TextAlign.center,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          if (viewState.sitemDetail.isOnSpecial(
              viewContext.watch<UserBusinessBloc>().state.priceLevel))
            Container(
              padding: EdgeInsets.symmetric(
                vertical: viewContext.watch<MediaSettingsBloc>().state.sp12,
              ),
              child: Text(
                'ON SPECIAL - NORMALLY ${Formats.currency(viewState.sitemDetail.regularPrice(viewContext.watch<UserBusinessBloc>().state.priceLevel))}',
                style: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .bodyText1
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          Text(
            Formats.currency(viewState.sitemDetail
                .price(viewContext.watch<UserBusinessBloc>().state.priceLevel)),
            style: viewContext.watch<MediaSettingsBloc>().state.headline6,
          ),
        ],
      ),
    );
  }

  Widget _buttons(
      BuildContext viewContext, SitemDetailStateViewModel viewState) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 730),
        child: Column(
          children: [
            const SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _previousButton(viewContext, viewState),
                _nextButton(viewContext, viewState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _previousButton(
      BuildContext viewContext, SitemDetailStateViewModel viewState) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: FloatingActionButton(
        child: const Icon(Icons.arrow_left),
        onPressed: () => viewContext.read<SitemDetailBloc>().add(
              SitemDetailEventPrevious(
                  pagePosition: viewState.sitemDetail.pagePosition),
            ),
      ),
    );
  }

  Widget _nextButton(
      BuildContext viewContext, SitemDetailStateViewModel viewState) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: FloatingActionButton(
        child: const Icon(Icons.arrow_right),
        onPressed: () => viewContext.read<SitemDetailBloc>().add(
              SitemDetailEventNext(
                  pagePosition: viewState.sitemDetail.pagePosition),
            ),
      ),
    );
  }
}
