import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

//! State notifier afuera
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  return RegisterFormNotifier();
});

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;
  final RepeatPassword repeatPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const RepeatPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FullName? fullName,
    Email? email,
    Password? password,
    RepeatPassword? repeatPassword,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
      );

  @override
  String toString() {
    return '''
    LoginFormState:

    isPosting = $isPosting,
    isFormPosted = $isFormPosted,
    isValid = $isValid,
    fullName = $fullName,
    email = $email,
    password = $password,
    repeatPassword = $repeatPassword,

    ''';
  }
}

//! Como implemetamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onFullNameChange(String value) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate([newFullName, state.fullName]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordsChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onRepeatPasswordsChange(String value) {
    final newPassword = RepeatPassword.dirty(value);
    state = state.copyWith(
        repeatPassword: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onFormSubmit() {
    _touchEveryField();

    if (state.isValid) return;

    print(state);
  }

  _touchEveryField() {
    final fullName = FullName.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = RepeatPassword.dirty(state.repeatPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      fullName: fullName,
      email: email,
      password: password,
      repeatPassword: repeatPassword,
      isValid:
          Formz.validate([email, password, fullName, password, repeatPassword]),
    );
  }
}
