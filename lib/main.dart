import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db/database.dart';
import 'screens/home.dart';

void main() {
  runApp(
    Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      dispose: (_, db) => db.close(),
      child: const PistonApp(),
    ),
  );
}

class PistonApp extends StatelessWidget {
  const PistonApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'El Pistón',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFFD84315)),
        home: const Home(),
      );
}
