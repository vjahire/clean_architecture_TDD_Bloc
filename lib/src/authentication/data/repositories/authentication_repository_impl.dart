import 'package:clean_architecture_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/failure.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    //Test-Driven development
    //Call the remote data source
    //Make sure that it returns the proper data if there is no exception
    //Check if when the remoteDataSource throws an exception, we return a failure
    // and if it doesn't throw an exception, we return the actual
    // excepted data

    //Run api call in try catch
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    //Run api call in try catch
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
