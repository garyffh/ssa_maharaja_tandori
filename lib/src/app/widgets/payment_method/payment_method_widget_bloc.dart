import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/payment_method_repo.dart';
import 'package:single_store_app/src/app/models/user/user_payment_method_add.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_event.dart';
import 'package:single_store_app/src/app/widgets/payment_method/payment_method_widget_state.dart';

class PaymentMethodWidgetBloc
    extends Bloc<PaymentMethodWidgetEvent, PaymentMethodWidgetState> {
  PaymentMethodWidgetBloc({
    required this.paymentMethodRepo,
    required this.businessSettingsBloc,
  }) : super(const PaymentMethodWidgetStateIdle()) {
    on<PaymentMethodWidgetEventSubmit>((event, emit) async {
      try {
        emit(const PaymentMethodWidgetStateProgressError());

        final TokenData tokenData = await Stripe.instance.createToken(
          const CreateTokenParams.card(params: CardTokenParams(type: TokenType.Card)),
        );

        // final TokenData tokenData = await Stripe.instance.createToken(
        //   const CreateTokenParams(type: TokenType.Card),
        // );

        if (tokenData.type != TokenType.Card) {
          throw Exception('not a card');
        }

        final UserPaymentMethodAdd apiModel = UserPaymentMethodAdd(
          identity: businessSettingsBloc.state.identity,
          token: tokenData.id,
          status: event.cardName,
          responseMessage: '',
          hash: '',
          cardId: '',
          ivrCardId: '',
          cardKey: '',
          custom1: '',
          custom2: '',
          custom3: '',
          customHash: '',
        );

        await paymentMethodRepo.addUserPaymentMethods(
          content: apiModel,
        );

        emit(const PaymentMethodWidgetStateSubmitted());
      } on StripeException catch (e) {
        if (e.error.localizedMessage != null) {
          emit(PaymentMethodWidgetStateProgressError(
            error: AppException.fromString(e.error.localizedMessage!),
          ));
        } else {
          emit(PaymentMethodWidgetStateProgressError(error: e));
        }
      } catch (e) {
        emit(PaymentMethodWidgetStateProgressError(error: e));
      }
    });

    on<PaymentMethodWidgetEventResetError>((event, emit) async {
      emit(const PaymentMethodWidgetStateIdle());
    });
  }

  final PaymentMethodRepo paymentMethodRepo;
  final BusinessSettingsBloc businessSettingsBloc;

}
