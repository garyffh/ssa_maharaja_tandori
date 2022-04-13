abstract class DriverInvoiceDetailEvent {}

class DriverInvoiceDetailEventGetViewModel extends DriverInvoiceDetailEvent {
  DriverInvoiceDetailEventGetViewModel({
    required this.documentId,
});

  final String documentId;

}

