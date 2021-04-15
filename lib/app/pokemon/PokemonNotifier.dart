import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vbee_app/app/model/Pokemon.dart';
import 'package:vbee_app/base/network/network_utils.dart';

class PokemonNotifier extends ValueNotifier<List<Pokemon>> {
  PokemonNotifier() : super(null);

  int _pageNumber = 1;
  bool _hasMorePokemon = true;
  int _batchesOf = 5;
  final String _apiUrl = 'https://pokeapi.co/api/v2/pokemon/';
  List<Pokemon> _listPokemons;
  bool _loading = false;

  @override
  List<Pokemon> get value => _value;
  List<Pokemon> _value;

  @override
  set value(List<Pokemon> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload() async {
    _listPokemons = <Pokemon>[];
    _pageNumber = 1;
    await httpGetPokemon(_pageNumber);
  }

  Future<void> getMore() async {
    if (_hasMorePokemon && !_loading) {
      _loading = true;
      await httpGetPokemon(_pageNumber);
      _loading = false;
    }
  }

  Future<void> httpGetPokemon(int page) async {
    _listPokemons ??= <Pokemon>[];
    int pageNumber = page;
    while (_hasMorePokemon && (pageNumber - page) < _batchesOf) {
      var url = _apiUrl + (pageNumber).toString();
      var response = await Dio().get(url);
      print("reponse: " + response.data.toString());
      Map<String, dynamic> jsonDecoded = json.decode(response.toString());
      jsonDecoded != null
          ? _listPokemons.add(Pokemon.fromJson(jsonDecoded))
          : _hasMorePokemon = false;
      pageNumber++;
    }

    _pageNumber = pageNumber;
    value = _listPokemons;
  }
}
