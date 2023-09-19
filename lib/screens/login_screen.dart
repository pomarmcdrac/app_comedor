import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/apis.dart';


String usuario = '';
String password = '';

String? opcion;
String? nombre;

class LoginScreen extends StatefulWidget {

  static const String routerName = 'Login Screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/fondo.jpg')
        )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const _LogoInicio(),
                  SizedBox(
                    height: size.height * 0.12,
                    width: size.width,
                    child: const Text(
                      'Servicio de alimentos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SizedBox(
                      height: size.height * 0.55,
                      width: size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 82,
                            width: size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                  height: 60,
                                  width: size.width * 0.8,
                                ),
                                Positioned(
                                  left: size.width * 0.075,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 82,
                                    width: size.width * 0.65,
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.words,
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.text,
                                      decoration: _InputDecorationLogin._authInputDecorationLogin(
                                        hintText: 'Tu usuario',
                                        labelText: 'Usuario',
                                        prefixIcon: Icons.person_outline_rounded
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            usuario = value;
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if(value != null && value.length >= 5) return null;
                                        return 'Ingresa tu nombre de usuario';
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 82,
                            width: size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                  height: 60,
                                  width: size.width * 0.8,
                                ),
                                Positioned(
                                  left: size.width * 0.075,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 82,
                                    width: size.width * 0.65,
                                    child: TextFormField(
                                      cursorColor: Colors.white,
                                      focusNode: textFieldFocusNode,
                                      obscureText: _obscured,
                                      keyboardType: TextInputType.visiblePassword,
                                      decoration: _InputDecorationLogin._authInputDecorationLogin(
                                        hintText: 'Tu contraseña',
                                        labelText: 'Contraseña',
                                        prefixIcon: Icons.lock_outline_rounded,
                                        suffixIcon:  Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                          child: GestureDetector(
                                            onTap: _toggleObscured,
                                            child: Icon(
                                              _obscured
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                              size: 24,
                                              color: Colors.white.withOpacity(0.3),
                                            )
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            password = value;
                                          });
                                        }
                                      },
                                      validator: (value) {
                                        if(value != null && value.length >= 5) return null;
                                        return 'Ingresa tu contraseña';
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const _BotonInicioSesion(),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.8,
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                )
                              ),
                              onPressed: () {
                                if (context.mounted) {
                                  olvidoPassword(context);
                                }
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña? Toca aquí',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}

void olvidoPassword(BuildContext context) async {

  final Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: size.height * 0.25,
        width: size.width * 0.5,
        child: AlertDialog(
          contentPadding: const EdgeInsets.only(
            bottom: 5,
            left: 15,
            right: 15,
            top: 20,
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
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
            height: size.height * 0.2,
            child: const Material(
              color: Colors.transparent,
              child: Text(
                'Para recuperar o reestablecer tu contraseña, contacta al departamento de programación.',
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
                'Aceptar',
                style: TextStyle(
                  color: AppTheme.primary,
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

void seleccionarUbicacion(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height * 0.3,
        width: size.width * 0.5,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.black.withOpacity(0.8),
          title: const Text(
            'Elige tu ubicación',
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.all(5),
            width: size.width * 0.5,
            height: size.height * 0.16,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    'Indica si harás registros en Cube o en la Planta',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20,),
                  const _OpcionesUbicacion(),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                    'Cancelar',
                    style: TextStyle(
                      color: AppTheme.rosa,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                  onPressed: () async {
                    if (opcion != null && opcion != '') {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('usuario', usuario);
                      await prefs.setString('password', password);
                      await prefs.setString('ubicacion', opcion.toString());
                      await prefs.setString('name', nombre.toString());

                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, HomeScreen.routerName);
                      }
                    }
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      color: AppTheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  );
}

class _OpcionesUbicacion extends StatefulWidget {
  const _OpcionesUbicacion({
    Key? key,
  }) : super(key: key);

  @override
  State<_OpcionesUbicacion> createState() => _OpcionesUbicacionState();
}

class _OpcionesUbicacionState extends State<_OpcionesUbicacion> {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.06,
      width: size.width * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black.withOpacity(0.5),
      child: DropdownButton(
        dropdownColor: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
        underline: const SizedBox(),
        value: opcion,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppTheme.azulOscuro,
          size: 30,
        ),
        style: const TextStyle(
          color: AppTheme.blanco,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        hint: const Text(
          'Selecciona...',
          style: TextStyle(
            color: AppTheme.blanco,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        items: <String>[
          'Cube 2',
          'Technology Park'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) async {
          opcion = newValue.toString();
          opcion ??= null;
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}

class _LogoInicio extends StatelessWidget {
  const _LogoInicio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Hero(
      tag: 'logo_blanco',
      transitionOnUserGestures: true,
      child: Container(
        height: size.height * 0.27,
        width: size.width * 0.7,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/logo_blanco.png'),
          )
        ),
      ),
    );
  }
}

class _InputDecorationLogin {

  static InputDecoration _authInputDecorationLogin({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        )
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: AppTheme.rosa.withOpacity(0.1),
          width: 0.25,
        )
      ),
      errorStyle: TextStyle(
        color: AppTheme.rosa.withOpacity(0.5),
        fontSize: 10,
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.rosa,
          width: 1,
        )
      ),
      suffixIcon: suffixIcon,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        )
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey[100],
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey[100],
      ),
      prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Colors.white.withOpacity(0.5),)
        : null
    );
  }
}

class _BotonInicioSesion extends StatefulWidget {
  const _BotonInicioSesion({
    Key? key, 
    }) : super(key: key);

  @override
  State<_BotonInicioSesion> createState() => _BotonInicioSesionState();
}

class _BotonInicioSesionState extends State<_BotonInicioSesion> {

  ButtonState stateOnlyCustomIndicatorText = ButtonState.idle;


  Widget buildCustomProgressIndicatorButton() {
    
    final Size size = MediaQuery.of(context).size;
    
    var progressTextButton = ProgressButton(
      progressIndicatorSize: 30,
      height: 50,
      radius: 30,
      progressIndicatorAlignment: MainAxisAlignment.spaceBetween,
      stateWidgets: const {
        ButtonState.idle: Text(
          "Ingresar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.loading: Text(
          "Validando...",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.fail: Text(
          "Información incorrecta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          "¡Datos correctos!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      progressIndicator:  const CircularProgressIndicator( backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent), strokeWidth: 1, ),
      stateColors: const {
        ButtonState.idle: AppTheme.azulOscuro,
        ButtonState.loading: Colors.grey,
        ButtonState.fail: AppTheme.rosa,
        ButtonState.success: AppTheme.secondary,
      },
      onPressed: onPressedCustomIndicatorButton,
      state: stateOnlyCustomIndicatorText,
      padding: const EdgeInsets.all(5),
      minWidth: size.width * 0.8,
      maxWidth: size.width * 0.8,
    );
    return progressTextButton;
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1
        )
      ),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCustomProgressIndicatorButton()
            ],
          ),
      ),
    );
  }

  void onPressedCustomIndicatorButton() async {
    if (usuario != '' && password != '') {
      switch (stateOnlyCustomIndicatorText) {
        case ButtonState.idle:
          FocusScope.of(context).unfocus();
          Future.delayed(const Duration(seconds: 0), () {
            setState(() {
              stateOnlyCustomIndicatorText = ButtonState.loading;
            });
          });
          Future.delayed(const Duration(seconds: 1), () async {
            final res = await _validarAcceso();

            if (res.contains('true') && context.mounted) {
              setState(() {
                stateOnlyCustomIndicatorText = ButtonState.success;
              });
              seleccionarUbicacion(context);
            } else {
              setState(() {
                stateOnlyCustomIndicatorText = ButtonState.idle;
              });
              final Size size = MediaQuery.of(context).size;
              const mensaje = 'Los datos ingresados son incorrectos. Favor de verficar.';
              _flushGenerico(size, mensaje).show(context);
            }
          });
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              stateOnlyCustomIndicatorText = ButtonState.idle;
            });
          });
          break;
        case ButtonState.loading:
          break;
        case ButtonState.success:
          break;
        case ButtonState.fail:
          break;
      }
      setState(() {
        stateOnlyCustomIndicatorText = stateOnlyCustomIndicatorText;
      });
    } else {
      final Size size = MediaQuery.of(context).size;

      if (context.mounted) {
        _flushDeAviso(size).show(context);
      }
    }
  }

  Flushbar<dynamic> _flushDeAviso(Size size) {
    return Flushbar(
        reverseAnimationCurve: Curves.elasticInOut,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.elasticInOut,
        maxWidth: size.width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 120),
        backgroundColor: Colors.black,
        titleText: const Text(
          '¡Aviso!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        messageText: const Text(
          'Para acceder, debes ingresar los datos solicitados',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        borderRadius: BorderRadius.circular(20),
        borderColor: Colors.white,
        padding: const EdgeInsets.all(5),
        animationDuration: const Duration(seconds: 3),
        duration: const Duration(seconds: 4),
      );
  }
}

Flushbar<dynamic> _flushGenerico(Size size, String mensaje) {
  return Flushbar(
      reverseAnimationCurve: Curves.elasticInOut,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.elasticInOut,
      maxWidth: size.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 120),
      backgroundColor: Colors.black,
      titleText: const Text(
        '¡Aviso!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      messageText: Text(
        mensaje,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      borderRadius: BorderRadius.circular(20),
      borderColor: Colors.white,
      padding: const EdgeInsets.all(5),
      animationDuration: const Duration(seconds: 3),
      duration: const Duration(seconds: 4),
    );
}

Future<String> _validarAcceso() async {
  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}validarAcceso'), 
      body: jsonEncode(<String, dynamic>{
        "UsuariosUserName": usuario,
        "UsuariosPassword": password,
    })
  );

  Map<String,dynamic> datos = jsonDecode(response.body);
  nombre = datos['name'];

  return response.body;
}
