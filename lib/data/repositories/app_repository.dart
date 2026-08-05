import 'dart:convert';

import '../../domain/models/app_data.dart';
import '../sources/local_json_data_source.dart';

class AppRepository {
  AppRepository(this._source);
  final LocalJsonDataSource _source;

  Future<AppData> load() async {
    final source = await _source.read();
    if (source == null || source.trim().isEmpty) {
      return const AppData(schedules: []);
    }
    final decoded = jsonDecode(source);
    if (decoded is! Map) throw const FormatException('invalidRoot');
    return AppData.fromJson(Map<String, dynamic>.from(decoded));
  }

  Future<void> save(AppData data) => _source.write(data.toJson());
}
