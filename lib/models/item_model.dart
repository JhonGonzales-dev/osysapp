import 'dart:convert';

class EmpleadoModel {
  EmpleadoModel({
    this.id,
    required this.name,
    required this.lastName,
    required this.age,
    required this.birthDate,
    required this.startDate,
    required this.endDate,
  });

  int? id;
  String name;
  String lastName;
  int age;
  String birthDate;
  String startDate;
  String endDate;

  factory EmpleadoModel.fromJson(String str) =>
      EmpleadoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmpleadoModel.fromMap(Map<String, dynamic> json) => EmpleadoModel(
        id: json["id"],
        name: json["name"],
        lastName: json["lastname"],
        age: json["age"],
        birthDate: json["birthdate"],
        startDate: json["startdate"],
        endDate: json["enddate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lastname": lastName,
        "age": age,
        "birthdate": birthDate,
        "startdate": startDate,
        "enddate": endDate,
      };
}
