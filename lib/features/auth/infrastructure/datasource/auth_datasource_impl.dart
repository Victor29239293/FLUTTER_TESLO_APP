import 'package:dio/dio.dart';
import 'package:flutter_teslo_app/config/constants/environment.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/infrastructure.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/mappers/user_mappers.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/models/login_response.dart';
import '../../domain/domain.dart';

class AuthDatasourceImpl implements AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));
  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      return UserMapper.toEntity(loginResponse);
    } catch (e) {
      throw WrongCredentials();
    }
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }
}
