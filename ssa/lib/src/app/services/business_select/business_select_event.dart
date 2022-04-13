import 'package:single_store_app/src/app/initial/initial_state.dart';

abstract class BusinessSelectEvent {}

class BusinessSelectEventLoad extends BusinessSelectEvent {
  BusinessSelectEventLoad({required this.initialStateLoaded});

  final InitialStateLoaded initialStateLoaded;

}

class BusinessSelectEventUnselect extends BusinessSelectEvent {
  BusinessSelectEventUnselect();

}

class BusinessSelectEventSelect extends BusinessSelectEvent {
  BusinessSelectEventSelect({required this.selectedIdentity});

  final String selectedIdentity;

}
