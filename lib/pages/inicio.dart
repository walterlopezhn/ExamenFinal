import 'package:flutter/material.dart';
import '../services/starwarapi.dart';
import '../utility/StarWarsCard.dart';
import 'detalle.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Map<String, dynamic>> _characters = [];
  List<Map<String, dynamic>> _allCharacters = [];
  List<Map<String, dynamic>> _favorites = [];
  String _search = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllCharacters();
  }

  // Trae todos los personajes de todas las páginas usando StarWarsApi
  Future<void> _fetchAllCharacters() async {
    setState(() => _isLoading = true);
    final all = await StarWarsApi.fetchAllPeople();
    setState(() {
      _allCharacters = all;
      _characters = all;
      _isLoading = false;
    });
  }

  // Busca personajes por nombre usando StarWarsApi
  Future<void> _fetchCharactersBySearch(String search) async {
    setState(() => _isLoading = true);
    final results = await StarWarsApi.searchPeople(search);
    setState(() {
      _characters = results;
      _isLoading = false;
    });
  }

  void _toggleFavorite(Map<String, dynamic> character) {
    setState(() {
      if (_favorites.any((fav) => fav['name'] == character['name'])) {
        _favorites.removeWhere((fav) => fav['name'] == character['name']);
      } else {
        _favorites.add(character);
      }
    });
  }

  void _filterCharactersLocally(String search) {
    setState(() {
      if (search.trim().isEmpty) {
        _characters = _allCharacters;
      } else {
        _characters = _allCharacters
            .where(
              (c) => (c['name'] ?? '').toString().toLowerCase().contains(
                search.trim().toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 4 : 2;
    final double imageSize = screenWidth / (crossAxisCount * 1.2);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Wars Personajes'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people), text: "Personajes"),
              Tab(icon: Icon(Icons.favorite), text: "Favoritos"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Página de personajes
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar personaje',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _search = value;
                      _filterCharactersLocally(_search);
                    },
                  ),
                ),
                if (_isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_characters.isEmpty)
                  const Expanded(
                    child: Center(child: Text('No se encontraron personajes')),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      itemCount: _characters.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final character = _characters[index];
                        final isFavorite = _favorites.any(
                          (fav) => fav['name'] == character['name'],
                        );
                        return StarWarsCard(
                          character: character,
                          isFavorite: isFavorite,
                          onFavoriteTap: () => _toggleFavorite(character),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetallePage(
                                  character: character,
                                  isFavorite: isFavorite,
                                  onFavoriteTap: () {
                                    _toggleFavorite(character);
                                    Navigator.pop(
                                      context,
                                    ); // Para actualizar favoritos al volver
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
            // Página de favoritos
            _favorites.isEmpty
                ? const Center(child: Text('No hay favoritos'))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: _favorites.length,
                    itemBuilder: (context, index) {
                      final character = _favorites[index];
                      return StarWarsCard(
                        character: character,
                        isFavorite: true,
                        imageSize: imageSize,
                        onDeleteTap: () => _toggleFavorite(character),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetallePage(
                                character: character,
                                isFavorite: true,
                                onFavoriteTap: () {
                                  _toggleFavorite(character);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}