import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_state.dart';

class PasswordCodeBloc extends Bloc<PasswordCodeEvent, PasswordCodeState> {
  PasswordCodeBloc({
    required this.authenticateNavCubit,
  }) : super(const PasswordCodeStateIdle()) {
    on<PasswordCodeEventSubmit>((event, emit) async {
      try {
        emit(const PasswordCodeStateIdle());

        authenticateNavCubit.showPasswordReset(
          email: event.email,
          code: event.code,
        );
      } catch (e) {
        emit(PasswordCodeStateProgressError(error: e));
      }
    });

    on<PasswordCodeEventResetError>((event, emit) async {
      emit(const PasswordCodeStateIdle());
    });
  }

  final AuthenticateNavCubit authenticateNavCubit;
}
