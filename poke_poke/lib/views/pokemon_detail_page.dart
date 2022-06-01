import 'package:flutter/material.dart';
import 'package:poke_poke/models/pokemon_detail_model.dart';
import 'package:poke_poke/utils/extention.dart';

import '../models/pokemon_stat_model.dart';
import '../services/api_services.dart';
import '../utils/constants.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key, required this.id}) : super(key: key);
  static const routeName = '/pokemon_detail';

  final int id;

  @override
  _PokemonDetailPage createState() => _PokemonDetailPage();
}

class _PokemonDetailPage extends State<PokemonDetailPage> {
  PokemonDetailModel? _pokemon;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _pokemon = (await ApiServices().getPokemon(widget.id));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    print(_pokemon?.stats.length);
    return Scaffold(
      appBar: AppBar(
      title: _pokemon == null ? Text("Pokemon") : Text(_pokemon!.name.capitalize())
      ),
      body: _pokemon == null || _pokemon!.stats.isEmpty || _pokemon!.types.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      ) : Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.network(
              Constants.baseImageUrl+widget.id.toString()+Constants.formatPNG,
              width: 200,
              errorBuilder: (context,  error , stackTrace) {
                return Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.error, color: Colors.amber, size: 200)
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: Colors.grey)
            ),
            Text(
              "Name : "+_pokemon!.name.capitalize(),
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(height: 15),
            Text(
              "${_pokemon!.stats[0].stat.name.capitalize()} : ${_pokemon!.stats[0].baseStat}",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,//_pokemon!.stats.length,
                itemBuilder: (context, index) {
                  return _buildStats(context, _pokemon!.stats[index]);
                }
              )
            ),
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 30,
              bottom: 20,
              child: widget.id != 1 ?
              FloatingActionButton(
                heroTag: 'back',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, PokemonDetailPage.routeName, arguments: widget.id-1);
                },
                child: const Icon(
                  Icons.arrow_left,
                  size: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ) :
              FloatingActionButton(
                backgroundColor: Colors.grey,
                heroTag: 'back',
                onPressed: () {},
                child: const Icon(
                  Icons.arrow_left,
                  size: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                heroTag: 'next',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, PokemonDetailPage.routeName, arguments: widget.id+1);
                },
                child: const Icon(
                  Icons.arrow_right,
                  size: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ),
          ],
        ),
    );
  }

  Widget _buildStats(BuildContext context, PokemonStatModel stats) {
    return Column(
      children: [
        SizedBox(height: 15),
        Text(
          "${stats.stat.name.capitalize()} : ${stats.baseStat}",
          style: TextStyle(
              fontSize: 20
          ),
        ),
      ],
    );
  }
}