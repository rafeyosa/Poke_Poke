import 'dart:convert';

class PokemonDataModel {
  late String name;
  late String url;

  PokemonDataModel({
    required this.name,
    required this.url
  });

  PokemonDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

List<PokemonDataModel> parsePokemonData(String? json) {
  if(json == null) {
    return [];
  }
  final data = jsonDecode(json);
  return List<PokemonDataModel>.from(data["results"].map((x) => PokemonDataModel.fromJson(x)));
}