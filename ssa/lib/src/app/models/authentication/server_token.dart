import 'package:json_annotation/json_annotation.dart';

part 'server_token.g.dart';

@JsonSerializable()
class ServerToken {
  ServerToken({
    required this.tokenType,
    required this.refreshToken,
    required this.userName,
    required this.accessToken,
    required this.expiresIn,
    required this.expires,
    required this.issued,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.cardNumber,
    required this.ceo,
    required this.admin,
    required this.driver,
    required this.waiter,
  });

  factory ServerToken.fromJson(Map<String, dynamic> json) =>
      _$ServerTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ServerTokenToJson(this);

  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  final String userName;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  @JsonKey(name: '.expires')
  final String expires;
  @JsonKey(name: '.issued')
  final String issued;
  @JsonKey(name: 'as:client_id')
  final String clientId;
  final String firstName;
  final String lastName;
  final String cardNumber;
  final String ceo;
  final String admin;
  final String driver;
  final String waiter;

}

