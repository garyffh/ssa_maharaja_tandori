import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/multi_store/multi_store_settings.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_event.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_state.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_state.dart';

class StoreSelectBloc extends Bloc<StoreSelectEvent, StoreSelectState> {
  StoreSelectBloc({
    required this.businessSelectBloc,
  }) : super(const StoreSelectStateInitial()) {

    on<StoreSelectEventGetViewModel>((event, emit) async {
      try {
        emit(const StoreSelectStateLoadingError());

        if (businessSelectBloc.state.type == BusinessSelectStateType.pending) {
          throw StoreSelectStateLoadingError.fromUnexpectedState();
        }

        emit(StoreSelectStateViewModel(
          multiStoreSettings: MultiStoreSettings.clone(
            (businessSelectBloc.state as BusinessSelectStateView)
                .multiStoreSettings,
          ),
        ));
      } on StoreSelectStateLoadingError catch (e) {
        emit(e);
      } catch (e) {
        emit(StoreSelectStateLoadingError(error: e));
      }
    });
  }

  final BusinessSelectBloc businessSelectBloc;

}
