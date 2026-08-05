import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('English and Nepali ARB files contain matching UI keys', () {
    final english = jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync()) as Map<String, dynamic>;
    final nepali = jsonDecode(File('lib/l10n/app_ne.arb').readAsStringSync()) as Map<String, dynamic>;
    final englishKeys = english.keys.where((key) => !key.startsWith('@')).toSet();
    final nepaliKeys = nepali.keys.where((key) => !key.startsWith('@')).toSet();
    expect(nepaliKeys, englishKeys);
  });
}
