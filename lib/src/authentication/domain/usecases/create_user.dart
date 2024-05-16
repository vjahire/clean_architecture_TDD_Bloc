import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';

import '../repositories/authentication_repository.dart';

class CreateUser {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  ResultVoid call({
    required String createdAt,
    required String name,
    required String avatar,
  }) async => _repository.createUser(createdAt: createdAt, name: name, avatar: avatar);
}