import 'package:flutter/material.dart';
import 'package:poke_poke/views/pokemon_detail_page.dart';
import 'package:poke_poke/views/pokemon_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: PokemonListPage.routeName,
      routes: {
        PokemonListPage.routeName: (context) => PokemonListPage(),
        PokemonDetailPage.routeName: (context) => PokemonDetailPage(
            id: ModalRoute.of(context)?.settings.arguments as int
        )
      },
    );
  }
}

