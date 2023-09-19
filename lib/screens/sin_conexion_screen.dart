import 'package:flutter/material.dart';

class SinConexionScreen extends StatelessWidget {
  static const String routerName = 'SinConexionScreen';

  const SinConexionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('En este momento, no tienes conexión a internet.'),
      ),
    );
  }
}