// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      title: json['title'] as String?,
      text: json['text'] as String?,
      localNotification: json['localNotification'] as String?,
      messageId: json['messageId'] as String?,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'localNotification': instance.localNotification,
      'messageId': instance.messageId,
      'method': instance.method,
    };
