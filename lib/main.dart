import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/route_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MapsGoApp());
}

class MapsGoApp extends StatelessWidget {
  const MapsGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RouteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Opti Maps',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}