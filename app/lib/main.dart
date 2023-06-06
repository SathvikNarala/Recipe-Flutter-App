import 'package:flutter/material.dart';
import 'ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App()
    );
  }
}

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

