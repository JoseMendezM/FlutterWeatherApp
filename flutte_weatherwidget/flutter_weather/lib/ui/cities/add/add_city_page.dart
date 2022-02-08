import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/cities/add/add_city_bloc.dart';
import 'package:flutter_weather/ui/cities/model/city.dart';
import 'package:flutter_weather/ui/commom/header_widget.dart';
import 'package:flutter_weather/ui/commom/loader_widget.dart';
import 'package:flutter_weather/ui/ui_constants.dart';

class AddCityPage extends StatefulWidget {
  @override
  State<AddCityPage> createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  final bloc = AddCityBloc();

  void handleAddTap(City city) async {
    final result = await bloc.addCity(city);
    if (result) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc, // animatedbuilder esta escuchando los cambios del bloc
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HeaderWidget(
                    title: "Agregar Ciudad",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextField(
                      onChanged: bloc.onChangedText,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          hintText: 'Buscar ciudad',
                          fillColor: Colors.grey[200],
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          )
                          //fillColor: Colors.grey[300],
                          ),
                    ),
                  ),
                  if (bloc.errorMessage != null)
                    Text(
                      bloc.errorMessage.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bloc.cities.length,
                      itemBuilder: (context, index) {
                        final city = bloc.cities[index];
                        return ListTile(
                          title: Text(
                            city.title.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                handleAddTap(city);
                              }),
                        );
                      },
                    ),
                  ),
                  if (bloc.loading)
                    Center(
                      child: LoaderWidget(),
                    )
                ]),
          ),
        );
      },
    );
  }
}
