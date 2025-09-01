import 'package:flutter_teslo_app/features/auth/infrastructure/datasource/auth_datasource_impl.dart';
import '../../domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(AuthDataSource? datasource)
      : dataSource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password) {
    return dataSource.register(email, password);
  }

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }
} 