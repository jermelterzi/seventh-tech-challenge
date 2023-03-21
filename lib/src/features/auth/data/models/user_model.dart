// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.password,
  });

  factory UserModel.fromEntity(User entity) => UserModel(
        id: entity.id,
        username: entity.username.value,
        password: entity.password.value,
      );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '1cc32bc3-e419-4c36-bca5-1015c5bd68e5',
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username.value,
      'password': password.value,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      '''UserModel(id: $id, username: ${username.value}, password: ${password.value})''';
}
