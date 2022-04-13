abstract class TransactionsEvent {}

class TransactionsEventGetViewModel extends TransactionsEvent {
  TransactionsEventGetViewModel();

}

class TransactionsEventUpdatePaymentFilter extends TransactionsEvent {
  TransactionsEventUpdatePaymentFilter({
    required this.showPayments,
});
  final bool showPayments;
}
