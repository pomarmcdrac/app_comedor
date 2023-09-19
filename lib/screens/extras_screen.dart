import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/search/search_delegate_person.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String _nombre = '';
String? _alimento;
String? _ubicacion;
String _fecha = '';

TextEditingController dateController = TextEditingController();

class ExtrasScreen extends StatefulWidget {

  static const String routerName = 'Extras';
   
  const ExtrasScreen({Key? key}) : super(key: key);

  @override
  State<ExtrasScreen> createState() => _ExtrasScreenState();
}

class _ExtrasScreenState extends State<ExtrasScreen> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    void agregarPersonaExtra(BuildContext context) async {
      
      final Size size = MediaQuery.of(context).size;
      
      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: size.height * 0.5,
            width: size.width * 0.8,
            child: AlertDialog(
              title: const Text(
                'Agregar extra de comida',
                style: TextStyle(
                  color: AppTheme.secondary,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
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
                height: size.height * 0.41,
                child: Material(
                  color: Colors.transparent,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SizedBox(
                      height: size.height * 0.5,
                      width: size.width,
                      child: SingleChildScrollView(
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
                                      width: size.width * 0.6,
                                      child: TextFormField(
                                        cursorColor: Colors.white,
                                        keyboardType: TextInputType.text,
                                        decoration: _InputDecorationExtra._authInputDecorationExtra(
                                          hintText: 'Nombre de la persona',
                                          labelText: 'Nombre',
                                          prefixIcon: Icons.person_outline_rounded
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
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
                            const SizedBox(height: 5,),
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
                              padding: const EdgeInsets.all(10),
                              child: const _OpcionesUbicacionExtra(),
                            ),
                            const SizedBox(height: 20,),
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
                              padding: const EdgeInsets.all(20),
                              child: const _OpcionesAlimentos(),
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
                                    left: size.width * 0.025,
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height: 82,
                                      width: size.width * 0.65,
                                      child: TextFormField(
                                        controller: dateController,
                                        cursorColor: Colors.white,
                                        keyboardType: TextInputType.datetime,
                                        readOnly: true,
                                        decoration: _InputDecorationExtra._authInputDecorationExtra(
                                          hintText: '',
                                          labelText: 'Fecha',
                                          prefixIcon: Icons.date_range_rounded
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                            locale: const Locale("es", "MX"),
                                            helpText: 'Selecciona una fecha inicial',
                                            context: context, 
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                                            builder: (context, child) {
                                              return Theme(
                                                data: ThemeData.dark().copyWith(
                                                  dialogTheme: DialogTheme(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ) 
                                                  ),
                                                  colorScheme:  const ColorScheme.dark(
                                                    onPrimary: Colors.black,
                                                    onSurface: Colors.white,
                                                    primary: Colors.grey
                                                  ),
                                                  dialogBackgroundColor: Colors.black,
                                                  textButtonTheme: TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.white, 
                                                      textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 12,
                                                      ),
                                                      backgroundColor: Colors.black,
                                                    )
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          if(pickedDate != null ){
                                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                            setState(() {
                                              dateController.text = formattedDate;
                                              _fecha = formattedDate;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    ),
                  )
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
          title: const Text('EXTRAS'),
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
                agregarPersonaExtra(context);
              }, 
              icon: const Icon(Icons.group_add_rounded, color: AppTheme.primary, size: 30,)
            )
          ],
        ),
        body: Container(
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
                  OutlinedButton(
                    onPressed: () => showSearch(
                      context: context, 
                      delegate: EmpleadoSearchDelegate(),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 2,
                      padding: const EdgeInsets.all(0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        width: size.height,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[800]
                        ),
                        height: 45,
                        child: Row(
                          children: [
                            const SizedBox( width: 10,),
                            Icon( Icons.person_search_rounded, color: Colors.grey[200]),
                            const SizedBox( width: 10,),
                            Text('Buscar colaborador', style: TextStyle(color: Colors.grey[200], fontSize: 18),) 
                          ],
                        ),
                      ),
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: size.height * 0.8,
                    width: size.width,
                    child: ListView.builder(
                      itemCount: empleados.length,
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
                                        empleados[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      const Text(
                                        'Extra en Cube 2',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Comida',
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            DateTime.now().toString().substring(0,10),
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
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
                                    onPressed: () {
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
        )
      ),
    );
  }
}

class _InputDecorationExtra {

  static InputDecoration _authInputDecorationExtra({
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

class _OpcionesUbicacionExtra extends StatefulWidget {
  const _OpcionesUbicacionExtra({
    Key? key,
  }) : super(key: key);

  @override
  State<_OpcionesUbicacionExtra> createState() => _OpcionesUbicacionExtraState();
}

class _OpcionesUbicacionExtraState extends State<_OpcionesUbicacionExtra> {

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
        value: _ubicacion,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppTheme.azulOscuro,
          size: 30,
        ),
        style: const TextStyle(
          color: AppTheme.blanco,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        hint: const Text(
          'Ubiación...',
          style: TextStyle(
            color: AppTheme.blanco,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        items: <String>[
          'Cube 2 ',
          'Technology Park '
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) async {
          _ubicacion = newValue.toString();
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}

class _OpcionesAlimentos extends StatefulWidget {
  const _OpcionesAlimentos({
    Key? key,
  }) : super(key: key);

  @override
  State<_OpcionesAlimentos> createState() => _OpcionesAlimentosState();
}

class _OpcionesAlimentosState extends State<_OpcionesAlimentos> {

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
        value: _alimento,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppTheme.azulOscuro,
          size: 30,
        ),
        style: const TextStyle(
          color: AppTheme.blanco,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        hint: const Text(
          'Alimento...',
          style: TextStyle(
            color: AppTheme.blanco,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        items: <String>[
          'Desayuno',
          'Comida'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) async {
          _alimento = newValue.toString();
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}
