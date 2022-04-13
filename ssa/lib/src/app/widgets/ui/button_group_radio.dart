import 'package:flutter/material.dart';

import 'button_group_orientation.dart';

class ButtonGroupRadio<T> extends StatefulWidget {
  const ButtonGroupRadio({
    Key? key,
    required this.items,
    required this.selectedItems,
    this.disabledItems,
    this.onChange,
    this.onSelected,
    this.orientation = ButtonGroupOrientation.vertical,
    this.itemBuilder,
    this.selectedColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final List<T> items;
  final List<T> selectedItems;
  final List<T>? disabledItems;
  final void Function(T? item, int index)? onChange;
  final void Function(T? item)? onSelected;
  final ButtonGroupOrientation orientation;
  final Widget Function(
      Radio radioButton,
      bool disabledItem,
      ButtonGroupOrientation buttonGroupOrientation,
      T item,
      int index)? itemBuilder;
  final Color? selectedColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  _ButtonGroupRadioState createState() => _ButtonGroupRadioState<T>();
}

class _ButtonGroupRadioState<T> extends State<ButtonGroupRadio<T>> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [];
    final T? selectedItem =
        widget.selectedItems.isEmpty ? null : widget.selectedItems[0];

    for (int index = 0; index < widget.items.length; index++) {
      final disabledItem = widget.disabledItems != null &&
          widget.disabledItems!.contains(widget.items[index]);

      final Radio radio = Radio<T>(
        groupValue: selectedItem,
        value: widget.items[index],
        onChanged: disabledItem
            ? null
            : (selected) => setState(() {
                  if (widget.selectedItems.isEmpty) {
                    widget.selectedItems.add(widget.items[index]);
                  } else {
                    widget.selectedItems[0] = widget.items[index];
                  }

                  if (widget.onChange != null) {
                    widget.onChange!(widget.items[index], index);
                  }
                  if (widget.onSelected != null) {
                    widget.onSelected!(widget.items[index]);
                  }
                }),
      );

      if (widget.itemBuilder != null) {
        content.add(
          Container(
              color: selectedItem == widget.items[index]
                  ? widget.selectedColor
                  : null,
              child: widget.itemBuilder!(radio, disabledItem,
                  widget.orientation, widget.items[index], index)),
        );
      } else {
        final Text text = Text(widget.items[index].toString(),
            style: disabledItem
                ? Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(color: Theme.of(context).disabledColor)
                : Theme.of(context).textTheme.bodyText2);

        if (widget.orientation == ButtonGroupOrientation.vertical) {
          content.add(
            Container(
                color: selectedItem == widget.items[index]
                    ? widget.selectedColor
                    : null,
                child: Row(children: <Widget>[
                  const SizedBox(width: 12.0),
                  radio,
                  const SizedBox(width: 12.0),
                  text,
                ])),
          );
        } else {
          content.add(
            Container(
                color: selectedItem == widget.items[index]
                    ? widget.selectedColor
                    : null,
                child: Column(children: <Widget>[
                  radio,
                  const SizedBox(width: 12.0),
                  text,
                ])),
          );
        }
      }
    }

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: widget.orientation == ButtonGroupOrientation.vertical
          ? Column(children: content)
          : Row(children: content),
    );
  }
}
