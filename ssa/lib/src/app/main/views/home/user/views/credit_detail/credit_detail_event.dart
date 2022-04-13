abstract class CreditDetailEvent {}

class CreditDetailEventGetViewModel extends CreditDetailEvent {
  CreditDetailEventGetViewModel({
    required this.documentId,
});
  final String documentId;

}

