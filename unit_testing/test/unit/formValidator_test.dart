import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing/helpers.dart';

void main() {
  group(
    'Email test',
    () {
      test(
        'Valid Email test',
        () {
          final result = FormValidator.validateEmail("example@flutter.com");
          expect(result, isNull);
        },
      );
      test(
        'Invalid Email test',
        () {
          final result = FormValidator.validateEmail("abcf");
          expect(result, 'please enter valid email');
        },
      );
      test(
        'Empty email test',
        () {
          final result = FormValidator.validateEmail("");
          expect(result, 'please enter email');
        },
      );
    },
  );

  group(
    'Password Test',
    () {
      test(
        'Empty password test',
        () {
          final resutl = FormValidator.validatePassword("");
          expect(resutl, 'please enter your password');
        },
      );
      test(
        'Valid password test',
        () {
          final resutl = FormValidator.validatePassword("hello@123456");
          expect(resutl, isNull);
        },
      );
      test(
        'Invalid password test',
        () {
          final resutl = FormValidator.validatePassword("hello");
          expect(resutl, 'minimum lenght of password must be 8 characters');
        },
      );
    },
  );
}
