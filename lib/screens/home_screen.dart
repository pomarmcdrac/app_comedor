import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String ubicacion = '';
String nombreUser = '';

class HomeScreen extends StatefulWidget {

  static const String routerName = 'HomeScreen';
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
      _readUbicacion().then((value) {
        if (mounted) {
          setState(() {
            ubicacion = value;
          });
        }
      });
      _readNombre().then((value) {
        if (mounted) {
          setState(() {
            nombreUser = value;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/home.jpg')
        ),
      ),
      child:  SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        spreadRadius: 0.1,
                        blurRadius: 10
                      )
                    ]
                  ),
                  padding: const EdgeInsets.all(20),
                  height: size.height * 0.2,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hola,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: size.width * 0.01,),
                      Text(
                        nombreUser,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: size.width * 0.01,),
                      const Text(
                        'Ubicación',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: size.width * 0.01,),
                      Text(
                        ubicacion,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01,),
                Container(
                  alignment: Alignment.center,
                  height: size.width * 1.2,
                  width: size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.width * 0.24,
                        left: -size.width * 0.4,
                        child: Container(
                          height: size.width * 0.7,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.blanco,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(size.width)
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.05,
                        left: -size.width * 0.6,
                        child: Container(
                          height: size.width * 1.1,
                          width: size.width * 1.1,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.blanco,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(size.width)
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0,
                        left: size.width * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, RegistrarScreen.routerName);
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.qr_code_2_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'REGISTRAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.17,
                        left: size.width * 0.3,
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, AltasBajasScreen.routerName);
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.app_registration_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'ALTAS / BAJAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.39,
                        left: size.width * 0.42,
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, HistorialScreen.routerName);
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.history_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'HISTORIAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.63,
                        left: size.width * 0.42,
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, ExtrasScreen.routerName);
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'EXTRAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 0.85,
                        left: size.width * 0.3,
                        child: GestureDetector(
                          onTap: () {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, NotificacionesScreen.routerName);
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.notifications_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'NOTIFICACIONES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.width * 1.02,
                        left: size.width * 0.1,
                        child: GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.remove('usuario');
                            await prefs.remove('password');
                            await prefs.remove('ubicacion');
                            await prefs.remove('name');

                            if (context.mounted) {
                              Future.microtask(() {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => const LoginScreen(),
                                    transitionDuration: const Duration(seconds: 0),
                                  ));
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                height: size.width * 0.18,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: AppTheme.blanco,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(size.width)
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.logout_rounded, color: Colors.white, size: size.width * 0.1),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.1,
                                      blurRadius: 10,
                                    )
                                  ]
                                ),
                                child: const Text(
                                  'SALIR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

Future<String> _readUbicacion() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String ubi = prefs.getString('ubicacion') ?? '-';

  return ubi;
}

Future<String> _readNombre() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String nombreUsuario = prefs.getString('name') ?? '-';

  return nombreUsuario;
}