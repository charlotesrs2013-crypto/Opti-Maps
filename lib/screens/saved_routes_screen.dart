import 'package:flutter/material.dart';

import '../models/route_model.dart';
import '../repositories/route_repository.dart';
import '../widgets/route_card.dart';
import 'route_details_screen.dart';

class SavedRoutesScreen extends StatefulWidget {
  const SavedRoutesScreen({super.key});

  @override
  State<SavedRoutesScreen> createState() => _SavedRoutesScreenState();
}

class _SavedRoutesScreenState extends State<SavedRoutesScreen> {
  final RouteRepository _repository = RouteRepository();

  List<RouteModel> routes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  Future<void> loadRoutes() async {
    final result = await _repository.getRoutes();

    setState(() {
      routes = result;
      loading = false;
    });
  }

  Future<void> deleteRoute(RouteModel route) async {
    if (route.id != null) {
      await _repository.deleteRoute(route.id!);
      await loadRoutes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rotas Salvas"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : routes.isEmpty
          ? const Center(
        child: Text(
          "Nenhuma rota salva.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];

          return Dismissible(
            key: Key(route.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) async {
              await deleteRoute(route);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Rota excluída com sucesso"),
                  ),
                );
              }
            },
            child: RouteCard(
              routeName: route.name,
              status: route.status,
              totalStops: 0,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RouteDetailsScreen(
                      routeName: route.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}