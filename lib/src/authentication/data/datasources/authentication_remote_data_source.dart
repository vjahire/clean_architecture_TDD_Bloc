import 'dart:convert';
import 'dart:core';

import 'package:clean_architecture_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:clean_architecture_tdd_bloc/src/core/error/exceptions.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/constants.dart';
import 'package:clean_architecture_tdd_bloc/src/core/utils/typedef.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ///IMP - in other places we were using User entity but here we are using UserModel
  Future<List<UserModel>> getUsers();
}

///How to Test remote data source
/// 1. check to make sure it returns the right data when the response is 200
/// 2. check to make sure it Throws a custom exception with the right message when status code is other than 200

//This will take an http client as arg
class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
        body: jsonEncode(
            {'createdAt': createdAt, 'name': name, 'avatar': avatar}),
      );

      if (response.statusCode != 200) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      //If its reached here means, there is an error from our side
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kGetUsersEndpoint'),
      );

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();

    //   if (response.statusCode != 200) {
    //     throw ApiException(
    //         message: response.body, statusCode: response.statusCode);
    //   }
    } on ApiException {
      rethrow;
    } catch (e) {
      //If its reached here means, there is an error from our side
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
