// validation.dart

import 'package:email_validator/email_validator.dart';

class Validation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    }
    return null;
  }

  /// Validates the email format.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    } else if (!EmailValidator.validate(value)) {
      return 'please enter a valid email address';
    }
    return null;
  }

  /// Validates the password to ensure it meets specific criteria.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    } else if (value.length <= 8) {
      return 'password must be at least 8 characters long';
    } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'password must contain at least one uppercase letter';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    } else if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(value)) {
      return 'please enter a valid phone number';
    }
    return null;
  }
}
