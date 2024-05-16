// What does the class depend on ?
// AuthenticationRepository

// How can we create a fake version of the dependency ?
// Use Mocktail

// How do we control what our dependencies do
// Using the Mocktail's API

import 'package:clean_architecture_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  //Data needed while testing
  const String createdAt = 'cre';
  const String name = 'nam';
  const String avatar = 'ava';

  test('Should call the [AuthenticationRepository.createUser]', () async {
    //Arrange
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    //Act
    final result =
        await usecase(createdAt: createdAt, avatar: avatar, name: name);

    //Assert
    expect(result, equals(const Right(null)));

    verify(() => repository.createUser(
        createdAt: createdAt, name: name, avatar: avatar)).called(1);

    verifyNoMoreInteractions(repository);
  });

  ///Create a failure test here
}
