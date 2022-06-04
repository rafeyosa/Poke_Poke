import 'package:flutter/material.dart';
import 'package:poke_poke/models/pokemon_data_model.dart';
import 'package:poke_poke/views/pokemon_item.dart';
import 'package:poke_poke/views/pokemon_search_bar.dart';

import '../services/api_services.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);
  static const routeName = '/pokemon_list';

  @override
  _PokemonListPage createState() => _PokemonListPage();
}

class _PokemonListPage extends State<PokemonListPage> {
  late List<PokemonDataModel>? _pokemonDataList = [];
  int _maxPage = 0;
  int _page = 0;
  final int _limitPage  = 10;
  bool _isSearching = false;

  List<PokemonDataModel> _items = <PokemonDataModel>[];
  List<PokemonDataModel> _searchItems = <PokemonDataModel>[];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _pokemonDataList = (await ApiServices().getPokemonData())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      _getPokemonData();
      _maxPage = _pokemonDataList!.length;
    }));
  }

  void _getPokemonData() {
    _items.addAll(_pokemonDataList!.getRange(_page, _page + _limitPage));
    _page += _limitPage;
  }

  List<PokemonDataModel> _filterPokemonByName(String search) {
    List<PokemonDataModel> filter = [];
    filter.addAll(_pokemonDataList!);

    filter.retainWhere((poke) {
      var a = poke.name;
      return a.toLowerCase().contains(search.toLowerCase());
    });

    return filter;
  }

  void _showMoreData() {
    if((_page + _limitPage) > _pokemonDataList!.length) {
      _items.addAll(
          _pokemonDataList!.getRange(_page, _pokemonDataList!.length));
    } else {
      _items.addAll(
          _pokemonDataList!.getRange(_page, _page + _limitPage));
    }
    _page = _page + _limitPage;
  }

  void _searchPokemon(String search) {
    if(search != null || search.isNotEmpty) {
      _searchItems = _filterPokemonByName(search);
      _isSearching = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PokemonSearchBar(
            callback:(search)=> setState((){
              if(search.isEmpty) {
                _isSearching = false;
              } else {
                _searchPokemon(search);
              }
            })
        )
      ),
      body: _pokemonDataList == null || _pokemonDataList!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ) : GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        itemCount: _isSearching? _searchItems.length : _items.length,
        itemBuilder: (BuildContext ctx, index) {
          return PokemonItem(num: index+1, pokemon: _isSearching? _searchItems[index] : _pokemonDataList![index], maxPokemon: _maxPage);
        }
      ),
      floatingActionButton: _isSearching == true ?
        Container() : FloatingActionButton.extended(
        icon: const Icon(Icons.more_horiz),
        label: const Text('Load More'),
        onPressed: () {
          setState(() {
            _showMoreData();
          });
        },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
