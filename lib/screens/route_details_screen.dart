import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/stop_card.dart';

class RouteDetailsScreen extends StatelessWidget {
  final String routeName;

  const RouteDetailsScreen({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
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
                  children: const [
                    Icon(
                      Icons.route,
                      color: Colors.blue,
                      size: 40,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Não iniciada",
                            style: TextStyle(
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
              child: ListView(
                children: [
                  StopCard(
                    order: 1,
                    customerName: "João da Silva",
                    address: "Rua das Flores, 120",
                    status: "Pendente",
                    onComplete: () {},
                    onEdit: () {},
                    onDelete: () {},
                  ),
                  StopCard(
                    order: 2,
                    customerName: "Maria Souza",
                    address: "Av. Brasil, 450",
                    status: "Pendente",
                    onComplete: () {},
                    onEdit: () {},
                    onDelete: () {},
                  ),
                  StopCard(
                    order: 3,
                    customerName: "Carlos Pereira",
                    address: "Rua Goiás, 89",
                    status: "Pendente",
                    onComplete: () {},
                    onEdit: () {},
                    onDelete: () {},
                  ),
                ],
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