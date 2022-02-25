import 'dart:convert';

class Car {
  Car({
    required this.brand,
    required this.model,
    required this.year,
    required this.patent,
    required this.color,
    required this.ownerId,
    required this.servicesId,
  });

  final String brand;
  final String model;
  final int year;
  final String patent;
  final String color;
  final String ownerId;
  final List<String> servicesId;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        patent: json["patent"],
        color: json["color"],
        ownerId: json["ownerId"],
        servicesId: List<String>.from(json["servicesId"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "year": year,
        "patent": patent,
        "color": color,
        "ownerId": ownerId,
        "servicesId": List<dynamic>.from(servicesId.map((x) => x)),
      };
}
