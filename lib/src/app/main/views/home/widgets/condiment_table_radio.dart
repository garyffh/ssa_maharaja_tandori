import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table_item.dart';
import 'package:single_store_app/src/app/widgets/ui/button_group_orientation.dart';
import 'package:single_store_app/src/app/widgets/ui/button_group_radio.dart';

class CondimentTableRadio extends StatelessWidget {
  const CondimentTableRadio({
    required this.cartCondimentTable,
    this.onSelected,
    Key? key,
  }) : super(key: key);

  final CartCondimentTable cartCondimentTable;
  final void Function(String? selectedItemsText)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ButtonGroupRadio<CartCondimentTableItem>(
      items: cartCondimentTable.items,
      selectedItems: cartCondimentTable.selectedItems,
      selectedColor: Theme.of(context).colorScheme.background,
      onSelected: (CartCondimentTableItem? selected) {
        if (onSelected != null) {
          if (selected == null) {
            onSelected!(null);
          } else {
            onSelected!(selected.name.trim());
          }
        }
      },
      itemBuilder: (
        Radio radioButton,
        bool disabledItem,
        ButtonGroupOrientation buttonGroupOrientation,
        CartCondimentTableItem item,
        int index,
      ) {
        final TextStyle textStyle = disabledItem
            ? Theme.of(context)
                .textTheme
                .bodyText2!
                .apply(color: Theme.of(context).disabledColor)
            : Theme.of(context).textTheme.bodyText2!;

        return Row(
          children: <Widget>[
            const SizedBox(width: 12.0),
            radioButton,
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                item.name,
                style: textStyle,
              ),
            ),
            if (item.price != 0)
              Text(
                Formats.currency(item.price),
                style: textStyle,
              ),
          ],
        );
      },
    );
  }
}
