import 'dart:ffi';

import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/failure.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';


///Here we are just defining contacts
abstract class AuthenticationRepository {
  const AuthenticationRepository();

  //Instead of ApiFailure used Failure -> this is loose coupling
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<Either<Failure, List<User>>> getUsers();
}
