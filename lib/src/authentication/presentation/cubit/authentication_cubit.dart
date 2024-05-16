import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

///The only difference between Bloc and Cubit is Cubit don't have events,
///it has functions and we can directly call the function instead of events
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthenticationCubit(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //First emit loading state
    emit(const CreatingUser());

    final result =
        await _createUser(createdAt: createdAt, name: name, avatar: avatar);

    result.fold(
      (failure) => emit(AuthenticationError(
          '${failure.statusCode} Error: ${failure.message}')),
      (r) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    //First emit loading state
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
