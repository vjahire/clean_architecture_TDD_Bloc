import 'package:clean_architecture_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_architecture_tdd_bloc/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

///This is where we going to initialise every dependency
Future<void> init() async {
  //Register the top

  ///Application logic
  sl.registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()));

  ///Use cases
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));

  ///Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()));

  ///Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(sl()));

  ///External Dependency (outside world)
  //Since http.Client() is last one in hierarchic, so we directly call constructor
  sl.registerLazySingleton(() => http.Client());
}
