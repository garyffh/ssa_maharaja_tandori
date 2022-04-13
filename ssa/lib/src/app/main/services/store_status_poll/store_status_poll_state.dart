import 'package:flutter/cupertino.dart';

@immutable
abstract class StoreStatusPollState {
  const StoreStatusPollState({
    required this.duration,
  });

  final int duration;
}

class StoreStatusPollStateInitial extends StoreStatusPollState {
  const StoreStatusPollStateInitial(int duration) : super(duration: duration);
}

class StoreStatusPollStateRunPaused extends StoreStatusPollState {
  const StoreStatusPollStateRunPaused(int duration) : super(duration: duration);
}

class StoreStatusPollStateRunInProgress extends StoreStatusPollState {
  const StoreStatusPollStateRunInProgress(int duration) : super(duration: duration);
}

class StoreStatusPollStateRunCompleted extends StoreStatusPollState {
  const StoreStatusPollStateRunCompleted() : super(duration: 0);
}
