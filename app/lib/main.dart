import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'interfaces/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Dataflow()),
        ChangeNotifierProvider(create: (_) => Searchflow())
      ],
      child: const MaterialApp(
        home: App()
      ),
    );
  }
}

