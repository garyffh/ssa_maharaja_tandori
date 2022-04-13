import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/models/user/user_phone_verify.dart';

import 'phone_update_widget_event.dart';
import 'phone_update_widget_state.dart';

class PhoneUpdateWidgetBloc
    extends Bloc<PhoneUpdateWidgetEvent, PhoneUpdateWidgetState> {
  PhoneUpdateWidgetBloc({
    required this.userRepo,
  }) : super(const PhoneUpdateWidgetStateIdle()) {
    on<PhoneUpdateWidgetEventSubmit>((event, emit) async {
      try {
        emit(const PhoneUpdateWidgetStateProgressError());

        final UserPhoneVerify userPhoneVerify = await userRepo.phoneVerify(
          userPhoneVerify: UserPhoneVerify(
            updateId: Uint8List(0),
            mobileNumber: event.mobile,
          ),
        );

        emit(PhoneUpdateWidgetStateSubmitted(
          mobileNumber: userPhoneVerify.mobileNumber,
        ));
      } catch (e) {
        emit(PhoneUpdateWidgetStateProgressError(error: e));
      }
    });

    on<PhoneUpdateWidgetEventResetError>((event, emit) async {
      emit(const PhoneUpdateWidgetStateIdle());
    });
  }

  final UserRepo userRepo;

}
