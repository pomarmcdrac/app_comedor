import 'package:flutter/material.dart';

class Animacion extends StatefulWidget {

  static const String routerName = 'Animacion';
   
  const Animacion({Key? key}) : super(key: key);

  @override
  State<Animacion> createState() => _AnimacionState();
}

class _AnimacionState extends State<Animacion> {

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Image(
          height: 400,
          width: 400,
          image: AssetImage('assets/gifs/verduras.gif'),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}