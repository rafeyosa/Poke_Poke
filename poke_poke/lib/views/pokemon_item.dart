import 'package:flutter/material.dart';
import 'package:poke_poke/models/pokemon_data_model.dart';
import 'package:poke_poke/utils/extention.dart';
import 'package:poke_poke/views/pokemon_detail_page.dart';
import '../utils/constants.dart';

class PokemonItem extends StatelessWidget {
  final int num;
  final PokemonDataModel pokemon;
  final int maxPokemon;
  String id = "";

  PokemonItem({required this.num, required this.pokemon, required this.maxPokemon});

  Widget build(BuildContext context) {
    id = pokemon.url.substringByUrl(Constants.pokemonUrl);
    return GridTile(
      child: InkResponse(
        onTap: () {
          Navigator.pushNamed(context, PokemonDetailPage.routeName, arguments: id.isEmpty? num : int.parse(id));
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                id.isEmpty ? Constants.baseImageUrl+num.toString()+Constants.formatPNG :
                Constants.baseImageUrl+id+Constants.formatPNG,
                width: 100,
                errorBuilder: (context,  error , stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.error, color: Colors.amber, size: 100)
                  );
                },
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    num.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    pokemon.name.capitalize(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        )
      )
    );
  }
}