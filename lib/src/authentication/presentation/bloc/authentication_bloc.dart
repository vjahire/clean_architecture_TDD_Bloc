import 'package:clean_architecture_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {

    ///Following code is for default event which is AuthenticationEvent
    // on<AuthenticationEvent>((event, emit) {
    //   //Implementation here
    // });

    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      //This object is passed from UI with data
      CreateUserEvent event,
      Emitter<AuthenticationState> emit) async {
    //First emit loading state
    emit(const CreatingUser());

    final result = await _createUser(
        createdAt: event.createdAt, name: event.name, avatar: event.avatar);

    result.fold(
      (failure) => emit(AuthenticationError(
          '${failure.statusCode} Error: ${failure.message}')),
      (r) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
      //This object is passed from UI with data
      GetUsersEvent event,
      Emitter<AuthenticationState> emit) async {
    //First emit loading state
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
