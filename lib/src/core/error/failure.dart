//Create an interface to contain errors
import 'package:clean_architecture_tdd_bloc/src/core/error/exceptions.dart';
import 'package:equatable/equatable.dart';

//This could be used for any kind of failure, like Api failure, database failure
abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  //Helper to get error message
  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  //helper method
  ApiFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
