import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/cities/cities_bloc.dart';
import 'package:flutter_weather/ui/cities/cities_page.dart';
import 'package:flutter_weather/ui/cities/home/empty_screen.dart';
import 'package:flutter_weather/ui/cities/home/weathers_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //CREANDO EL METODO PARA LLAMAR A LA OTRA PAGINA
  final bloc = CitiesBloc();

  void handleNavigateTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            CitiesPage())); // ocn el context podemos navegar a traves de pantallas
  }

  void initState() {
    bloc.loadCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
            body: bloc.cities.isEmpty
                ? EmptyWidget(
                    onTap: () => handleNavigateTap(context),
                  )
                : WeathersWidget(cities: bloc.cities));
      },
    );
  }
}
