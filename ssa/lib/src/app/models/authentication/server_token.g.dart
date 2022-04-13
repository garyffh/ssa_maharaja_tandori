// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerToken _$ServerTokenFromJson(Map<String, dynamic> json) => ServerToken(
      tokenType: json['token_type'] as String,
      refreshToken: json['refresh_token'] as String,
      userName: json['userName'] as String,
      accessToken: json['access_token'] as String,
      expiresIn: json['expires_in'] as int,
      expires: json['.expires'] as String,
      issued: json['.issued'] as String,
      clientId: json['as:client_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      cardNumber: json['cardNumber'] as String,
      ceo: json['ceo'] as String,
      admin: json['admin'] as String,
      driver: json['driver'] as String,
      waiter: json['waiter'] as String,
    );

Map<String, dynamic> _$ServerTokenToJson(ServerToken instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'refresh_token': instance.refreshToken,
      'userName': instance.userName,
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      '.expires': instance.expires,
      '.issued': instance.issued,
      'as:client_id': instance.clientId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'cardNumber': instance.cardNumber,
      'ceo': instance.ceo,
      'admin': instance.admin,
      'driver': instance.driver,
      'waiter': instance.waiter,
    };
