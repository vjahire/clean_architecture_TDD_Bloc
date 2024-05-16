import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}
class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
  });


  tearDown(() => cubit.close());
  test('initial state should be [AuthenticationInitial', () async {
    expect(cubit.state, const AuthenticationInitial());
  });
  // group('createUser', () {});
}