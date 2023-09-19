

import 'package:app_comedor/theme/app_theme.dart';
import 'package:flutter/material.dart';

List<String> empleados = [
  'Lorena Veloz Ramírez',
  'Giuseppe Abril Rochin Carmelu',
  'Erika Hernández Hernández',
  'César Elioberto Anguiano Pereda',
  'Luis Octavio López Ramírez',
  'Susana de la Rosa Luevanos',
  'Omar Alejandro Morales Mendoza',
  'Monstserrat Estrih Sánchez Martinez' 
];

class EmpleadoSearchDelegate extends SearchDelegate<String> {

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.black,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.green),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal
        ),
        titleMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal
        ),
        titleSmall: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal
        ),
      ), 
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey[600],
        selectionColor: Colors.grey,
        selectionHandleColor: Colors.grey[600]
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.black
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hoverColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none
        )
      ), 
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme(
        background: Colors.black, 
        brightness: Brightness.dark, 
        error: Colors.transparent, 
        onBackground: Colors.blue, 
        onError: Colors.transparent, 
        onPrimary: Colors.redAccent, 
        onSecondary: Colors.white, 
        onSurface: Colors.white, 
        primary: Colors.transparent, 
        secondary: Colors.white, 
        surface: Colors.black,
      )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    if (query.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: const Center(
          child: Text(
            'No hay registros',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
        )
      );
    }
    return ListView.builder(
      itemCount: empleados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
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
                        'No. de colaborador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        '30251$index',
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    if (query.isEmpty) {
      return const Center(child: Text('No hay registros'),);
    }
    
    return ListView.builder(
      itemCount: empleados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
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
                        'No. de colaborador',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        '30251$index',
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
    );
  }
}
