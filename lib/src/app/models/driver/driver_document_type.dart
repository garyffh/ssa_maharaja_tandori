import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/strings/driver_document_type.constants.dart';

enum DriverDocumentType {
@JsonValue(0)
invoice,
@JsonValue(1)
credit,
@JsonValue(2)
payment,
}

extension DriverDocumentTypeExtension on DriverDocumentType {

  String get text {
    switch(this) {

      case DriverDocumentType.invoice:
        return driverDocumentTypeInvoiceText;

      case DriverDocumentType.credit:
        return driverDocumentTypeCreditText;

      case DriverDocumentType.payment:
        return driverDocumentTypePaymentText;

    }
  }
}
