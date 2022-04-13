import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';

class CheckoutAddressWidget extends StatelessWidget {
  const CheckoutAddressWidget({
    required this.trnCheckoutAddress,
    this.showCountry = true,
    Key? key,
  }) : super(key: key);

  final TrnCheckoutAddress? trnCheckoutAddress;
  final bool showCountry;

  @override
  Widget build(BuildContext context) {
    if (trnCheckoutAddress == null) {
      return const SizedBox.shrink();
    } else {
      if (trnCheckoutAddress!.street == null ||
          trnCheckoutAddress!.locality == null ||
          trnCheckoutAddress!.region == null ||
          trnCheckoutAddress!.postalCode == null ||
          trnCheckoutAddress!.country == null) {
        return const SizedBox.shrink();
      } else {
        return AddressWidget(
          company: trnCheckoutAddress!.company,
          companyNumber: trnCheckoutAddress!.companyNumber,
          addressNote: trnCheckoutAddress!.addressNote,
          street: trnCheckoutAddress!.street,
          extended: trnCheckoutAddress!.extended,
          locality: trnCheckoutAddress!.locality,
          region: trnCheckoutAddress!.region,
          postalCode: trnCheckoutAddress!.postalCode,
          country: trnCheckoutAddress!.country,
        );
      }
    }
  }
}
