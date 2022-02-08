import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/cities/model/city.dart';

class WeathersWidget extends StatelessWidget {
  final List<City>? cities;

  const WeathersWidget({Key? key, this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: cities?.length,
      itemBuilder: (context, index) {
        final city = cities?[index];
        final weather = city?.weathers?.first;
        return Stack(
          children: [
            Image.asset(
              'assets/background_states/${weather?.weatherStateAbbr}.jpg',
            )
          ],
        );
      },
    );
  }
}
