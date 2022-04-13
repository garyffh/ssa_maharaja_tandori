import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/infrastructure/dialog_message.dart';
import 'package:single_store_app/src/app/widgets/ui/message_dialog.dart';
import 'app_navigator_state.dart';

class AppNavigatorCubit extends Cubit<AppNavigatorState> {
  AppNavigatorCubit() : super(AppNavigatorState.initial());

  void showMessageDialog(DialogMessage dialogMessage) {
    if (state.dialogCount > 0) {
      Navigator.pop(state.navigatorKey.currentContext!);
    }

    emit(AppNavigatorState.incrementDialogCount(state));
    showDialog<MessageDialog>(
            context: state.navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return MessageDialog(
                title: dialogMessage.title,
                content: dialogMessage.content,
              );
            })
        .then((result) => emit(AppNavigatorState.decrementDialogCount(state)));
  }

  void showCheckoutDeliveryMethodRefresh() {
    showMessageDialog(DialogMessage(
      title: 'Delivery / Pickup Time Refresh',
      content:
          'The delivery and pickup times have been updated. Reselect your time',
    ));
  }

  void showStoreClosed() {
    showMessageDialog(DialogMessage(title: 'Closed', content: AppConstants.cartClosedMessage));
  }

  void showMinimumDeliveryError(double minOrder, double addToOrder,) {
    showMessageDialog(DialogMessage(
      title: 'Minimum delivery ${Formats.currency(minOrder)}',
      content:
      'For delivery, add ${Formats.currency(addToOrder)} to your order.',
    ));
  }

}
