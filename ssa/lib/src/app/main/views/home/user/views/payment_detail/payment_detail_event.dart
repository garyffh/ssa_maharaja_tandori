abstract class PaymentDetailEvent {}

class PaymentDetailEventGetViewModel extends PaymentDetailEvent {
  PaymentDetailEventGetViewModel({
    required this.documentId,
});
  final String documentId;

}

