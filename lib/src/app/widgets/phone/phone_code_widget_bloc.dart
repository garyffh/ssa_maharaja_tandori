import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/models/user/user_phone_update.dart';

import 'phone_code_widget_event.dart';
import 'phone_code_widget_state.dart';

class PhoneCodeWidgetBloc
    extends Bloc<PhoneCodeWidgetEvent, PhoneCodeWidgetState> {
  PhoneCodeWidgetBloc({
    required this.userRepo,
  }) : super(const PhoneCodeWidgetStateIdle()) {
    on<PhoneCodeWidgetEventSubmit>((event, emit) async {
      try {
        emit(const PhoneCodeWidgetStateProgressError());

        String mobileNumber = event.mobileNumber;
        if (mobileNumber.indexOf(' ') > 0) {
          mobileNumber = mobileNumber.substring(
              mobileNumber.indexOf(' ') + 1, mobileNumber.length);
        }

        await userRepo.phoneUpdate(
          userPhoneUpdate: UserPhoneUpdate(
            updateId: Uint8List(0),
            mobileCode: event.mobileCode,
            mobileNumber: mobileNumber,
          ),
        );

        emit(PhoneCodeWidgetStateSubmitted(mobileNumber: mobileNumber));
      } catch (e) {
        emit(PhoneCodeWidgetStateProgressError(error: e));
      }
    });

    on<PhoneCodeWidgetEventResetError>((event, emit) async {
      emit(const PhoneCodeWidgetStateIdle());
    });
  }

  final UserRepo userRepo;

}
