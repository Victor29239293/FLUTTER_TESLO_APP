import 'package:dio/dio.dart';
import 'package:flutter_teslo_app/config/constants/environment.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/infrastructure.dart';
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

      final user = UserMapper.toEntity(loginResponse);
      return user;
    } on DioException catch (e) {
       if (e.response?.statusCode == 401) {
        throw WrongCredentials();
      } else if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Error de conexion', 503);
      } else {
        throw CustomError('Error inesperado', e.response?.statusCode ?? 500);
      }
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
