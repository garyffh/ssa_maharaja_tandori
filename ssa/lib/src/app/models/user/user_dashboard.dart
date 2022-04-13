import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/order/trn_order_read.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';

part 'user_dashboard.g.dart';

@JsonSerializable()
class UserDashboard {
  UserDashboard({
    required this.address,
    required this.phone,
    required this.numberOfOrders,
    required this.balance,
    required this.points,
    required this.bonusTrigger,
    required this.bonus,
    required this.nextBonusTrigger,
    required this.nextBonus,
    required this.specialDeals,
    required this.order,
  });

  UserDashboard.updateSpecialDeals({
    required this.specialDeals,
    required UserDashboard userDashboard,
  })  : address = userDashboard.address,
        phone = userDashboard.phone,
        numberOfOrders = userDashboard.numberOfOrders,
        balance = userDashboard.balance,
        points = userDashboard.points,
        bonusTrigger = userDashboard.bonusTrigger,
        bonus = userDashboard.bonus,
        nextBonusTrigger = userDashboard.nextBonusTrigger,
        nextBonus = userDashboard.nextBonus,
        order = userDashboard.order;

  factory UserDashboard.fromJson(Map<String, dynamic> json) =>
      _$UserDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$UserDashboardToJson(this);

  final UserAddress? address;
  final String? phone;
  final int numberOfOrders;
  final double balance;
  final int points;
  final int? bonusTrigger;
  final int? bonus;
  final int? nextBonusTrigger;
  final int? nextBonus;
  final bool specialDeals;
  final TrnOrderRead? order;
}
