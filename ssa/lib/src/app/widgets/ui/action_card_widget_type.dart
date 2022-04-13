import 'package:flutter/material.dart';

enum ActionCardWidgetType {
  none,
  edit,
  add,
}


extension ActionCardWidgetTypeExtension on ActionCardWidgetType {

  String get text {
    switch(this) {

      case ActionCardWidgetType.none:
        return 'NONE';

      case ActionCardWidgetType.edit:
        return 'EDIT';

      case ActionCardWidgetType.add:
        return 'ADD';


    }
  }

  IconData get iconData {
    switch(this) {

      case ActionCardWidgetType.none:
        return Icons.all_inclusive;

      case ActionCardWidgetType.edit:
        return Icons.edit;

      case ActionCardWidgetType.add:
        return Icons.add;


    }
  }


}
