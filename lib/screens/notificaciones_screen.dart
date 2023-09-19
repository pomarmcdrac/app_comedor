import 'package:app_comedor/screens/screens.dart';
import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {

  static const String routerName = 'Notificaciones';
   
  const NotificacionesScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          title: const Text('NOTIFICACIONES'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30,),
            onPressed: () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, HomeScreen.routerName);
              }
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemCount: 4,
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
                      SizedBox(
                        width: size.width,
                        child: const Text(
                          'REPORTE SEMANAL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: size.width,
                        child: const Text(
                          'Semana del 15 al 19 de Mayo de 2023',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          'Se entregaron 50 desayunos, 78 comidas y 8 extras. En total se otorgaron 189 servicios.',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: size.width,
                        child: Text(
                          DateTime.now().toString().substring(0, 19),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}