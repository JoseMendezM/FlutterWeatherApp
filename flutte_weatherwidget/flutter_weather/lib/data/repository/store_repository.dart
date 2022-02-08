import 'package:flutter_weather/ui/cities/model/city.dart';

// Solid - Ayuda mucho al momento de testear
// Porque se trabaja en base a la interfaz?
//Usar una clase abstracta te perimte separar aun mas la logica de tu negocio y es mas facil testearlo
abstract class StoreRepository {
  Future<void> saveCity(City city);
  Future<List<City>>
      getCities(); //Future, como tiene que esperar a recibir la informacion se utiliza future. es un asyncrono
}
