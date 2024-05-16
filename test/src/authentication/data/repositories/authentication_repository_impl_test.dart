import 'package:clean_architecture_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  //Data needed while testing
  const String createdAt = 'cre';
  const String name = 'nam';
  const String avatar = 'ava';

  group('createUser', () {
    test(
        'Should call the [RemoteDataSource.createUser] and when complete '
        'successfully when the call to the remote source is successful',
        () async {
      //Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => Future.value());

      //Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert
      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    ///Server failure
    const tException = ApiException(
      message: "Internal server error",
      statusCode: 500,
    );
    test(
        'Should return a [ServerFailure] when the call to the remote source '
        'is unsuccessful', () async {
      //Arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);

      //Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  // test('', () {
  //
  // });
}
