import 'package:meta/meta.dart';

@immutable
abstract class AppMessagingState {
  const AppMessagingState({
    required this.method,
    this.messageId,
    this.messageType,
    this.sentTime,
    this.ttl,
    this.from,
    this.title,
    this.body,
    this.data = const <String, dynamic>{},
  });

  final String method;

  /// A unique ID assigned to every message.
  final String? messageId;

  /// The message type of the message.
  final String? messageType;

  /// The time the message was sent, represented as a [DateTime].
  final DateTime? sentTime;

  /// The time to live for the message in seconds.
  final int? ttl;

  /// The topic name or message identifier.
  final String? from;

  /// The notification title.
  final String? title;

  /// The notification body content.
  final String? body;

  /// Any additional data sent with the message.
  final Map<String, dynamic> data;



}

class AppMessagingStateInitial extends AppMessagingState {
   const AppMessagingStateInitial() : super(method: '');
}

class AppMessagingPublished extends AppMessagingState {
   const AppMessagingPublished({
     required String method,
    String? messageId,
    String? messageType,
    DateTime? sentTime,
    int? ttl,
    String? from,
    String? title,
    String? body,
    Map<String, dynamic> data = const <String, dynamic>{},
  }) : super(
     method: method,
          messageId: messageId,
          messageType: messageType,
          sentTime: sentTime,
          ttl: ttl,
          from: from,
          title: title,
          body: body,
          data: data,
        );

  AppMessagingPublished.copyWith(AppMessagingState value)
      : this(
    method: value.method,
    messageId: value.messageId,
    messageType: value.messageType,
    sentTime: value.sentTime,
    ttl: value.ttl,
    from: value.from,
    title: value.title,
    body: value.body,
    data: <String, dynamic>{}..addAll(value.data),
  );
}

class AppMessagingTrnOrderUpdate extends AppMessagingState {
  const AppMessagingTrnOrderUpdate({
    required String method,
    String? messageId,
    String? messageType,
    DateTime? sentTime,
    int? ttl,
    String? from,
    String? title,
    String? body,
    Map<String, dynamic> data = const <String, dynamic>{},
  }) : super(
    method: method,
    messageId: messageId,
    messageType: messageType,
    sentTime: sentTime,
    ttl: ttl,
    from: from,
    title: title,
    body: body,
    data: data,
  );

  AppMessagingTrnOrderUpdate.copyWith(AppMessagingState value)
      : this(
    method: value.method,
    messageId: value.messageId,
    messageType: value.messageType,
    sentTime: value.sentTime,
    ttl: value.ttl,
    from: value.from,
    title: value.title,
    body: value.body,
    data: <String, dynamic>{}..addAll(value.data),
  );

}


class AppMessagingTrnOrderUserAllocateDriver extends AppMessagingState {
  const AppMessagingTrnOrderUserAllocateDriver({
    required String method,
    String? messageId,
    String? messageType,
    DateTime? sentTime,
    int? ttl,
    String? from,
    String? title,
    String? body,
    Map<String, dynamic> data = const <String, dynamic>{},
  }) : super(
    method: method,
    messageId: messageId,
    messageType: messageType,
    sentTime: sentTime,
    ttl: ttl,
    from: from,
    title: title,
    body: body,
    data: data,
  );

  AppMessagingTrnOrderUserAllocateDriver.copyWith(AppMessagingState value)
      : this(
    method: value.method,
    messageId: value.messageId,
    messageType: value.messageType,
    sentTime: value.sentTime,
    ttl: value.ttl,
    from: value.from,
    title: value.title,
    body: value.body,
    data: <String, dynamic>{}..addAll(value.data),
  );

}
