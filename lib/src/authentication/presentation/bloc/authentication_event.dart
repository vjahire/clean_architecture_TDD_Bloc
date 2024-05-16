part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override

  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserEvent(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object> get props => [createdAt, name, avatar];
}

///This event will be sent by UI and we dont need any param to fetch users
///This is why we don't need any variables here
class GetUsersEvent extends AuthenticationEvent {

  const GetUsersEvent();
}
