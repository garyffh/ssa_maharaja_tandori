import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_code_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

class PhoneCodeView extends StatelessWidget {
  const PhoneCodeView({
    required this.mobileNumber,
    Key? key,
  }) : super(key: key);

  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return SubView(
      title: 'Mobile Code',
      child: PhoneCodeWidget(
        mobileNumber: mobileNumber,
        onSubmitted: (mobileNumber) => context.read<MyAccountNavCubit>().showDashBoard(),
      ),
    );
  }
}
