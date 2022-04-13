import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_messaging_state.dart';

class AppMessagingCubit extends Cubit<AppMessagingState> {
  AppMessagingCubit() : super(const AppMessagingStateInitial());

  void publishMessage({
    required AppMessagingPublished message,
  }) =>
      emit(message);

  void publishTrnOrderUpdate({
    required AppMessagingTrnOrderUpdate message,
  }) => emit(message);

  void publishTrnOrderUserAllocateDriver({
    required AppMessagingTrnOrderUserAllocateDriver message,
  }) => emit(message);

}
