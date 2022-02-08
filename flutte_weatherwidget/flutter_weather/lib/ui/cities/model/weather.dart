/// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    this.id,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.windDirectionCompass,
    this.created,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.windDirection,
    this.airPressure,
    this.humidity,
    this.visibility,
    this.predictability,
  });

  int? id;
  String? weatherStateName;
  String? weatherStateAbbr;
  String? windDirectionCompass;
  DateTime? created;
  DateTime? applicableDate;
  double? minTemp;
  double? maxTemp;
  double? theTemp;
  double? windSpeed;
  double? windDirection;
  int? airPressure;
  int? humidity;
  double? visibility;
  int? predictability;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? null,
        weatherStateName: json["weather_state_name"] == null
            ? null
            : json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"] ??
            "t", //!= null ? json["weatherStateAbbr"] : "",
        windDirectionCompass: json["wind_direction_compass"] == null
            ? null
            : json["wind_direction_compass"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        applicableDate: json["applicable_date"] == null
            ? null
            : DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"] == null ? null : json["min_temp"].toDouble(),
        maxTemp: json["max_temp"] == null ? null : json["max_temp"].toDouble(),
        theTemp: json["the_temp"] == null ? null : json["the_temp"].toDouble(),
        windSpeed:
            json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"] == null
            ? null
            : json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"] == null ? null : json["air_pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        visibility:
            json["visibility"] == null ? null : json["visibility"].toDouble(),
        predictability:
            json["predictability"] == null ? null : json["predictability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "weather_state_name":
            weatherStateName == null ? null : weatherStateName,
        "weather_state_abbr":
            weatherStateAbbr == null ? null : weatherStateAbbr,
        "wind_direction_compass":
            windDirectionCompass == null ? null : windDirectionCompass,
        "created": created == null ? null : created?.toIso8601String(),
        "applicable_date": applicableDate == null
            ? null
            : "${applicableDate?.year.toString().padLeft(4, '0')}-${applicableDate?.month.toString().padLeft(2, '0')}-${applicableDate?.day.toString().padLeft(2, '0')}",
        "min_temp": minTemp == null ? null : minTemp,
        "max_temp": maxTemp == null ? null : maxTemp,
        "the_temp": theTemp == null ? null : theTemp,
        "wind_speed": windSpeed == null ? null : windSpeed,
        "wind_direction": windDirection == null ? null : windDirection,
        "air_pressure": airPressure == null ? null : airPressure,
        "humidity": humidity == null ? null : humidity,
        "visibility": visibility == null ? null : visibility,
        "predictability": predictability == null ? null : predictability,
      };
}
