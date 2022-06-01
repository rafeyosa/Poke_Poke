import 'dart:developer';

import 'package:poke_poke/models/pokemon_data_model.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon_detail_model.dart';
import 'api_constants.dart';

class ApiServices {
  Future<List<PokemonDataModel>?> getPokemonData() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getPokemonAllEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<PokemonDataModel> model = parsePokemonData(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<PokemonDetailModel?> getPokemon(int id) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getPokemonEndpoint}/${id.toString()}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        PokemonDetailModel? model = parsePokemonDetail(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}