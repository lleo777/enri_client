// To parse this JSON data, do
//
//     final registroCoordenadas = registroCoordenadasFromJson(jsonString);

import 'dart:convert';

RegistroCoordenadas registroCoordenadasFromJson(String str) => RegistroCoordenadas.fromJson(json.decode(str));

String registroCoordenadasToJson(RegistroCoordenadas data) => json.encode(data.toJson());

/**
 * A geographical coordinate
 */
class RegistroCoordenadas {
    RegistroCoordenadas({
        this.latitude,
        this.longitude,
    });

    double latitude;
    double longitude;

    factory RegistroCoordenadas.fromJson(Map<String, dynamic> json) => RegistroCoordenadas(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
    };
}
