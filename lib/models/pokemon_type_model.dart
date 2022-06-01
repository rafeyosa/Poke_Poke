import 'dart:convert';

import 'package:poke_poke/models/pokemon_data_model.dart';

class PokemonTypeModel {
  late int slot;
  late PokemonDataModel type;

  PokemonTypeModel({
    required this.slot,
    required this.type
  });

  PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = PokemonDataModel.fromJson(json["type"]);
  }
}

List<PokemonTypeModel> parsePokemonTypes(String? json) {
  if(json == null) {
    return [];
  }
  final data = jsonDecode(json);
  return List<PokemonTypeModel>.from(data["types"].map((x) => PokemonTypeModel.fromJson(x)));
}