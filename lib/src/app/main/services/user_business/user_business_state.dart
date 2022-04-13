import 'package:flutter/cupertino.dart';

@immutable
class UserBusinessState {
  const UserBusinessState({
    required this.businessPriceLevel,
    this.userPriceLevel,
  });

  final int businessPriceLevel;
  final int? userPriceLevel;

  int get priceLevel =>
      userPriceLevel == null ? businessPriceLevel : userPriceLevel!;
}
