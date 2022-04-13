import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';

class UserAddressWidget extends StatelessWidget {
  const UserAddressWidget({
    required this.userAddress,
    this.showCountry = true,
    Key? key,
  }) : super(key: key);

  final UserAddress? userAddress;
  final bool showCountry;

  @override
  Widget build(BuildContext context) {
    if (userAddress == null) {
      return const SizedBox.shrink();
    } else {
      if (userAddress!.street == null) {
        return const SizedBox.shrink();
      } else {
        return AddressWidget(
          company: userAddress!.company,
          companyNumber: userAddress!.companyNumber,
          addressNote: userAddress!.addressNote,
          street: userAddress!.street,
          extended: userAddress!.extended,
          locality: userAddress!.locality,
          region: userAddress!.region,
          postalCode: userAddress!.postalCode,
          country: userAddress!.country,
        );
      }
    }
  }
}
