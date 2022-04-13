abstract class StoreStatusPollEvent {}

class StoreStatusPollEventResetStart extends StoreStatusPollEvent {
  StoreStatusPollEventResetStart();
}

class StoreStatusPollEventPause extends StoreStatusPollEvent {
  StoreStatusPollEventPause();
}

class StoreStatusPollEventResume extends StoreStatusPollEvent {
  StoreStatusPollEventResume();
}

class StoreStatusPollEventReset extends StoreStatusPollEvent {
  StoreStatusPollEventReset();
}

class StoreStatusPollEventTick extends StoreStatusPollEvent {
  StoreStatusPollEventTick({required this.duration});

  final int duration;
}
