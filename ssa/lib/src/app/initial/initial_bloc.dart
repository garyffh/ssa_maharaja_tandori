import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';

import 'initial_event.dart';
import 'initial_repo.dart';
import 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  InitialBloc({required this.initialRepo})
      : super(const InitialStateProgressError()) {
    on<InitialEventLoad>((event, emit) async {
      try {
        emit(const InitialStateProgressError());
        // yield await initialRepo.fakeGetServerBusinessSettings(FakeHttp(fakeError: FakeError.noInternet));
        // throw  AppException(message: ['This is a test error', 'and the resulting details', 'of the test error message']);
        // throw  const SocketException('Socket Exception');
        // throw const HttpException('this is a http exception');
        // throw const FormatException('this is a format exception');
        // throw Exception('this is an exception');

        Intl.defaultLocale = AppConstants.defaultLocaleString;
        initializeDateFormatting(Intl.defaultLocale);

        emit(await initialRepo.getServerMultiStoreSettings());
      } catch (e) {
        emit(InitialStateProgressError(error: e));
      }
    });
  }

  final InitialRepo initialRepo;

}
