import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/infrastructure.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/repository/auth_repository_impl.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  void loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = await authRepository.login(email, password);
      _setLogoutUser(user);
    } on WrongCredentials {
      logoutUser('Credenciales no son correcta');
    } catch (e) {
      logoutUser('Error inesperado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}

  void _setLogoutUser(User user) async {
    // TODO: 
    state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  Future<void> logoutUser(String? errorMessage) async {
    // TODO: LIMPIAR TOKEN
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus { authenticated, notAuthenticated, checking }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
