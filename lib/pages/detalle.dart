import 'package:flutter/material.dart';

class DetallePage extends StatelessWidget {
  final Map<String, dynamic> character;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const DetallePage({
    Key? key,
    required this.character,
    required this.isFavorite,
    required this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Puedes agregar más campos según lo que traiga tu API
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name'] ?? 'Detalle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${character['name'] ?? 'Desconocido'}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (character['height'] != null)
              Text('Altura: ${character['height']}'),
            if (character['mass'] != null)
              Text('Peso: ${character['mass']}'),
            if (character['gender'] != null)
              Text('Género: ${character['gender']}'),
            if (character['birth_year'] != null)
              Text('Año de nacimiento: ${character['birth_year']}'),
            // Agrega aquí más campos si tu API los trae
            const SizedBox(height: 32),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                    size: 32,
                  ),
                  onPressed: onFavoriteTap,
                ),
                const SizedBox(width: 8),
                Text(isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}