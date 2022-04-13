import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';

import 'password_update_event.dart';
import 'password_update_state.dart';

class PasswordUpdateBloc
    extends Bloc<PasswordUpdateEvent, PasswordUpdateState> {
  PasswordUpdateBloc({
    required this.userRepo,
    required this.myAccountNavCubit,
  }) : super(const PasswordUpdateStateIdle()) {
    on<PasswordUpdateEventSubmit>((event, emit) async {
      try {
        emit(const PasswordUpdateStateProgressError());

        await userRepo.passwordUpdate(
          userPasswordUpdate: event.userPasswordUpdate,
        );

        myAccountNavCubit.showPasswordUpdateConfirmation();

        emit(const PasswordUpdateStateIdle());
      } catch (e) {
        emit(PasswordUpdateStateProgressError(error: e));
      }
    });

    on<PasswordUpdateEventResetError>((event, emit) async {
      emit(const PasswordUpdateStateIdle());
    });
  }

  final UserRepo userRepo;
  final MyAccountNavCubit myAccountNavCubit;
}
