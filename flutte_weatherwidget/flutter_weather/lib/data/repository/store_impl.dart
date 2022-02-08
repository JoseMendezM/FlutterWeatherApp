import 'dart:convert';

import 'package:flutter_weather/data/repository/store_repository.dart';
import 'package:flutter_weather/ui/cities/model/city.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyCities = "cities";

class StoreImpl extends StoreRepository {
  @override
  Future<List<City>> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //El preferences permite guardar un listado de strings
    // se va a codificar antes de guadarlo como string. le paso un json string se decodifica y ya se tienen los objetos. aqui se decodifica el JsonString
    final list = prefs.getStringList(keyCities);
    if (list != null && list.isNotEmpty) {
      // en el if se verifica que la lista sea diferente de nulo y que no este vacia
      final cities = list
          .map(
            (e) => City.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
      return cities;
    }
    return <
        City>[]; // si es que no hay ningun elemento se retorna un array vacio
  }

//
  @override
  Future<void> saveCity(City city) async {
    //aqui se hace la verificacion de si la ciudad elegida ya existe

    //final list = (await getCities()) ?? <City>[];

    final list = (await getCities()); // Espera la lista con las ciudadesS

    list.add(city); // en caso de no ser asi. se agrega la ciudad a la lista
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        keyCities, list.map((e) => jsonEncode(e.toJson())).toList());
  }
}
