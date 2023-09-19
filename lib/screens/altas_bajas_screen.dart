import 'dart:convert';

import 'package:app_comedor/models/models.dart';
import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../helpers/apis.dart';
import '../widgets/animacion.dart';

String? opcionUbicacion;
String? opcionEmpresa;
String _clave = '';
String _nombre = '';

List<SdtColaboradore> _colaboradoresLista = [];

class AltasBajasScreen extends StatefulWidget {

  static const String routerName = 'Altas y Bajas';
   
  const AltasBajasScreen({Key? key}) : super(key: key);

  @override
  State<AltasBajasScreen> createState() => _AltasBajasScreenState();
}

class _AltasBajasScreenState extends State<AltasBajasScreen> {

  @override
  void initState() {
    super.initState();
    _getAllColaboradores().then((value) {
      if (mounted) {
        setState(() {
          _colaboradoresLista = value;
        });
      }
    });
  }

  Future _refreshPage() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AltasBajasScreen(),
            transitionDuration: const Duration(seconds: 0),
          ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
          title: const Text('ALTAS Y BAJAS'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30,),
            onPressed: () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, HomeScreen.routerName);
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                agregarEmpleado(context);
              },
              icon: const Icon(
                Icons.person_add_alt_1_rounded,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          color: AppTheme.blanco,
          backgroundColor: Colors.grey,
          strokeWidth: 2,
          displacement: 5,

          onRefresh: _refreshPage,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              
              return Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: false,
                            style: DefaultTextStyle.of(context).style.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 16
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder()
                            )
                          ),
                          suggestionsCallback: (pattern) async {
                            return await _colaboradoresBuscar(pattern);
                          },
                          itemBuilder: (context, SdtColaboradore suggestion) {
                            return ListTile(
                              leading: const Icon(Icons.people),
                              title: Text(suggestion.colaboradoresNombre),
                              subtitle: Text(suggestion.colaboradoresEmpresa),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => _paraEliminarColab(suggestion, context)
                            ));
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: size.height * 0.8,
                          width: size.width,
                          child: ListView.builder(
                            itemCount: _colaboradoresLista.length,
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
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.75,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _colaboradoresLista[index].colaboradoresNombre,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            const Text(
                                              'No. de colaborador',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              _colaboradoresLista[index].colaboradoresClave,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Container(
                                        width: size.width * 0.1,
                                        height: size.width * 0.1,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: AppTheme.rosa,
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async{
                                            _preguntarConfirmacion(context, index);
                                          }, 
                                          child: Center(
                                            child: Icon(
                                              Icons.delete_forever_rounded,
                                              color: AppTheme.rosa,
                                              size: size.height * 0.03,
                                            ),
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ),
    );
  }

  AlertDialog _paraEliminarColab(SdtColaboradore suggestion, BuildContext context) {
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
        'Eliminar colaborador',
        style: TextStyle(
          color: AppTheme.blanco,
          fontSize: 20
        ),
      ),
      titlePadding: const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 30),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: Text(
        '¿Deseas eliminar a ${suggestion.colaboradoresNombre} de la base de datos?',
        style: const TextStyle(
          color: AppTheme.blanco,
          fontSize: 14
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: AppTheme.rosa,
              fontSize: 12,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(
            'Sí, eliminar',
            style: TextStyle(
              color: AppTheme.secondary,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            _mostrarPantallaCarga(context);
            final res = await _eliminarColaborador(suggestion.colaboradoresId.toString());

            if (res.contains('true') && context.mounted) {
              Navigator.pop(context);
              _confirmarEliminado(context);
            } else {
              Navigator.pop(context);
              _errorEliminar(context, res);
            }
          },
        ),
      ],
    );
  }

  void _mostrarPantallaCarga(BuildContext context) async {

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        
        final Size size = MediaQuery.of(context).size;

        return Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.white,
                width: 2
              )
            ),
            elevation: 0,
            content:  SizedBox(
              height: size.height * 0.17,
              width: size.width * 0.4,
              child: const Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Animacion()
                  ),
                  Text(
                    'Prerarando...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _preguntarConfirmacion(BuildContext context, int index) {
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
            'Eliminar colaborador',
            style: TextStyle(
              color: AppTheme.blanco,
              fontSize: 20
            ),
          ),
          titlePadding: const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 30),
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          content: Text(
            '¿Deseas eliminar a ${_colaboradoresLista[index].colaboradoresNombre} de la base de datos?',
            style: const TextStyle(
              color: AppTheme.blanco,
              fontSize: 14
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: AppTheme.rosa,
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Sí, eliminar',
                style: TextStyle(
                  color: AppTheme.secondary,
                  fontSize: 18,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                _mostrarPantallaCarga(context);
                final res = await _eliminarColaborador(_colaboradoresLista[index].colaboradoresId.toString());

                if (res.contains('true') && context.mounted) {
                  Navigator.pop(context);
                  _confirmarEliminado(context);
                } else {
                  Navigator.pop(context);
                  _errorEliminar(context, res);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _errorEliminar(BuildContext context, String res) {
    return showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('!UPS¡ ERROR'),
                      content: Text(
                        'No pudimos eliminar a este colaborador de nuestros registros. \nError: $res',
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Entendido'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
  }

  void _confirmarEliminado(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        final Size size = MediaQuery.of(context).size;

        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              )
            ),
            backgroundColor: Colors.black.withOpacity(0.8),
            title: const Text(
              'Colaborador eliminado',
              style: TextStyle(
                color: AppTheme.blanco,
                fontSize: 20
              ),
            ),
            titlePadding: const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 30),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            content: SizedBox(
              height: size.height * 0.16,
              width: size.width * 0.3,
              child: const Column(
                children: [
                  Text(
                    'Este colaborador ha sido eliminado de nuestra base de datos.',
                    style: TextStyle(
                      color: AppTheme.blanco,
                      fontSize: 14
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Ya no puede solicitar comidas.',
                    style: TextStyle(
                      color: AppTheme.blanco,
                      fontSize: 14
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Si esto fue un error, lo puedes agregar nuevamente.',
                    style: TextStyle(
                      color: AppTheme.blanco,
                      fontSize: 14
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'De acuerdo',
                  style: TextStyle(
                    color: AppTheme.secondary,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Future.microtask(() {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const AltasBajasScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

void agregarEmpleado(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height * 0.5,
        width: size.width * 0.7,
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
            'Agregar nuevo colaborador',
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: size.width * 0.7,
                height: size.height * 0.45,
                child: Material(
                  color: Colors.transparent,
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
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                              height: 60,
                              width: size.width * 0.8,
                            ),
                            Positioned(
                              left: size.width * 0.05,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 82,
                                width: size.width * 0.55,
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  decoration: _InputDecorationAgregar._authInputDecorationAgregar(
                                    hintText: 'Nombre del colaborador',
                                    labelText: 'Nombre',
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  onChanged: (value) {
                                    _nombre = value;
                                  },
                                  validator: (value) {
                                    if(value != null && value.length >= 5) return null;
                                    return 'Ingresa un nombre';
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 82,
                        width: size.width * 0.8,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                              height: 60,
                              width: size.width * 0.8,
                            ),
                            Positioned(
                              left: size.width * 0.05,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 82,
                                width: size.width * 0.55,
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  decoration: _InputDecorationAgregar._authInputDecorationAgregar(
                                    hintText: 'No. de colaborador',
                                    labelText: 'No. de colaborador',
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  onChanged: (value) {
                                    _clave = value;
                                  },
                                  validator: (value) {
                                    if(value != null && value.length >= 5) return null;
                                    return 'Ingresa el número de colaborador';
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 82,
                        width: size.width * 0.8,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                              height: 60,
                              width: size.width * 0.8,
                            ),
                            Positioned(
                              left: size.width * 0.05,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 82,
                                width: size.width * 0.55,
                                child: const _OpcionesUbicacion(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 82,
                        width: size.width * 0.8,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                              height: 60,
                              width: size.width * 0.8,
                            ),
                            Positioned(
                              left: size.width * 0.05,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 82,
                                width: size.width * 0.55,
                                child: const _OpcionesEmpresa(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                    if (opcionEmpresa != null && opcionUbicacion != '' && _clave != '' && _nombre != '') {
                      
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('CONFIRMACIÓN'),
                            content: Text(
                              '¿Deseas agregar a $_nombre a la base de datos del comedor?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('SÍ, AGREGAR'),
                                onPressed: () async {
                                  //TODO: Proceso de alta de nuevo colaborador
                                  final res = await _agregarNuevoColaborador();

                                  if (res.contains('true')) {
                                    Future.microtask(() {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => const AltasBajasScreen(),
                                          transitionDuration: const Duration(seconds: 0),
                                        ));
                                    });
                                  } else {
                                    print('Error $res');
                                  }
                                  
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      print('faltan datos');
                    }
                  },
                  child: const Text(
                    'Agregar',
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
        value: opcionUbicacion,
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
          'Ubicación base...',
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
          opcionUbicacion = newValue.toString();
          opcionUbicacion ??= null;
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}

class _OpcionesEmpresa extends StatefulWidget {
  const _OpcionesEmpresa({
    Key? key,
  }) : super(key: key);

  @override
  State<_OpcionesEmpresa> createState() => _OpcionesEmpresaState();
}

class _OpcionesEmpresaState extends State<_OpcionesEmpresa> {

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
        value: opcionEmpresa,
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
          'Empresa...',
          style: TextStyle(
            color: AppTheme.blanco,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        items: <String>[
          'CORPORATIVO SERYSI',
          'DESARROLLOS SERYSI'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) async {
          opcionEmpresa = newValue.toString();
          opcionEmpresa ??= null;
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}

class _InputDecorationAgregar {

  static InputDecoration _authInputDecorationAgregar({
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
        fontSize: 8,
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

Future<List<SdtColaboradore>> _getAllColaboradores() async {

  List<SdtColaboradore> colaboradores = [];
  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}getAllColaboradores'),
  );

  final colaboradoresModel = ColaboradoresModel.fromJson(response.body);
  colaboradores = colaboradoresModel.sdtColaboradores;

  return colaboradores;
}

Future<String> _eliminarColaborador(String id) async {

  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}EliminarColaborador'),
      body: jsonEncode(<String, dynamic>{
        'id': id,
      })
  );

  return response.body;
}

Future<String> _agregarNuevoColaborador() async {

  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}AddNuevoColaborador'), 
      body: jsonEncode(<String, dynamic>{
        "clave": _clave,
        "empresa": opcionEmpresa,
        "nombre": _nombre,
        "ubicacion": opcionUbicacion,
    })
  );

  return response.body;
}

Future<List<SdtColaboradore>> _colaboradoresBuscar(String texto) async {

  List<SdtColaboradore> colaboradores = [];
  final response = await http.post(
      Uri.parse('${datosApis['URL_API_LOCAL']}ColaboradoresBuscar'),
      body: jsonEncode(<String, dynamic>{
        "textoBuscado": texto,
    })
  );

  final colaboradoresModel = ColaboradoresModel.fromJson(response.body);
  colaboradores = colaboradoresModel.sdtColaboradores;

  return colaboradores;
}