import 'package:flutter/foundation.dart';

@immutable
class User {
  factory User(
      {String? id,
      required String username,
      String? email,
      String? avatarKey,
      String? description}) {
    return User(
        id: id,
        // == null ? UUID.getUUID() : id,
        username: username,
        email: email,
        avatarKey: avatarKey,
        description: description);
  }

  User.fromJson(Map<String, String> json)
      : id = json['id']!,
        _username = json['username'],
        _email = json['email'],
        _avatarKey = json['avatarKey'],
        _description = json['description'];

  Map<String, String?> toJson() => {
        'id': id,
        'username': _username,
        'email': _email,
        'avatarKey': _avatarKey,
        'description': _description
      };

  final String id;
  final String? _username;
  final String? _email;
  final String? _avatarKey;
  final String? _description;

  String getId() {
    return id;
  }

  String get username {
    try {
      return _username!;
    } catch (e) {
      rethrow;
    }
  }

  String? get email {
    return _email;
  }

  String? get avatarKey {
    return _avatarKey;
  }

  String? get description {
    return _description;
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }

    return other is User &&
        id == other.id &&
        _username == other._username &&
        _email == other._email &&
        _avatarKey == other._avatarKey &&
        _description == other._description;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.write('User {');
    buffer.write('id=$id, ');
    buffer.write('username=$_username, ');
    buffer.write('email=$_email, ');
    buffer.write('avatarKey=$_avatarKey, ');
    buffer.write('description=$_description');
    buffer.write('}');

    return buffer.toString();
  }

  User copyWith(
      {String? id,
      String? username,
      String? email,
      String? avatarKey,
      String? description}) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        avatarKey: avatarKey ?? this.avatarKey,
        description: description ?? this.description);
  }
}
