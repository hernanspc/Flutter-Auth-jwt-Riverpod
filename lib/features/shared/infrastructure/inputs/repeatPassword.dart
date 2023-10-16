import 'package:formz/formz.dart';

// Define input validation errors
enum RepeatPasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class RepeatPassword extends FormzInput<String, RepeatPasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const RepeatPassword.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RepeatPassword.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RepeatPasswordError.empty)
      return 'El campo es requerido';
    if (displayError == RepeatPasswordError.length)
      return 'Mínimo 6 caracteres';
    if (displayError == RepeatPasswordError.format)
      return 'Debe de tener Mayúscula, letras y un número';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RepeatPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return RepeatPasswordError.empty;
    if (value.length < 6) return RepeatPasswordError.length;
    if (!passwordRegExp.hasMatch(value)) return RepeatPasswordError.format;

    return null;
  }
}
