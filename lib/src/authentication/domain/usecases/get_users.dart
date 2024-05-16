import 'package:clean_architecture_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';

import '../repositories/authentication_repository.dart';

class GetUsers {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  ResultFuture<List<User>> call() async => _repository.getUsers();
}