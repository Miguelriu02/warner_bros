import 'package:flutter/material.dart';
import 'package:warner_bros/main.dart';

void main() => runApp(const WarnerBros());

class WarnerBros extends StatelessWidget {
  const WarnerBros({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Warner Bros',
      debugShowCheckedModeBanner: false,
      home: CargandoScreen(), // Cambia a CargandoScreen
    );
  }
}

class CargandoScreen extends StatefulWidget {
  const CargandoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CargandoScreenState createState() => _CargandoScreenState();
}

class _CargandoScreenState extends State<CargandoScreen> {
  @override
  void initState() {
    super.initState();
    // Navegar a la pantalla principal después de 3 segundos
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/superhero.gif', fit: BoxFit.cover), // Muestra el gif
      ),
    );
  }
}