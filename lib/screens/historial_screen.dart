import 'package:app_comedor/screens/screens.dart';
import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String fechaInicial = '';
String fechaFinal = '';
String fechaInicialC = '';
String fechaFinalC = '';

TextEditingController dateInicial = TextEditingController();
TextEditingController dateFinal = TextEditingController();
TextEditingController dateInicialC = TextEditingController();
TextEditingController dateFinalC = TextEditingController();

class HistorialScreen extends StatefulWidget {

  static const String routerName = 'Historial';
   
  const HistorialScreen({Key? key}) : super(key: key);

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {


  @override
  void initState() {
    dateInicial.text = '';
    super.initState();
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
          title: const Text('HISTORIAL'),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5)
                  ),
                  height: size.height * 0.33,
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.width,
                        child: Text(
                          'Consultas por fechas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.018
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.35,
                            child: TextField(
                              controller: dateInicial,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              decoration: _InputDecorationFecha._authInputDecorationFecha(
                                hintText: '',
                                labelText: 'Fecha inicial',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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
                                    dateInicial.text = formattedDate;
                                    fechaInicial = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.35,
                            child: TextFormField(
                              controller: dateFinal,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              decoration: _InputDecorationFecha._authInputDecorationFecha(
                                hintText: 'dd/mm/aaaa',
                                labelText: 'Fecha final',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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
                                    dateFinal.text = formattedDate;
                                    fechaFinal = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          const Expanded(child: SizedBox(width: 10,)),
                          Container(
                            width: size.width * 0.12,
                            height: size.width * 0.12,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppTheme.primary,
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
                                  Icons.search_rounded,
                                  color: AppTheme.blanco,
                                  size: size.height * 0.03,
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.02,),
                      Container(
                        height: size.height * 0.18,
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Desayunos',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      const Text(
                                        '42',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Comidas',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      const Text(
                                        '58',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Extras',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      const Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: size.width * 0.1,),
                                  Column(
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      const Text(
                                        '102',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, DetallesScreen.routerName);
                                  },
                                  child: Text(
                                    'Toca para ver el detalle',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14
                                    ),
                                  ) 
                                ),
                                TextButton(
                                  onPressed: () {
                                    opcionesCompartir(context);
                                  },
                                  child: Text(
                                    'Más opciones',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14
                                    ),
                                  ) 
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02,),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5)
                  ),
                  height: size.height * 0.41,
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.width,
                        child: Text(
                          'Consultas por colaborador',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.018
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.88,
                            child: TextField(
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              decoration: _InputDecorationFecha._authInputDecorationFecha(
                                hintText: '',
                                labelText: 'Buscar colaborador',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.35,
                            child: TextField(
                              controller: dateInicialC,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              decoration: _InputDecorationFecha._authInputDecorationFecha(
                                hintText: '',
                                labelText: 'Fecha inicial',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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
                                    dateInicialC.text = formattedDate;
                                    fechaInicialC = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            height: size.height * 0.05,
                            width: size.width * 0.35,
                            child: TextFormField(
                              controller: dateFinalC,
                              textAlign: TextAlign.center,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              decoration: _InputDecorationFecha._authInputDecorationFecha(
                                hintText: 'dd/mm/aaaa',
                                labelText: 'Fecha final',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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
                                    dateFinalC.text = formattedDate;
                                    fechaFinalC = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          const Expanded(child: SizedBox(width: 10,)),
                          Container(
                            width: size.width * 0.12,
                            height: size.width * 0.12,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppTheme.primary,
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
                                  Icons.search_rounded,
                                  color: AppTheme.blanco,
                                  size: size.height * 0.03,
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.02,),
                      Container(
                        height: size.height * 0.18,
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                        child: Text(
                                          'Desayunos',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: const Text(
                                          '0',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                        child: Text(
                                          'Comidas',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: const Text(
                                          '5',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                        child: Text(
                                          'Ubicación',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: const Text(
                                          'Cube',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: size.width * 0.1,),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.02,
                                        child: Text(
                                          'Total',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.02,),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: const Text(
                                          '5',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, DetallesScreen.routerName);
                                  },
                                  child: Text(
                                    'Toca para ver el detalle',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14
                                    ),
                                  ) 
                                ),
                                TextButton(
                                  onPressed: () {
                                    opcionesCompartir(context);
                                  },
                                  child: Text(
                                    'Más opciones',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14
                                    ),
                                  ) 
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

void opcionesCompartir(BuildContext context) async {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
              ),
              height: size.height * 0.31,
              width: size.width,
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                insetPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.only(
                    bottom: 5, top: 20, left: 10, right: 10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                content: Container(
                  color: Colors.transparent,
                  width: size.width,
                  height: size.height * 0.25,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                          child: GestureDetector(
                            onTap: () {
                              print('Compartir');
                            },
                            child: Row(
                              children: [
                                SizedBox(width: size.width * 0.1,),
                                const Icon(Icons.share_rounded, color: Colors.white, size: 40),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Compartir',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          child: GestureDetector(
                            onTap: () {
                              print('Enviar por correo');
                            },
                            child: Row(
                              children: [
                                SizedBox(width: size.width * 0.1,),
                                const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 40),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Enviar por correo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          child: GestureDetector(
                            onTap: () {
                              print('Copiar');
                            },
                            child: Row(
                              children: [
                                SizedBox(width: size.width * 0.1,),
                                const Icon(Icons.copy_rounded, color: Colors.white, size: 40),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Copiar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          child: GestureDetector(
                            onTap: () {
                              print('Generar PDF');
                            },
                            child: Row(
                              children: [
                                SizedBox(width: size.width * 0.1,),
                                const Icon(Icons.print_rounded, color: Colors.white, size: 40),
                                const SizedBox(width: 20,),
                                const Text(
                                  'Generar PDF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}


class _InputDecorationFecha {

  static InputDecoration _authInputDecorationFecha({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0),
          width: 1,
        )
      ),
      suffixIcon: suffixIcon,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0),
          width: 1,
        )
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey[100],
        fontSize: 10,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey[100],
        fontSize: 10,
      ),
      prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Colors.white.withOpacity(0.5),)
        : null
    );
  }
}