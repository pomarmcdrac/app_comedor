// import 'dart:async';

// import 'package:app_comedor/helpers/debouncer.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductosService extends ChangeNotifier {
//   final String _baseUrl = 'sheloapp.herokuapp.com';
//   final String _segmento = '/sheloapp/api/productos/getProductosBuscar';

//   List<String> displayProductos = [];

//   final debouncer = Debouncer(
//     duration: const Duration( milliseconds: 200 ),
//   );

//   final StreamController<List<String>> _suggestionsStreamController = StreamController.broadcast();
//     Stream<List<String>> get suggestionsStream => _suggestionsStreamController.stream;

//     Future<List<String>> getProductosBuscar (String query) async {


//     var url = Uri.https(_baseUrl, _segmento);
//     final response = await http.post(url, body: {
//       'textoBuscado':	query
//     });

//     final searchEmpleadosResponse = (response.body);

//     final displayProductos = searchEmpleadosResponse.data.t;

//     return displayProductos;

//   }


//   void getSuggestionsByQuery( String searchTerm ) {

//     debouncer.value = '';
//     debouncer.onValue = ( value ) async {
//         final results = await getProductosBuscar( searchTerm );
//         _suggestionsStreamController.add(results);
//     };

//     final timer = Timer.periodic( const Duration(milliseconds: 300), ( _ ) {
//       debouncer.value = searchTerm;
//      });

//      Future.delayed( const Duration( milliseconds: 301 )).then(( _ ) => timer.cancel());

//   }

// }