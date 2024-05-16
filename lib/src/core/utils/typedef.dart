import 'package:clean_architecture_tdd_bloc/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

//Create a generic failure result

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;