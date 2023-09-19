import 'package:app_comedor/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? _usuario = '-';
bool _internet = true;

class CheckAuthscreen extends StatefulWidget {

  static const String routerName = 'CheckAuthscreen';
  const CheckAuthscreen({super.key});

  @override
  State<CheckAuthscreen> createState() => _CheckAuthscreenState();
}

class _CheckAuthscreenState extends State<CheckAuthscreen> {

  @override
  void initState() {
    super.initState();
    _readUsuario().then((value) {
      if (mounted) {
        setState(() {
          _usuario = value;
        });
      }
    });

    _getStatusInternet().then((value) {
      if (mounted) {
        setState(() {
          _internet = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_internet == false) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const SinConexionScreen(),
            transitionDuration: const Duration(seconds: 0),
          ));
      });
    }

    if(_internet == true && _usuario == '') {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionDuration: const Duration(seconds: 0),
          ));
      });
    } 

    if(_internet == true && _usuario == 'null') {
      Future.microtask(() {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: const Duration(seconds: 0),
            ));
      });
    } 
    
    if((_internet == true && _usuario != '-')) {
      Future.microtask(() {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomeScreen(),
                  transitionDuration: const Duration(seconds: 0)));
      });
    }

    return const LoginScreen();
  }
}

Future<String> _readUsuario() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String user = prefs.getString('usuario') ?? '-';

  return user;
}

Future<bool> _getStatusInternet() async {
  bool internet = false;
  final bool isConnected = await InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 10),
    checkTimeout: const Duration(seconds: 10),
  ).hasConnection;
  internet = isConnected;
  return (internet);
}