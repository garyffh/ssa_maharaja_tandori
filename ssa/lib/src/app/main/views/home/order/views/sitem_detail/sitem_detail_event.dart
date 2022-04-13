abstract class SitemDetailEvent {}

class SitemDetailEventInitialViewModel extends SitemDetailEvent {
  SitemDetailEventInitialViewModel({required this.sysSitemId});
  final String sysSitemId;
}

class SitemDetailEventResetError extends SitemDetailEvent {
  SitemDetailEventResetError();

}

class SitemDetailEventPrevious extends SitemDetailEvent {
  SitemDetailEventPrevious({required this.pagePosition});
  final int pagePosition;
}

class SitemDetailEventNext extends SitemDetailEvent {
  SitemDetailEventNext({required this.pagePosition});
  final int pagePosition;
}
