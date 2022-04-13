import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_event.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_state.dart';

class StoreStatusDisplayBloc
    extends Bloc<StoreStatusDisplayEvent, StoreStatusDisplayState> {
  StoreStatusDisplayBloc()
      : super(const StoreStatusDisplayState(showBanner: true)) {
    on<StoreStatusDisplayEventUpdateBanner>((event, emit) async {
      emit(StoreStatusDisplayState(
        showBanner: event.showBanner,
      ));
    });
  }

}
