//! 1: State del provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/shared/infrastructure/input/email.dart';
import 'package:flutter_teslo_app/features/shared/infrastructure/input/password.dart';
import 'package:formz/formz.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) {
    return LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return '''FormState {   
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      email: $email,
      password: $password
    }''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(password: newPassword);
  }

  onFormSubmit() {
    _touchEveryField();
    if (state.isValid) return;
    print(state);
  }

  _touchEveryField() {
    final newEmail = Email.dirty(state.email.value);
    final newPassword = Password.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: newEmail,
      password: newPassword,
      isValid: Formz.validate([newEmail, newPassword]),
    );
  }
}

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>(
      (ref) => LoginFormNotifier(),
    );
