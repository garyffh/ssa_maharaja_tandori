abstract class DriverPaymentDetailEvent {}

class DriverPaymentDetailEventGetViewModel extends DriverPaymentDetailEvent {
  DriverPaymentDetailEventGetViewModel({
    required this.documentId,
});

  final String documentId;

}

