import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/route_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const OptiMapsApp());
}

class OptiMapsApp extends StatelessWidget {
  const OptiMapsApp({super.key});

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
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}