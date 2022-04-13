import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_card_widget_type.dart';

import 'checkout_address_widget.dart';

class CheckoutAddressEdit extends StatelessWidget {
  const CheckoutAddressEdit({
    required this.trnCheckoutAddress,
    this.showCountry = true,
    this.onEdit,
    Key? key,
  }) : super(key: key);

  final TrnCheckoutAddress? trnCheckoutAddress;
  final bool showCountry;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return ActionCardWidget(
      title: 'Address',
      content: CheckoutAddressWidget(
        trnCheckoutAddress: trnCheckoutAddress,
        showCountry: showCountry,
      ),
      actionCardWidgetType: ActionCardWidgetType.edit,
      onPressed: onEdit,
    );
  }
}
