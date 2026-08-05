import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalJsonDataSource {
  static const _fileName = 'ict107_app_data.json';
  static const _webKey = 'ict107_app_data_json';

  Future<String?> read() async {
    if (kIsWeb) {
      return (await SharedPreferences.getInstance()).getString(_webKey);
    }
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}${Platform.pathSeparator}$_fileName');
    return file.existsSync() ? file.readAsString() : null;
  }

  Future<void> write(Map<String, dynamic> json) async {
    final text = const JsonEncoder.withIndent('  ').convert(json);
    if (kIsWeb) {
      await (await SharedPreferences.getInstance()).setString(_webKey, text);
      return;
    }
    final directory = await getApplicationSupportDirectory();
    await directory.create(recursive: true);
    final file = File('${directory.path}${Platform.pathSeparator}$_fileName');
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(text, flush: true);
    if (await file.exists()) await file.delete();
    await temporary.rename(file.path);
  }
}
