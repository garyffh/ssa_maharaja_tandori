abstract class StoreStatusDisplayEvent {}

class StoreStatusDisplayEventUpdateBanner extends StoreStatusDisplayEvent {
  StoreStatusDisplayEventUpdateBanner({
    required this.showBanner,
});

  final bool showBanner;

}

