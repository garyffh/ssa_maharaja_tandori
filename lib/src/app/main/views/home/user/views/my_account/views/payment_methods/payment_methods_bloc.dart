import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_event.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/views/payment_methods/payment_methods_state.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  PaymentMethodsBloc({required this.paymentMethodRepo})
      : super(const PaymentMethodsStateInitial()) {
    on<PaymentMethodsEventGetViewModel>((event, emit) async {
      try {
        emit(const PaymentMethodsStateLoadingError());

        final List<UserPaymentMethod> paymentMethods =
            await paymentMethodRepo.readUserPaymentMethods();

        emit(PaymentMethodsStateViewModel(
          paymentMethods: paymentMethods,
        ));
      } catch (e) {
        emit(PaymentMethodsStateLoadingError(error: e));
      }
    });

    on<PaymentMethodsEventDelete>((event, emit) async {
      try {
        emit(const PaymentMethodsStateProgressError());

        await paymentMethodRepo.deleteUserPaymentMethod(
          content: event.userPaymentMethod,
        );

        final List<UserPaymentMethod> paymentMethods =
            await paymentMethodRepo.readUserPaymentMethods();

        emit(PaymentMethodsStateViewModel(
          paymentMethods: paymentMethods,
        ));
      } catch (e) {
        emit(PaymentMethodsStateProgressError(error: e));
      }
    });

    on<PaymentMethodsEventDefault>((event, emit) async {
      try {
        emit(const PaymentMethodsStateProgressError());

        await paymentMethodRepo.defaultUserPaymentMethod(
          content: event.userPaymentMethod,
        );

        final List<UserPaymentMethod> paymentMethods =
            await paymentMethodRepo.readUserPaymentMethods();

        emit(PaymentMethodsStateViewModel(
          paymentMethods: paymentMethods,
        ));
      } catch (e) {
        emit(PaymentMethodsStateProgressError(error: e));
      }
    });
  }

  final PaymentMethodRepo paymentMethodRepo;

}
