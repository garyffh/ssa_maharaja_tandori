abstract class UserBusinessEvent {}

class UserBusinessEventUpdateBusinessPriceLevel extends UserBusinessEvent {
  UserBusinessEventUpdateBusinessPriceLevel({
    required this.businessPriceLevel,
});
  final int businessPriceLevel;
}

class UserBusinessEventUpdateUserPriceLevel extends UserBusinessEvent {
  UserBusinessEventUpdateUserPriceLevel({
    required this.userPriceLevel,
  });
  final int? userPriceLevel;
}

