import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';

@immutable
abstract class SitemDetailState extends ProgressViewState {
  const SitemDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);


  String get title => 'Selling Item';

}

class SitemDetailStateInitial extends SitemDetailState {
  const SitemDetailStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class SitemDetailStateLoadingError extends SitemDetailState {
  const SitemDetailStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );


}

abstract class SitemDetailStateViewModel extends SitemDetailState {
  const SitemDetailStateViewModel({
    required this.sitemDetail,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
    error: error,
    type: type,
  );

  final SitemDetail sitemDetail;

  @override
  String get title => sitemDetail.name;

}

class SitemDetailStateViewLoaded extends SitemDetailStateViewModel {
  const SitemDetailStateViewLoaded({
    required SitemDetail sitemDetail,
  }) : super(
    sitemDetail: sitemDetail,
    type: ProgressErrorStateType.loaded,

  );

}

class SitemDetailStateProgressError extends SitemDetailStateViewModel {
  const SitemDetailStateProgressError({
    required SitemDetail sitemDetail,
    dynamic error,
  }) : super(
    sitemDetail: sitemDetail,
    type: ProgressErrorStateType.progressError,
    error: error,
  );

}
