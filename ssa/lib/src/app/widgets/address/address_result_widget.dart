import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/user/address_result.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';

class AddressResultWidget extends StatelessWidget {
  const AddressResultWidget({
    required this.addressResult,
    this.showCountry = true,
    Key? key,
  }) : super(key: key);

  final AddressResult? addressResult;
  final bool showCountry;

  @override
  Widget build(BuildContext context) {
    if (addressResult == null) {
      return const SizedBox.shrink();
    } else {
      if (addressResult!.street == null) {
        return const SizedBox.shrink();
      } else {
        return AddressWidget(
          company: null,
          companyNumber: null,
          addressNote: null,
          street: addressResult!.street,
          extended: addressResult!.extended,
          locality: addressResult!.locality,
          region: addressResult!.region,
          postalCode: addressResult!.postalCode,
          country: addressResult!.country,
        );
      }
    }
  }
}
