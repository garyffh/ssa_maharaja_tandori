import 'package:flutter/material.dart';

import 'button_group_orientation.dart';

class ButtonGroupCheckbox<T> extends StatefulWidget {
  const ButtonGroupCheckbox({
    Key? key,
    required this.items,
    required this.selectedItems,
    this.disabledItems,
    this.onChange,
    this.onSelected,
    this.orientation = ButtonGroupOrientation.vertical,
    this.itemBuilder,
    this.selectedColor,
    this.tristate = false,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final List<T> items;
  final List<T> selectedItems;
  final List<T>? disabledItems;
  final void Function(bool isChecked, T item, int index)? onChange;
  final void Function(List<T> items)? onSelected;
  final ButtonGroupOrientation orientation;
  final Widget Function(
      Checkbox checkbox,
      bool disabledItem,
      ButtonGroupOrientation buttonGroupOrientation,
      T item,
      int index)? itemBuilder;
  final Color? selectedColor;
  final bool tristate;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  _ButtonGroupCheckboxState createState() => _ButtonGroupCheckboxState<T>();
}

class _ButtonGroupCheckboxState<T> extends State<ButtonGroupCheckbox<T>> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [];

    for (int index = 0; index < widget.items.length; index++) {
      final bool selectedItem =
          widget.selectedItems.contains(widget.items[index]);
      final disabledItem = widget.disabledItems != null &&
          widget.disabledItems!.contains(widget.items[index]);

      final Checkbox checkbox = Checkbox(
        value: selectedItem,
        onChanged: disabledItem
            ? null
            : (bool? isChecked) => _onChanged(isChecked, index),
        tristate: widget.tristate,
      );

      if (widget.itemBuilder != null) {
        content.add(
          Container(
            color: selectedItem ? widget.selectedColor : null,
            child: widget.itemBuilder!(checkbox, disabledItem,
                widget.orientation, widget.items[index], index),
          ),
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
              color: selectedItem ? widget.selectedColor : null,
              child: Row(children: <Widget>[
                const SizedBox(width: 12.0),
                checkbox,
                const SizedBox(width: 12.0),
                text,
              ]),
            ),
          );
        } else {
          content.add(
            Container(
              color: selectedItem ? widget.selectedColor : null,
              child: Column(
                children: <Widget>[
                  checkbox,
                  const SizedBox(width: 12.0),
                  text,
                ],
              ),
            ),
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

  void _onChanged(bool? isChecked, int index) {
    final bool selectedItem =
        widget.selectedItems.contains(widget.items[index]);

    if (mounted && isChecked != null) {
      setState(() {
        if (!isChecked && selectedItem) {
          widget.selectedItems.remove(widget.items[index]);
        } else if (isChecked && !selectedItem) {
          widget.selectedItems.add(widget.items[index]);
        }

        if (widget.onChange != null) {
          widget.onChange!(isChecked, widget.items[index], index);
        }
        if (widget.onSelected != null) {
          widget.onSelected!(widget.selectedItems);
        }
      });
    }
  }
}
