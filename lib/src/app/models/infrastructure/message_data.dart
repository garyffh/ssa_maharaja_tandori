import 'package:json_annotation/json_annotation.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  MessageData({
    this.title,
    this.text,
    this.localNotification,
    this.messageId,
    this.method,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);

  final String? title;
  final String? text;
  final String? localNotification;
  final String? messageId;
  final String? method;


}
