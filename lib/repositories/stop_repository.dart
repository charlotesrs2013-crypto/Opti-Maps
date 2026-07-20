import 'package:sqflite/sqflite.dart';

import '../models/stop_model.dart';
import '../services/database_service.dart';

class StopRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  Future<int> insertStop(StopModel stop) async {
    final Database db = await _databaseService.database;

    return db.insert(
      'stops',
      stop.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StopModel>> getStopsByRoute(int routeId) async {
    final Database db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'stops',
      where: 'routeId = ?',
      whereArgs: [routeId],
      orderBy: 'stopOrder ASC',
    );

    return maps.map((e) => StopModel.fromMap(e)).toList();
  }

  Future<int> countStopsByRoute(int routeId) async {
    final Database db = await _databaseService.database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as total
      FROM stops
      WHERE routeId = ?
      ''',
      [routeId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> updateStop(StopModel stop) async {
    final Database db = await _databaseService.database;

    await db.update(
      'stops',
      stop.toMap(),
      where: 'id = ?',
      whereArgs: [stop.id],
    );
  }

  Future<void> deleteStop(int id) async {
    final Database db = await _databaseService.database;

    await db.delete(
      'stops',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteStopsByRoute(int routeId) async {
    final Database db = await _databaseService.database;

    await db.delete(
      'stops',
      where: 'routeId = ?',
      whereArgs: [routeId],
    );
  }
}