import 'package:app_comedor/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black
    ));

    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      title: 'App Comedor',
      theme: ThemeData(fontFamily: 'Avenir'),
      navigatorKey: navigatorKey,
      initialRoute: CheckAuthscreen.routerName,
      routes: {
        AltasBajasScreen.routerName          :( _ ) => const AltasBajasScreen(),
        CheckAuthscreen.routerName           :( _ ) => const CheckAuthscreen(),
        DetallesScreen.routerName            :( _ ) => const DetallesScreen(),
        ExtrasScreen.routerName              :( _ ) => const ExtrasScreen(),
        HistorialScreen.routerName           :( _ ) => const HistorialScreen(),
        HomeScreen.routerName                :( _ ) => const HomeScreen(),
        LoginScreen.routerName               :( _ ) => const LoginScreen(),
        NotificacionesScreen.routerName      :( _ ) => const NotificacionesScreen(),
        RegistrarScreen.routerName           :( _ ) => const RegistrarScreen(),
        SinConexionScreen.routerName         :( _ ) => const SinConexionScreen(),
      },
      
    );
  }
}