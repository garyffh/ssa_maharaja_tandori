import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/widgets/address_update_widget.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view_scroll.dart';

class AddressUpdateView extends StatelessWidget {
  const AddressUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubViewScroll(
      title: 'Address',
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
          child: AddressUpdateWidget(
            saveAddress: true,
            showCompany: true,
            onSubmitAddress: (address) {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
