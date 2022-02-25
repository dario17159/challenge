
import 'dart:convert';

import 'package:pickit_challenge/domain/models/car.dart';
import 'package:pickit_challenge/domain/models/owner.dart';

class CarsOfOwner {
    CarsOfOwner({
        required this.cars,
        required this.owner,
    });

    final List<Car> cars;
    final Owner owner;

    factory CarsOfOwner.fromJson(String str) => CarsOfOwner.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CarsOfOwner.fromMap(Map<String, dynamic> json) => CarsOfOwner(
        cars: List<Car>.from(json["cars"].map((x) => Car.fromMap(x))),
        owner: Owner.fromMap(json["owner"]),
    );

    Map<String, dynamic> toMap() => {
        "cars": List<dynamic>.from(cars.map((x) => x.toMap())),
        "owner": owner.toMap(),
    };
}

