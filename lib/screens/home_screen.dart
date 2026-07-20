import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import 'history_screen.dart';
import 'new_route_screen.dart';
import 'saved_routes_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opti Maps"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CustomButton(
              text: "Nova Rota",
              icon: Icons.add_location_alt,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NewRouteScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Rotas Salvas",
              icon: Icons.route,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SavedRoutesScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Histórico",
              icon: Icons.history,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: "Configurações",
              icon: Icons.settings,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}