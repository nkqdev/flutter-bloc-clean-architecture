import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_clean_architecture/presentation/blocs/auth/auth_state.dart';

void main() {
  test('AuthState.isValidInput requires username and 6+ char password', () {
    expect(const AuthState().isValidInput, isFalse);
    expect(
      const AuthState(username: 'a', password: '123').isValidInput,
      isFalse,
    );
    expect(
      const AuthState(username: 'a', password: '123456').isValidInput,
      isTrue,
    );
  });

  test('AuthState.toString never exposes the password', () {
    const state = AuthState(username: 'admin', password: 'S3cret!');
    expect(state.toString(), isNot(contains('S3cret!')));
    expect(state.toString(), contains('admin'));
  });
}
