import 'package:flutter_bloc/flutter_bloc.dart';
import 'media_settings_event.dart';
import 'media_settings_state.dart';

class MediaSettingsBloc extends Bloc<MediaSettingsEvent, MediaSettingsState> {
  MediaSettingsBloc() : super(MediaSettingsStateDefault()) {
    on<MediaSettingsEventUpdate>((event, emit) async {
      emit(
        MediaSettingsStateUpdate(event.appMediaDevice),
      );
    });
  }

}
