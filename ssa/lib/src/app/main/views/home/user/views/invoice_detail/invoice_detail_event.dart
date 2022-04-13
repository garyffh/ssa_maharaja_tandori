abstract class InvoiceDetailEvent {}

class InvoiceDetailEventGetViewModel extends InvoiceDetailEvent {
  InvoiceDetailEventGetViewModel({
    required this.documentId,
});

  final String documentId;

}

