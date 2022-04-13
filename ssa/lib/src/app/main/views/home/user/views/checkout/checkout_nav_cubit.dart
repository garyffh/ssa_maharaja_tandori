import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'checkout_nav_state.dart';

class CheckoutNavCubit extends Cubit<CheckoutNavState> {
  CheckoutNavCubit() : super(CheckoutNavStateStepperView());

  void showStepper() => emit(CheckoutNavStateStepperView());

  void showComplete(TrnOrder trnOrder) => emit(CheckoutNavStateCompleteView(trnOrder: trnOrder));


}
