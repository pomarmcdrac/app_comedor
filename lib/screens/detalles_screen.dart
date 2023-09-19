import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';

List<String> resgistrosEmpleados = [
  'Lorena Veloz Ramírez',
  'Giuseppe Abril Rochin Carmelu',
  'Erika Hernández Hernández',
  'César Elioberto Anguiano Pereda',
  'Luis Octavio López Ramírez',
  'Susana de la Rosa Luevanos',
  'Omar Alejandro Morales Mendoza',
  'Monstserrat Estrih Sánchez Martinez' 
];

List<String> resgistrosUbicacion = [
  'Technology Park',
  'Technology Park',
  'Technology Park',
  'Cube 2',
  'Cube 2',
  'Technology Park',
  'Cube 2',
  'Cube 2' 
];

bool agrupados = true;

class DetallesScreen extends StatefulWidget {

  static const String routerName = 'DetallesScreen';
   
  const DetallesScreen({Key? key}) : super(key: key);

  @override
  State<DetallesScreen> createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          shape: const Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            )
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text(
            agrupados
            ? 'REGISTROS AGRUPADOS'
            : 'REGISTROS DETALLADOS',
            style: const TextStyle(
              fontSize: 16
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    agrupados = !agrupados;
                  });
                }
              },
              icon: const Icon(Icons.published_with_changes_rounded, color: AppTheme.primary, size: 30,)
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30,),
            onPressed: () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, HistorialScreen.routerName);
              }
            },
          ),
        ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
              width: size.width,
              child: const Text(
                'Semana del 15 al 19 de MAYO 2023',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.81,
              width: size.width,
              child: agrupados 
              ? ListView.builder(
                itemCount: resgistrosEmpleados.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Colors.grey[800],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.68,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      resgistrosEmpleados[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: size.width * 0.18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      resgistrosUbicacion[index],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '0 desayunos',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '5 comidas',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              : ListView.builder(
                itemCount: resgistrosEmpleados.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Colors.grey[800],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.68,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nombre',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: size.width * 0.18,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ubicación',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.68,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      resgistrosEmpleados[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: size.width * 0.18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      resgistrosUbicacion[index],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.12,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Comida',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Comida',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Comida',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Comida',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Comida',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.28,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fecha: 15 MAYO 2023',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Fecha: 16 MAYO 2023',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Fecha: 17 MAYO 2023',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Fecha: 18 MAYO 2023',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Fecha: 19 MAYO 2023',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.2,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hora: 14:05:31',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Hora: 14:05:31',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Hora: 14:05:31',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Hora: 14:05:31',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Hora: 14:05:31',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.25,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Registrado por: Arturo',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Registrado por: Arturo',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Registrado por: Arturo',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Registrado por: Arturo',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        'Registrado por: Arturo',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}