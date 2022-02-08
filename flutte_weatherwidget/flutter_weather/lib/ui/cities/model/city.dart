import 'package:flutter_weather/ui/cities/model/weather.dart';

class City {
  final String? title;
  final int? id;
  final List<Weather>? weathers;

  City({
    this.title,
    this.id,
    this.weathers,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "woeid": id,
        "weathers":
            weathers?.map((e) => e.toJson()).toList(), //retorna una lista
      };

  factory City.fromJson(Map<String, dynamic> map) {
    final myWeathers = map['weathers'];

    return City(
      id: map['woeid'],
      title: map["title"],
      weathers: myWeathers != null
          ? (map['weathers'] as List).map((e) => Weather.fromJson(e)).toList()
          : null,
    );
    // Aqui se hizo una verificacion, debido a que al inicio, cuando buscamos la ciudad, la seleccionamos y agregamos. Esta todavia no tiene todos los datos del clima o datos declarados, por lo tanto, no arroja un error de tipo null. Ya que al agregar la ciudad la instruccion espera que lleguen todos los datos y unicamente esta recibiendo el nombre
  }

  City fromWeathers(List<Weather> weathers) {
    return City(id: id, title: title, weathers: weathers);
  }
}
