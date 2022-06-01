import 'dart:convert';

import 'package:poke_poke/models/pokemon_data_model.dart';

class PokemonStatModel {
  late int baseStat;
  late int effort;
  late PokemonDataModel stat;

  PokemonStatModel({
    required this.baseStat,
    required this.effort,
    required this.stat
  });

  PokemonStatModel.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = PokemonDataModel.fromJson(json["stat"]);
  }
}

List<PokemonStatModel> parsePokemonStats(String? json) {
  if(json == null) {
    return [];
  }
  final data = jsonDecode(json);
  return List<PokemonStatModel>.from(data["stats"].map((x) => PokemonStatModel.fromJson(x)));
}