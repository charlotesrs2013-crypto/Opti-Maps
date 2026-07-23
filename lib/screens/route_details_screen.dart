import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/route_model.dart';
import '../models/stop_model.dart';
import '../providers/route_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/stop_card.dart';

class RouteDetailsScreen extends StatefulWidget {
  final RouteModel route;

  const RouteDetailsScreen({
    super.key,
    required this.route,
  });

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  bool loading = true;
  List<StopModel> stops = [];

  @override
  void initState() {
    super.initState();
    loadStops();
  }

  Future<void> loadStops() async {
    final result = await context.read<RouteProvider>().getStops(widget.route.id!);

    if (!mounted) return;

    setState(() {
      stops = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.route.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.route,
                      color: Colors.blue,
                      size: 40,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.route.status,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: loading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : stops.isEmpty
                  ? const Center(
                child: Text(
                  "Nenhuma parada cadastrada.",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  final stop = stops[index];

                  return StopCard(
                    order: stop.order,
                    customerName: stop.customerName?.isNotEmpty == true
                        ? stop.customerName!
                        : "Parada ${stop.order}",
                    address: stop.address,
                    status: stop.status,
                    onComplete: () {},
                    onEdit: () {},
                    onDelete: () {},
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Adicionar Parada",
              icon: Icons.add_location_alt,
              onPressed: () {},
            ),

            const SizedBox(height: 10),

            CustomButton(
              text: "Iniciar Navegação",
              icon: Icons.navigation,
              backgroundColor: Colors.green,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}