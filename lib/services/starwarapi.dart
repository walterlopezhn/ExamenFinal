<<<<<<< HEAD
=======
import 'dart:convert';
import 'package:http/http.dart' as http;

class StarWarsApi {
  static const String _baseUrl = 'https://swapi.info/api/people';

  /// Carga todos los personajes con detección flexible del formato JSON
  static Future<List<Map<String, dynamic>>> fetchAllPeople() async {
    final List<Map<String, dynamic>> allCharacters = [];
    String? url = _baseUrl;
    int page = 1;

    try {
      while (url != null) {
        print('🔎 Solicitando: $url');
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'User-Agent': 'Dart/FlutterApp (YoiExplorer 1.0)',
            'Accept': 'application/json',
          },
        );

        print('🔎 Código de estado: ${response.statusCode}');
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          print('🔎 Respuesta: $jsonData');

          if (jsonData is List) {
            allCharacters.addAll(
              jsonData.map((item) => Map<String, dynamic>.from(item)).toList(),
            );
            url = null; // fin de la carga (no hay paginación)
          } else if (jsonData is Map &&
              jsonData.containsKey('results') &&
              jsonData['results'] is List) {
            final List<dynamic> results = jsonData['results'];
            allCharacters.addAll(
              results.map((item) => Map<String, dynamic>.from(item)).toList(),
            );
            // Si el campo next es vacío o null, termina el ciclo
            url = (jsonData['next'] != null && jsonData['next'].toString().isNotEmpty)
                ? jsonData['next']
                : null;
          } else {
            print('⚠ Formato de respuesta inesperado: $jsonData');
            break;
          }
        } else {
          throw Exception('Error HTTP: ${response.statusCode}');
        }
        page++;
      }
    } catch (e) {
      print('❌ Error en fetchAllPeople: $e');
    }

    print('✅ Total personajes cargados: ${allCharacters.length}');
    return allCharacters;
  }

  /// Búsqueda de personajes con headers personalizados
  static Future<List<Map<String, dynamic>>> searchPeople(String query) async {
    final String url = '$_baseUrl?search=${Uri.encodeComponent(query.trim())}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Dart/FlutterApp (YoiExplorer 1.0)',
          'Accept': 'application/json',
        },
      );

      print('🔎 [BUSCADOR] Código de estado: ${response.statusCode}');
      print('🔎 [BUSCADOR] URL: $url');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('🔎 [BUSCADOR] Respuesta: $jsonData');
        if (jsonData is List) {
          return jsonData
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        } else if (jsonData is Map &&
            jsonData.containsKey('results') &&
            jsonData['results'] is List) {
          return (jsonData['results'] as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } else {
          print('⚠ Respuesta inesperada en búsqueda: $jsonData');
        }
      }
    } catch (e) {
      print('❌ Error en searchPeople: $e');
    }

    return [];
  }
}

>>>>>>> origin/main
