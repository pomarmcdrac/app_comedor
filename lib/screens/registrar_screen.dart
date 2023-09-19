import 'dart:convert';
import 'dart:io';

// import 'package:another_flushbar/flushbar.dart';
import 'package:app_comedor/helpers/apis.dart';
import 'package:app_comedor/models/models.dart';
import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

String nombreEmpleado = '';
String comidaSolicitada = '';
String numeroEmpleado = '';
String ubicacionEmpleado = '';
String comentarios = '';


class RegistrarScreen extends StatefulWidget {

  static const String routerName = 'Registrar';
   
  const RegistrarScreen({Key? key}) : super(key: key);

  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState();
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final String day = DateTime.now().day.toString();
    final String month = DateTime.now().month.toString();
    final String year = DateTime.now().year.toString();
    final String date = '$day/$month/$year';

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
          title: const Text('REGISTRAR'),
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
          child: Column(
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                height: size.height * 0.12,
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      )
                    )
                  ),
                  onPressed: () async {
                    await Permission.camera.request();
                    if (Platform.isAndroid) {
                      var barcode = await scanner.scan();
                      if (barcode == null) {
                      } else {
                        if (barcode.toLowerCase() != '') {
                          final res = await _colaboradoresBuscar(barcode.trim());

                          if (res[0].solicitudesDeComidaIsTomada == true) {
                            //ya comió
                            nombreEmpleado = '';
                            comidaSolicitada = '';
                            numeroEmpleado = '';
                            ubicacionEmpleado = '';
                            comentarios = '';
                            (context as Element).markNeedsBuild();

                            if (context.mounted) {
                              _avisoYaComio(context);
                            }
                          
                          } else {
                            if (context.mounted) {
                              setState(() {
                                nombreEmpleado = res[0].colaboradoresNombre;
                                comidaSolicitada = res[0].solicitudesDeComidaPedido;
                                numeroEmpleado = res[0].colaboradoresClave;
                                ubicacionEmpleado = res[0].colaboradoresUbicacionBase;
                                comentarios = res[0].solicitudesDeComidaComentarios;
                              });
                              // Flushbar(
                              //   reverseAnimationCurve: Curves.easeOutCirc,
                              //   dismissDirection: FlushbarDismissDirection.VERTICAL,
                              //   forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
                              //   maxWidth: size.width * 0.7,
                              //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 100),
                              //   backgroundColor: Colors.black,
                              //   titleText: const Text(
                              //     'Código válido',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 14
                              //     ),
                              //     textAlign: TextAlign.center,
                              //   ),
                              //   messageText: const Text(
                              //     '',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 2
                              //     ),
                              //     textAlign: TextAlign.center,
                              //   ),
                              //   borderColor: Colors.white,
                              //   borderRadius: BorderRadius.circular(20),
                              //   padding: const EdgeInsets.all(5),
                              //   animationDuration: const Duration(seconds: 1),
                              //   duration: const Duration(seconds: 1),
                              // ).show(context);
                            }
                          }
                        }
                      }
                    } else {
                      var barcode = await BarcodeScanner.scan();
                      if (barcode.rawContent.isEmpty) {
                      } else {
                        if (barcode.rawContent.toLowerCase() != '') {
                          final res = await _colaboradoresBuscar(barcode.rawContent.trim());

                          if (res[0].solicitudesDeComidaIsTomada == true) {
                            //ya comió
                            nombreEmpleado = '';
                            comidaSolicitada = '';
                            numeroEmpleado = '';
                            ubicacionEmpleado = '';
                            comentarios = '';
                            (context as Element).markNeedsBuild();

                            if (context.mounted) {
                              _avisoYaComio(context);
                            }
                          
                          } else {
                            if (context.mounted) {
                              setState(() {
                                nombreEmpleado = res[0].colaboradoresNombre;
                                comidaSolicitada = res[0].solicitudesDeComidaPedido;
                                numeroEmpleado = res[0].colaboradoresClave;
                                ubicacionEmpleado = res[0].colaboradoresUbicacionBase;
                                comentarios = res[0].solicitudesDeComidaComentarios;
                              });
                              // Flushbar(
                              //   reverseAnimationCurve: Curves.easeOutCirc,
                              //   dismissDirection: FlushbarDismissDirection.VERTICAL,
                              //   forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
                              //   maxWidth: size.width * 0.7,
                              //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 100),
                              //   backgroundColor: Colors.black,
                              //   titleText: const Text(
                              //     'Código válido',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 14
                              //     ),
                              //     textAlign: TextAlign.center,
                              //   ),
                              //   messageText: const Text(
                              //     '',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 2
                              //     ),
                              //     textAlign: TextAlign.center,
                              //   ),
                              //   borderColor: Colors.white,
                              //   borderRadius: BorderRadius.circular(20),
                              //   padding: const EdgeInsets.all(5),
                              //   animationDuration: const Duration(seconds: 1),
                              //   duration: const Duration(seconds: 1),
                              // ).show(context);
                            }
                          }
                        }
                      }
                    }
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: const Text(
                            'Toca la aquí para escanear un QR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.qr_code_2_rounded,
                          color: Colors.white,
                          size: size.height * 0.1,
                        )
                      ],
                    ),
                  )
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'COMIDA / DESAYUNO',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: size.height * 0.57,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                      child: Text(
                        'Nombre',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      child: AutoSizeText(
                        nombreEmpleado,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 34,
                        minFontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                      child: Text(
                        'Pidió',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      child: AutoSizeText(
                        comidaSolicitada,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32
                        ),
                        maxLines: 2,
                        minFontSize: 28,
                        maxFontSize: 34,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                      child: Text(
                        'Comentarios',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.16,
                      child: AutoSizeText(
                        comentarios,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32
                        ),
                        maxLines: 4,
                        maxFontSize: 32,
                        minFontSize: 20,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: size.height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                                width: size.width * 0.29,
                                child: Text(
                                  'No. de colaborador',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 10
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.29,
                                child: Text(
                                  numeroEmpleado,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                                width: size.width * 0.25,
                                child: Text(
                                  'Ubicación regular',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 10
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.25,
                                child: AutoSizeText(
                                  ubicacionEmpleado,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                                width: size.width * 0.25,
                                child: Text(
                                  'Ubicación actual',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 10
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.25,
                                child: AutoSizeText(
                                  ubicacion,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  minFontSize: 10,
                                  maxFontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondary,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      )
                    )
                  ),
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        nombreEmpleado = '';
                        comidaSolicitada = '';
                        numeroEmpleado = '';
                        ubicacionEmpleado = '';
                      });
                    }
                    Future.delayed(const Duration(microseconds: 500),() {
                      confirmarRegistro(context);
                    },);
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      'REGISTRAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

void confirmarRegistro(BuildContext context) async {

  final Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: size.height * 0.1,
        width: size.width * 0.5,
        child: AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          content: Container(
            padding: const EdgeInsets.all(5),
            width: size.width * 0.5,
            height: size.height * 0.1,
            child: const Material(
              color: Colors.transparent,
              child: Text(
                'Registro correcto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text(
                'Continuar',
                style: TextStyle(
                  color: AppTheme.secondary,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void _avisoYaComio(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            )
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
          title: const Text(
            '!UPS¡',
            style: TextStyle(
              color: AppTheme.blanco,
              fontSize: 20
            ),
          ),
          titlePadding: const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 30),
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          content: const Text(
            'Este colaborador ya tomó su comida del día de hoy.',
            style: TextStyle(
              color: AppTheme.blanco,
              fontSize: 20
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'ENTENDIDO',
                style: TextStyle(
                  color: AppTheme.rosa,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

Future<List<SdtSolicitudesDeComida>> _colaboradoresBuscar(String numColab) async {

  List<SdtSolicitudesDeComida> sdtSolicitudesDeComida = [];
  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}getmisolicituddecomida'),
      body: jsonEncode(<String, dynamic>{
        "numColab": numColab,
    })
  );

  final solicitudesComidaModel = SolicitudesComidaModel.fromJson(response.body);
  sdtSolicitudesDeComida = solicitudesComidaModel.sdtSolicitudesDeComida;

  return sdtSolicitudesDeComida;
}