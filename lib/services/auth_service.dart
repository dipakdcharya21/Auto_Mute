import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _signedInKey = 'auth_signed_in';
  static const _displayNameKey = 'auth_display_name';
  static const _emailKey = 'auth_email';
  static const _passwordHashKey = 'auth_password_hash';
  static const _passwordSaltKey = 'auth_password_salt';
  static const _rememberMeKey = 'auth_remember_me';

  late final SharedPreferences _preferences;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool get hasAccount {
    return (_preferences.getString(_emailKey) ?? '').isNotEmpty &&
        (_preferences.getString(_passwordHashKey) ?? '').isNotEmpty &&
        (_preferences.getString(_passwordSaltKey) ?? '').isNotEmpty;
  }

  bool get isSignedIn {
    final rememberMe = _preferences.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) return false;
    return _preferences.getBool(_signedInKey) ?? false;
  }

  String get displayName =>
      _preferences.getString(_displayNameKey) ?? 'Student';

  String get email => _preferences.getString(_emailKey) ?? '';

  Future<bool> createAccount({
    required String fullName,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final normalizedName = fullName.trim();
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedName.length < 2 ||
        !_isValidEmail(normalizedEmail) ||
        !_isStrongPassword(password)) {
      return false;
    }

    final salt = _generateSalt();
    final hash = _hashPassword(password, salt);

    await _preferences.setString(_displayNameKey, normalizedName);
    await _preferences.setString(_emailKey, normalizedEmail);
    await _preferences.setString(_passwordSaltKey, salt);
    await _preferences.setString(_passwordHashKey, hash);
    await _preferences.setBool(_rememberMeKey, rememberMe);
    await _preferences.setBool(_signedInKey, rememberMe);

    return true;
  }

  Future<bool> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (!hasAccount) return false;

    final normalizedEmail = email.trim().toLowerCase();
    final storedEmail = _preferences.getString(_emailKey) ?? '';
    final salt = _preferences.getString(_passwordSaltKey) ?? '';
    final storedHash = _preferences.getString(_passwordHashKey) ?? '';

    if (normalizedEmail != storedEmail || salt.isEmpty || storedHash.isEmpty) {
      return false;
    }

    final incomingHash = _hashPassword(password, salt);
    if (incomingHash != storedHash) return false;

    await _preferences.setBool(_rememberMeKey, rememberMe);
    await _preferences.setBool(_signedInKey, rememberMe);
    return true;
  }

  Future<void> signOut() async {
    await _preferences.setBool(_signedInKey, false);
    await _preferences.setBool(_rememberMeKey, false);
  }

  Future<void> deleteAccount() async {
    await _preferences.remove(_signedInKey);
    await _preferences.remove(_displayNameKey);
    await _preferences.remove(_emailKey);
    await _preferences.remove(_passwordHashKey);
    await _preferences.remove(_passwordSaltKey);
    await _preferences.remove(_rememberMeKey);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    if (password.length < 8) return false;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    return hasUppercase && hasNumber;
  }

  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(24, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  String _hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }
}
