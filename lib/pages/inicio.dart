import 'package:flutter/material.dart';
import '../services/starwarapi.dart';
import '../utility/StarWarsCard.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final StarWarsApi api = StarWarsApi();
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

  // Trae todos los personajes de todas las páginas
  Future<void> _fetchAllCharacters() async {
    setState(() => _isLoading = true);
    try {
      List<Map<String, dynamic>> all = [];
      int page = 1;
      bool hasMore = true;
      while (hasMore) {
        final results = await StarWarsApi.fetchPeople(page: page);
        print('Página $page: ${results.length} personajes'); // <-- Agrega esto
        if (results.isNotEmpty) {
          all.addAll(results);
          page++;
        } else {
          hasMore = false;
        }
      }
      setState(() {
        _allCharacters = all;
        _characters = all;
      });
    } catch (e) {
      setState(() {
        _characters = [];
        _allCharacters = [];
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Busca personajes por nombre usando la API (para resultados exactos)
  Future<void> _fetchCharactersBySearch(String search) async {
    setState(() => _isLoading = true);
    try {
      final results = await StarWarsApi.fetchPeople(search: search);
      setState(() {
        _characters = results;
      });
    } catch (e) {
      setState(() {
        _characters = [];
      });
    } finally {
      setState(() => _isLoading = false);
    }
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
                      if (_search.isEmpty) {
                        setState(() {
                          _characters = _allCharacters;
                        });
                      } else {
                        _fetchCharactersBySearch(_search);
                      }
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
                      padding: const EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: _characters.length,
                      itemBuilder: (context, index) {
                        final character = _characters[index];
                        final isFavorite = _favorites.any(
                          (fav) => fav['name'] == character['name'],
                        );
                        return StarWarsCard(
                          character: character,
                          isFavorite: isFavorite,
                          imageSize: imageSize,
                          onFavoriteTap: () => _toggleFavorite(character),
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
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}