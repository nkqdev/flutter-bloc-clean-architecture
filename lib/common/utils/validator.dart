import 'package:flutter_bloc_clean_architecture/common/utils/regex_pattern.dart';

class Validator {
  static bool isNotEmpty(String? value) => value?.trim().isNotEmpty == true;

  static bool isEmail(String? value) =>
      value != null && RegexPattern.email.hasMatch(value.trim());

  static bool isPassword(String? value, {int minLength = 6}) =>
      value != null && value.length >= minLength;
}
