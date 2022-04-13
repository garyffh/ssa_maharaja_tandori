import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_item.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/line_description_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_qty_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_total_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_unit_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';

class TrnOrderView extends StatelessWidget {
  const TrnOrderView({
    required this.trnOrder,
    Key? key,
  }) : super(key: key);

  final TrnOrder trnOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        children: [
          _header(context),
          if (trnOrder.deliveryMethodType == DeliveryMethodType.delivery ||
              trnOrder.deliveryMethodType == DeliveryMethodType.period)
            _address(context),
          _lines(context),
        ],
      ),
    );
  }

  Widget _header(
    BuildContext context,
  ) {
    return Card(
      child: Container(
        padding: context.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  NameValueWidget(
                    name: 'ORDER #',
                    value: trnOrder.reference,
                  ),
                  NameValueWidget(
                    name: 'STATUS',
                    value: trnOrder.deliveryMethodStatus.text,
                  ),
                ],
              ),
            ),
            _total(context),
            if (trnOrder.deliveryMethodType == DeliveryMethodType.store)
              ..._store(context),
            if (trnOrder.deliveryMethodType == DeliveryMethodType.delivery)
              ..._delivery(context),
            if (trnOrder.deliveryMethodType == DeliveryMethodType.table)
              ..._table(context),
            if (trnOrder.deliveryMethodType == DeliveryMethodType.period)
              ..._period(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _store(
    BuildContext context,
  ) {
    return [
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: trnOrder.deliveryMethodAsap ? 'Pickup ASAP' : 'Pickup',
          value: Formats.dayMonthTime(trnOrder.scheduledDeliveryMethodTime),
        ),
      ),
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: 'Ordered',
          value: Formats.dayMonthTime(trnOrder.orderDT),
        ),
      ),
    ];
  }

  List<Widget> _delivery(
    BuildContext context,
  ) {
    return [
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: trnOrder.deliveryMethodAsap ? 'Delivery ASAP' : 'Delivery',
          value: Formats.dayMonthTime(trnOrder.scheduledDeliveryMethodTime),
        ),
      ),
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: 'Ordered',
          value: Formats.dayMonthTime(trnOrder.orderDT),
        ),
      ),
      if (trnOrder.driver != null) _driver(context),
    ];
  }

  List<Widget> _table(
    BuildContext context,
  ) {
    return [
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [
            NameValueWidget(
              name: 'Table Number',
              value: trnOrder.orderNumber,
            ),
            NameValueWidget(
              name: 'Ordered',
              value: Formats.dayMonthTime(trnOrder.orderDT),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _period(
    BuildContext context,
  ) {
    return [
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: 'Delivery',
          value:
              '${Formats.weekDayMonthTime(trnOrder.scheduledDeliveryMethodTime)} - ${Formats.time(trnOrder.scheduledDeliveryMethodTime)}',
        ),
      ),
      Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: NameValueWidget(
          name: 'Ordered',
          value: Formats.dayMonthTime(trnOrder.orderDT),
        ),
      ),
      if (trnOrder.driver != null) _driver(context),
    ];
  }

  Widget _total(
    BuildContext context,
  ) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: NameValueWidget(
        name: 'Total',
        value: Formats.currency(trnOrder.total),
      ),
    );
  }

  Widget _driver(
    BuildContext context,
  ) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: NameValueWidget(
        name: 'Vehicle',
        value:
            '${trnOrder.driver!.colour} ${trnOrder.driver!.make} ${trnOrder.driver!.model} (${trnOrder.driver!.plate})',
      ),
    );
  }

  Widget _address(
    BuildContext context,
  ) {
    return Card(
      child: Container(
        padding: context.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver To',
                style: context.watch<MediaSettingsBloc>().state.subtitle2.bold),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            AddressWidget(
              addressNote: trnOrder.addressNote,
              street: trnOrder.street,
              extended: trnOrder.extended,
              locality: trnOrder.locality,
              region: trnOrder.region,
              postalCode: trnOrder.postalCode,
              country: trnOrder.country,
              showCountry: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _lines(
    BuildContext context,
  ) {
    final List<TrnOrderItem> readableItems = trnOrder.readableItems();

    return Card(
      child: Container(
        padding: context.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth(context.watch<MediaSettingsBloc>().state.sp30),
            1: const FlexColumnWidth(),
            2: const IntrinsicColumnWidth(),
            3: const IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: List<TableRow>.generate(readableItems.length, (index) {
            final TrnOrderItem item = readableItems[index];
            return TableRow(
              children: <Widget>[
                LineQtyCell(
                  show: item.itemTypeId == 3,
                  isScale: item.isScale,
                  qty: item.qty,
                ),
                LineDescriptionCell(
                  isCondiment: item.isCondiment,
                  isInstructions: item.isInstructions,
                  description: item.description,
                ),
                LineUnitCell(
                  isCondiment: item.isCondiment,
                  unit: item.unitPrice,
                ),
                LineTotalCell(
                  isCondiment: item.isCondiment,
                  total: item.total,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
