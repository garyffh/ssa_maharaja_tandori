import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_account_nav_state.dart';

class MyAccountNavCubit extends Cubit<MyAccountNavState> {
  MyAccountNavCubit() : super(MyAccountNavStateDashboardView());

  void showDashBoard() => emit(MyAccountNavStateDashboardView());

  void showPaymentMethods() => emit(MyAccountNavStatePaymentMethodsView());

  void showPaymentMethodAdd() => emit(MyAccountNavStatePaymentMethodAddView());

  void showAddressUpdate() => emit(MyAccountNavStateAddressUpdateView());

  void showPasswordUpdate() => emit(MyAccountNavStatePasswordUpdateView());

  void showPasswordUpdateConfirmation() => emit(MyAccountNavStatePasswordUpdateConfirmationView());

  void showPhoneUpdate() => emit(MyAccountNavStatePhoneUpdateView());

  void showPhoneCode(String mobileNumber) => emit(MyAccountNavStatePhoneCodeView(mobileNumber: mobileNumber));

}
