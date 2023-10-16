import 'package:formz/formz.dart';

// Define input validation errors
enum FullNameError { empty, format }

class FullName extends FormzInput<String, FullNameError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([String value = '']) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FullNameError.empty) {
      return 'El campo de nombre completo no puede estar vacío';
    }

    return null;
  }

  @override
  FullNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return FullNameError.empty;
    return null;
  }
}
