import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/cities/add/add_city_page.dart';
import 'package:flutter_weather/ui/cities/model/city.dart';
import 'package:flutter_weather/ui/commom/header_widget.dart';
import 'package:flutter_weather/ui/ui_constants.dart';

import 'cities_bloc.dart';

class CitiesPage extends StatefulWidget {
  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  final bloc =
      CitiesBloc(); // para que este widget pueda escuchar los cambios necesitamosu

  @override
  void initState() //wiget para iniciar estados
  {
    //TODO: IMPLEMENT INITSTATE
    super.initState();
    bloc.loadCities();
  }

  void handleNavigateTap(BuildContext context) async {
    await Navigator.of(context).push(
      // Espera a que retorne la lista.
      PageRouteBuilder(
        //con el await esperamos la respuesta de la lista. Es decir, cuando agregamos un valor a la lista de ciudades. Esperamos la respuesta de la lista
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        pageBuilder: (_, animation1, animation2) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(animation1),
            child: AddCityPage(),
          );
        },
      ),
    );
    bloc.loadCities(); // aqui recargamos nuevamente la pantalla. Si hay un valor nuevo en la lista este se mostrara en pantalla // ocn el context podemos navegar a traves de pantallas
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation:
            bloc, // aqui va a escuchar al bloc si es que hay algun cambio
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: primaryColor,
              onPressed: () => handleNavigateTap(context),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const HeaderWidget(
                      title: "Mis Ciudades",
                    ),
                    Expanded(
                      child: bloc.cities.isEmpty
                          ? const Center(
                              child: const Text("No tengo ciudades :v"))
                          : ListView.builder(
                              itemCount: bloc.cities.length,
                              itemBuilder: (context, index) {
                                final city = bloc.cities[index];
                                return CityItem(
                                  city:
                                      city, // con el .toString forzamos la convercion
                                );
                              },
                            ),
                    )
                  ]),
            ),
          );
        });
  }
}

class CityItem extends StatelessWidget {
  final City city;
  const CityItem({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.grey[200],
        margin: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              city.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            InkWell(
              child: Icon(Icons.close),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
