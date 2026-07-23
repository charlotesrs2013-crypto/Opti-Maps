import 'package:flutter/material.dart';

import '../models/route_model.dart';
import '../models/stop_model.dart';
import '../repositories/route_repository.dart';
import '../repositories/stop_repository.dart';

class RouteProvider extends ChangeNotifier {
  final RouteRepository _routeRepository = RouteRepository();
  final StopRepository _stopRepository = StopRepository();

  List<RouteModel> routes = [];

  List<RouteModel> get allRoutes => routes;

  Future<void> loadRoutes() async {
    routes = await _routeRepository.getRoutes();
    notifyListeners();
  }

  Future<void> saveRoute(
      RouteModel route,
      List<StopModel> stops,
      ) async {
    final int routeId = await _routeRepository.insertRoute(route);

    debugPrint("======================================");
    debugPrint("ROTA SALVA COM SUCESSO");
    debugPrint("ID DA ROTA: $routeId");
    debugPrint("TOTAL DE PARADAS: ${stops.length}");

    for (int i = 0; i < stops.length; i++) {
      stops[i].routeId = routeId;
      stops[i].order = i + 1;

      debugPrint("------------------------------");
      debugPrint("PARADA ${i + 1}");
      debugPrint("Endereço: ${stops[i].address}");
      debugPrint("RouteId: ${stops[i].routeId}");

      await _stopRepository.insertStop(stops[i]);
    }

    debugPrint("======================================");

    await loadRoutes();
  }

  Future<List<StopModel>> getStops(int routeId) async {
    return await _stopRepository.getStopsByRoute(routeId);
  }

  Future<void> completeStop(int stopId) async {
    await _stopRepository.completeStop(stopId);
    notifyListeners();
  }

  Future<void> updateStop(StopModel stop) async {
    await _stopRepository.updateStop(stop);
    notifyListeners();
  }

  Future<void> deleteStop(int stopId) async {
    await _stopRepository.deleteStop(stopId);
    notifyListeners();
  }

  Future<void> deleteRoute(int routeId) async {
    await _stopRepository.deleteStopsByRoute(routeId);
    await _routeRepository.deleteRoute(routeId);

    await loadRoutes();
  }
}