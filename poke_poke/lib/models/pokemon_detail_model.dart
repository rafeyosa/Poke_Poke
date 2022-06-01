import 'dart:convert';

import 'package:poke_poke/models/pokemon_stat_model.dart';
import 'package:poke_poke/models/pokemon_type_model.dart';

class PokemonDetailModel {
  late int id;
  late String name;
  late List<PokemonStatModel> stats;
  late List<PokemonTypeModel> types;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.stats,
    required this.types
  });

  PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stats = parsePokemonStats(jsonEncode(json));
    types = parsePokemonTypes(jsonEncode(json));
  }
}

PokemonDetailModel? parsePokemonDetail(String? json) {
  if(json == null) {
    return null;
  }
  final data = jsonDecode(json);
  return PokemonDetailModel.fromJson(data);
}