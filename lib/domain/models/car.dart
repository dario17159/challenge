import 'dart:convert';

class Car {
  Car({
    required this.brand,
    required this.model,
    required this.year,
    this.patent,
    required this.color,
    required this.ownerId,
    this.servicesId,
  });

  final String brand;
  final String model;
  final int year;
  String? patent;
  final String color;
  final String ownerId;
  final List<String>? servicesId;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        patent: json["patent"],
        color: json["color"],
        ownerId: json["ownerId"],
        servicesId: json["servicesId"] != null
            ? List<String>.from(json["servicesId"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "year": year,
        "color": color,
        "ownerId": ownerId,
        "servicesId": servicesId != null
            ? List<dynamic>.from(servicesId!.map((x) => x))
            : [],
      };
}
