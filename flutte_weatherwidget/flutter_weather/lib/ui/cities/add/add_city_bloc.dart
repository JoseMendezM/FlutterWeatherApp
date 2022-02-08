import 'dart:convert' show jsonDecode;
import 'package:flutter_weather/data/repository/store_impl.dart';
import 'package:flutter_weather/data/repository/store_repository.dart';
import 'package:flutter_weather/ui/cities/model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/data/data_constants.dart';
import 'package:flutter_weather/ui/cities/model/city.dart';
import 'package:flutter_weather/ui/commom/debouncer.dart';

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer(); //instancia
  final StoreRepository storage = StoreImpl();
  late List<City> cities = [];
  bool loading = false;
  String? errorMessage;
  get text => null;

  void onChangedText(String text) {
    debouncer.run(() {
      if (text.isNotEmpty) {
        requestSearch(text);
      } // Para evitar que haga busquedas cuando se borra
    });
  }

  // en esta funcion se realiza la busqueda de la ciudad y traemos los datos proporcionados por el API
  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    final url = '${api}search/?query=$text';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body) as List;

    //loading = false;
    // cities = [City(title: 'Lima', id: 123)];

    loading = false;
    cities = data.map((e) => City.fromJson(e)).toList();

    notifyListeners();

    //cities = [City(title: 'Lima', id: 123)];

    // contiene un listado de ciudades
    print(data);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();

    // ignore: todo
    //TODO: CONSULTAR SI ESTA PERSISTIENDO ES DECIR SI LA CIUDAD QUE SE BUSCO YA SE ENCUENTRA AGREGADA PARA NO REPETIR.
    final url =
        '$api${city.id}'; //Llenamos la busqueda de nuestro API con la ciudad seleceionada.
    final response = await http.get(Uri.parse(url)); //
    final data = jsonDecode(response
        .body); //decodificamos la informacion obtenida en un objeto jsonDecode
    final weatherData = data['consolidated_weather']
        as List; //Aqui recogemos la informacion de la ciudad seleccionada
    //print(weatherData);
    final weathers = weatherData
        .map((e) => Weather.fromJson(data))
        .toList(); //Aqui se envian los valores del clima de la ciudad seleccionada a nuestra clase o archivo weather
    print("weathers: ${weathers.length}");
    final newCity = city.fromWeathers(weathers);

    try {
      await storage.saveCity(newCity);
      errorMessage = null;
      return true;
      //print(data); //cambie esta linea 05/02
    } on Exception catch (ex) {
      errorMessage = ex.toString();
      loading = false;
      notifyListeners();
      return false; //el error se convierte en string y se asigna
    }
  }
}
