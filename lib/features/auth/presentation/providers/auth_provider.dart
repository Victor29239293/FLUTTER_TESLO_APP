import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/repository/auth_repository_impl.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl(
    
  );
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  void loginUser(String email , String password) async{
    

  }

  void registerUser(String email , String password)async{

  }

  void checkAuthStatus()async{

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
