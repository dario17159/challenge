import 'dart:convert';

class Service {
  Service({
    this.idService,
    required this.type,
    required this.price,
    this.isSelected = false,
  });

  String? idService;
  final String type;
  final double price;
  bool isSelected;

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        type: json["type"],
        price: json['price'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}
