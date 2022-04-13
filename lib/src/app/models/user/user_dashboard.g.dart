// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDashboard _$UserDashboardFromJson(Map<String, dynamic> json) =>
    UserDashboard(
      address: json['address'] == null
          ? null
          : UserAddress.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      numberOfOrders: json['numberOfOrders'] as int,
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
      bonusTrigger: json['bonusTrigger'] as int?,
      bonus: json['bonus'] as int?,
      nextBonusTrigger: json['nextBonusTrigger'] as int?,
      nextBonus: json['nextBonus'] as int?,
      specialDeals: json['specialDeals'] as bool,
      order: json['order'] == null
          ? null
          : TrnOrderRead.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDashboardToJson(UserDashboard instance) =>
    <String, dynamic>{
      'address': instance.address,
      'phone': instance.phone,
      'numberOfOrders': instance.numberOfOrders,
      'balance': instance.balance,
      'points': instance.points,
      'bonusTrigger': instance.bonusTrigger,
      'bonus': instance.bonus,
      'nextBonusTrigger': instance.nextBonusTrigger,
      'nextBonus': instance.nextBonus,
      'specialDeals': instance.specialDeals,
      'order': instance.order,
    };
