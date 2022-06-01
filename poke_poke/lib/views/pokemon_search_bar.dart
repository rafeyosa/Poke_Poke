import 'package:flutter/material.dart';

class PokemonSearchBar extends StatefulWidget {
  final Function(String) callback;

  const PokemonSearchBar({Key? key, required this.callback}) : super(key: key);
  @override
  _PokemonSearchBar createState() => _PokemonSearchBar();
}

class _PokemonSearchBar extends State<PokemonSearchBar> {
  final controller = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          onTap: (){
            setState(() {
              _isSearching = true;
            });
          },
          onChanged: (String search){
            if(search.isNotEmpty) {
              widget.callback(search);
            }
          },
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: _isSearching ?
                Icon(Icons.cancel, color: Colors.grey) :
                Icon(Icons.search, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    if(_isSearching) {
                      FocusScope.of(context).unfocus();
                      controller.clear();
                      _isSearching = false;
                      widget.callback("");
                    }
                  });
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}