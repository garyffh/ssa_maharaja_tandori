import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/strings/user_document_type.constants.dart';

enum UserDocumentType {
@JsonValue(0)
invoice,
@JsonValue(1)
credit,
@JsonValue(2)
payment,
}

extension UserDocumentTypeExtension on UserDocumentType {

  String get text {
    switch(this) {

      case UserDocumentType.invoice:
        return userDocumentTypeInvoiceText;

      case UserDocumentType.credit:
        return userDocumentTypeCreditText;

      case UserDocumentType.payment:
        return userDocumentTypePaymentText;

    }
  }
}
