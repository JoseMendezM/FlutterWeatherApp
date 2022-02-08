import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/data/repository/store_impl.dart';
import 'package:flutter_weather/data/repository/store_repository.dart';

import 'model/city.dart';

class CitiesBloc extends ChangeNotifier {
  List<City> cities = [];
  final StoreRepository storage = StoreImpl();

  void loadCities() async {
    cities = await storage.getCities(); //
    notifyListeners(); //Necesito escuchar que ya tengo elementos en mi array
  }
}
