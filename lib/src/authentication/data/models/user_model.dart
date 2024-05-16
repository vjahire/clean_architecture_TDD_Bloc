import 'dart:convert';

import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';

///IMP. The Entity is blueprint and the Model is extension
class UserModel extends User {
  UserModel(
      {required super.id,
      required super.createdAt,
      required super.name,
      required super.avatar});

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          id: map['id'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
        );

  DataMap toMap() => {
    'id': id,
    'avatar': avatar,
    'createdAt': createdAt,
    'name': name,
  };

  String toJson() => jsonEncode(toMap());
}
