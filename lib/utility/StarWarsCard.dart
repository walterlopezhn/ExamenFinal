import 'package:flutter/material.dart';

class StarWarsCard extends StatelessWidget {
  final Map<String, dynamic> character;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onDeleteTap;
  final double? imageSize;

  const StarWarsCard({
    Key? key,
    required this.character,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
    this.onDeleteTap,
    this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double nameBarHeight = 36;
    final double iconButtonSize = 32;

    return GestureDetector(
      onTap: onTap, // <-- Esto debe estar aquí
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // Nombre del personaje, siempre visible abajo
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: nameBarHeight,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    character['name'] ?? 'Sin nombre',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Botón de favorito o eliminar (opcional)
              if (onDeleteTap != null || onFavoriteTap != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: onDeleteTap != null
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          iconSize: iconButtonSize,
                          onPressed: onDeleteTap,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          iconSize: iconButtonSize,
                          onPressed: onFavoriteTap,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  final List<Map<String, dynamic>> _characters;

  const CharacterList(this._characters, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          final character = _characters[index];
          return ListTile(
            title: Text(character['name'] ?? 'Sin nombre'),
            subtitle: Text('Género: ${character['gender'] ?? 'Desconocido'}'),
          );
        },
      ),
    );
  }
}
