import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_bloc.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_event.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_state.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

class PhoneUpdateView extends StatelessWidget {
  const PhoneUpdateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubView(
      title: 'Mobile',
      child: PhoneUpdateWidget(
        phoneUpdateConsumer: (
          BuildContext phoneUpdateWidgetContext,
          FormGroup phoneUpdateForm,
          PhoneUpdateWidgetState phoneUpdateWidgetState,
        ) {
          return FormProgressButton(
            text: 'Submit',
            progressFormView: phoneUpdateWidgetState,
            onPressed: onPressedSubmitButton(
              phoneUpdateWidgetContext,
              phoneUpdateForm,
              phoneUpdateWidgetState,
            ),
            dataDirection: DataDirection.none,
          );
        },
        onSubmitted: (String mobileNumber) =>
            context.read<MyAccountNavCubit>().showPhoneCode(mobileNumber),
      ),
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext phoneUpdateWidgetContext,
    FormGroup phoneUpdateForm,
    PhoneUpdateWidgetState phoneUpdateWidgetState,
  ) {
    return phoneUpdateForm.valid
        ? () {
            if (phoneUpdateWidgetState.hasError) {
              phoneUpdateWidgetContext
                  .read<PhoneUpdateWidgetBloc>()
                  .add(PhoneUpdateWidgetEventResetError());
            } else if (!phoneUpdateWidgetState.inProgress) {
              phoneUpdateWidgetContext.read<PhoneUpdateWidgetBloc>().add(
                    PhoneUpdateWidgetEventSubmit(
                      mobile: (phoneUpdateForm.value['mobile']! as String).trim(),
                    ),
                  );
            }
          }
        : null;
  }
}
