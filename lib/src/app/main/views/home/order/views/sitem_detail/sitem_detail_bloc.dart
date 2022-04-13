import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/sitem_repo.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_state.dart';
import 'package:single_store_app/src/app/models/business/open_status.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';

import 'sitem_detail_event.dart';
import 'sitem_detail_state.dart';

class SitemDetailBloc extends Bloc<SitemDetailEvent, SitemDetailState> {
  SitemDetailBloc({
    required this.appNavigatorCubit,
    required this.storeStatusBloc,
    required this.appFloatingButtonCubit,
    required this.homeNavCubit,
    required this.sitemRepo,
  }) : super(const SitemDetailStateInitial()) {
    on<SitemDetailEventInitialViewModel>((event, emit) async {
      try {
        emit(const SitemDetailStateLoadingError());
        appFloatingButtonCubit.removeFloatingButton();

        emit(SitemDetailStateViewLoaded(
          sitemDetail:
              await sitemRepo.findSitemDetail(sysSitemId: event.sysSitemId),
        ));

        appFloatingButtonCubit.showFloatingButton(
          floatingActionButton: _addToCartButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      } catch (e) {
        emit(SitemDetailStateLoadingError(error: e));
      }
    });

    on<SitemDetailEventResetError>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();

      if (state is SitemDetailStateViewModel) {
        emit(SitemDetailStateViewLoaded(
          sitemDetail: (state as SitemDetailStateViewModel).sitemDetail,
        ));

        appFloatingButtonCubit.showFloatingButton(
          floatingActionButton: _addToCartButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      } else {
        emit(SitemDetailStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<SitemDetailEventPrevious>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();
      if (state is SitemDetailStateViewModel) {
        final SitemDetail sitemDetail =
            (state as SitemDetailStateViewModel).sitemDetail;

        try {
          emit(SitemDetailStateProgressError(
            sitemDetail: sitemDetail,
          ));

          emit(SitemDetailStateViewLoaded(
            sitemDetail: await sitemRepo.findPreviousDetail(
                pagePosition: event.pagePosition),
          ));
          appFloatingButtonCubit.showFloatingButton(
            floatingActionButton: _addToCartButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } catch (e) {
          emit(SitemDetailStateProgressError(
            sitemDetail: sitemDetail,
            error: e,
          ));
        }
      } else {
        emit(SitemDetailStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });

    on<SitemDetailEventNext>((event, emit) async {
      appFloatingButtonCubit.removeFloatingButton();
      if (state is SitemDetailStateViewModel) {
        final SitemDetail sitemDetail =
            (state as SitemDetailStateViewModel).sitemDetail;

        try {
          emit(SitemDetailStateProgressError(
            sitemDetail: sitemDetail,
          ));

          emit(SitemDetailStateViewLoaded(
            sitemDetail: await sitemRepo.findNextDetail(
                pagePosition: event.pagePosition),
          ));
          appFloatingButtonCubit.showFloatingButton(
            floatingActionButton: _addToCartButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } catch (e) {
          emit(SitemDetailStateProgressError(
            sitemDetail: sitemDetail,
            error: e,
          ));
        }
      } else {
        emit(SitemDetailStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final AppNavigatorCubit appNavigatorCubit;
  final StoreStatusBloc storeStatusBloc;
  final AppFloatingButtonCubit appFloatingButtonCubit;
  final HomeNavCubit homeNavCubit;
  final SitemRepo sitemRepo;


  FloatingActionButton _addToCartButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (!storeStatusBloc.state.loaded) {
          return;
        }
        final OpenStatus openStatus =
            (storeStatusBloc.state as StoreStatusStateLoaded)
                .storeStatus
                .openStatus;
        if (openStatus == OpenStatus.open) {
          if (state is SitemDetailStateViewModel) {
            homeNavCubit.showCartAdd(
              postView: HomeView.sitemDetail,
              postViewSysSitemId:
                  (state as SitemDetailStateViewModel).sitemDetail.sysSitemId,
              sitem: Sitem.fromSitemDetail(
                  (state as SitemDetailStateViewModel).sitemDetail),
            );
          }
        } else {
          appNavigatorCubit.showMessageDialog(openStatus.dialogMessage);
        }
      },
      label: const Text('ADD TO CART'),
      icon: const Icon(Icons.add_shopping_cart),
    );
  }
}
