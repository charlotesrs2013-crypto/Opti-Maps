import 'package:sqflite/sqflite.dart';

import '../models/route_model.dart';
import '../services/database_service.dart';

class RouteRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  Future<int> insertRoute(RouteModel route) async {
    final Database db = await _databaseService.database;

    return db.insert(
      'routes',
      route.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RouteModel>> getRoutes() async {
    final Database db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'routes',
      orderBy: 'createdAt DESC',
    );

    return maps.map((e) => RouteModel.fromMap(e)).toList();
  }

  Future<RouteModel?> getRouteById(int id) async {
    final Database db = await _databaseService.database;

    final result = await db.query(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return RouteModel.fromMap(result.first);
  }

  Future<void> updateRoute(RouteModel route) async {
    final Database db = await _databaseService.database;

    await db.update(
      'routes',
      route.toMap(),
      where: 'id = ?',
      whereArgs: [route.id],
    );
  }

  Future<void> deleteRoute(int id) async {
    final Database db = await _databaseService.database;

    await db.delete(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}