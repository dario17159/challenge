import 'dart:convert';

class Owner {
  Owner({
    this.dni,
    required this.name,
    required this.lastname,
    required this.carsPatents,
  });

  int? dni;
  final String name;
  final String lastname;
  final List<String> carsPatents;

  factory Owner.fromJson(String str) => Owner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Owner.fromMap(Map<String, dynamic> json) => Owner(
        dni: json["dni"],
        name: json["name"],
        lastname: json["lastname"],
        carsPatents: List<String>.from(json["carsPatents"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "lastname": lastname,
        "carsPatents": List<dynamic>.from(carsPatents.map((x) => x)),
      };
}
