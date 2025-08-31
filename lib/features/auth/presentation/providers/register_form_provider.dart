// ! 1. DEFINIR EL ESTADO DEL FORMULARIO
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/shared/shared.dart';
import 'package:formz/formz.dart';
import 'package:flutter_teslo_app/features/shared/infrastructure/input/full_name.dart';

// ! 3. IMPLEMENTAR EL ESTADO PARA CONSUMIR EN EL FRONTEND
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
      (ref) => RegisterFormNotifier(),
    );

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;
  final Password repeatPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FullName? fullName,
    Email? email,
    Password? password,
    Password? repeatPassword,
  }) {
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
    );
  }

  @override
  String toString() {
    return 'RegisterFormState(isPosting: $isPosting, isFormPosted: $isFormPosted, isValid: $isValid, fullName: $fullName, email: $email, password: $password, repeatPassword: $repeatPassword)';
  }
}

// ! 2. CREAR EL ESTADO DEL FORMULARIO

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  void onFullNameChanged(String value) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
      fullName: newFullName,
      isValid: _validateAll(
        fullName: newFullName,
        email: state.email,
        password: state.password,
        repeatPassword: state.repeatPassword,
      ),
    );
  }

  void onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: _validateAll(
        fullName: state.fullName,
        email: newEmail,
        password: state.password,
        repeatPassword: state.repeatPassword,
      ),
    );
  }

  void onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: _validateAll(
        fullName: state.fullName,
        email: state.email,
        password: newPassword,
        repeatPassword: state.repeatPassword,
      ),
    );
  }

  void onRepeatPasswordChanged(String value) {
    final newRepeatPassword = Password.dirty(value);
    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: _validateAll(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        repeatPassword: newRepeatPassword,
      ),
    );
  }

  void onSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    if (state.password.value != state.repeatPassword.value) {
      
      return;
    }
    print(state);
  }

  void _touchEveryField() {
    final fullName = FullName.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);
    state = state.copyWith(
      isFormPosted: true,
      fullName: fullName,
      email: email,
      password: password,
      repeatPassword: repeatPassword,
      isValid: _validateAll(
        fullName: fullName,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
      ),
    );
  }

  bool _validateAll({
    required FullName fullName,
    required Email email,
    required Password password,
    required Password repeatPassword,
  }) {
    final isValid = Formz.validate([fullName, email, password, repeatPassword]);
    if (!isValid) return false;
    if (password.value != repeatPassword.value) return false;
    return true;
  }
}
