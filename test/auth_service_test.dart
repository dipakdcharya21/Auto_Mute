import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ict107_auto_silent/services/auth_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('user can create an account and sign in', () async {
    final service = AuthService();
    await service.initialize();

    final accountCreated = await service.createAccount(
      fullName: 'Dipak Acharya',
      email: 'dipak@example.com',
      password: 'Dipak123',
      rememberMe: false,
    );

    expect(accountCreated, isTrue);
    expect(service.hasAccount, isTrue);
    expect(service.displayName, 'Dipak Acharya');
    expect(service.email, 'dipak@example.com');

    await service.signOut();

    final signedIn = await service.signIn(
      email: 'dipak@example.com',
      password: 'Dipak123',
      rememberMe: true,
    );

    expect(signedIn, isTrue);
    expect(service.isSignedIn, isTrue);
  });

  test('incorrect password cannot sign in', () async {
    final service = AuthService();
    await service.initialize();

    await service.createAccount(
      fullName: 'Dipak Acharya',
      email: 'dipak@example.com',
      password: 'Dipak123',
      rememberMe: false,
    );

    await service.signOut();

    final signedIn = await service.signIn(
      email: 'dipak@example.com',
      password: 'Wrong123',
      rememberMe: true,
    );

    expect(signedIn, isFalse);
    expect(service.isSignedIn, isFalse);
  });
}
