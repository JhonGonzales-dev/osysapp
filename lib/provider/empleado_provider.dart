import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/item_model.dart';
import 'db_service.dart';
import 'navigation_service.dart';

enum EmpleadoStatus { empty, checking, loaded, error }

class EmpleadoProvider extends ChangeNotifier {
  EmpleadoStatus status = EmpleadoStatus.empty;
  String differenceDays = '0';
  List<EmpleadoModel> empleados = [];

//............CREATE EMPLOYEE.................................
  Future<void> createEmpleado(String name, String lastname, int age,
      String birthDate, String startDate, String enddate) async {
    status = EmpleadoStatus.checking;
    notifyListeners();

    var body = jsonEncode({
      "name": name,
      "lastname": lastname,
      "age": age,
      "birthdate": birthDate,
      "startdate": startDate,
      "enddate": enddate
    });
    try {
      var nuevoempleado = EmpleadoModel.fromJson(body);

      await DBProvider.db.nuevoEmpleado(nuevoempleado);
      empleados.add(nuevoempleado);
      status = EmpleadoStatus.loaded;
      notifyListeners();

      await _customsnackBar("Datos guardados");
    } catch (e) {
      status = EmpleadoStatus.error;
      notifyListeners();
    }
  }

  //............GET EMPLOYEE.................................

  Future<void> cargarEmpleados() async {
    status = EmpleadoStatus.checking;
    notifyListeners();

    try {
      final scans = await DBProvider.db.getAllEmpleados();
      empleados = [...scans];
      status = EmpleadoStatus.loaded;
      notifyListeners();
    } catch (e) {
      status = EmpleadoStatus.error;
      notifyListeners();
    }
  }

  //............UPDATE EMPLOYEE.................................

  Future<void> updatePorId(int id, String name, String lastname, int age,
      String birthDate, String startDate, String enddate) async {
    status = EmpleadoStatus.checking;
    notifyListeners();

    var body = jsonEncode({
      "id": id,
      "name": name,
      "lastname": lastname,
      "age": age,
      "birthdate": birthDate,
      "startdate": startDate,
      "enddate": enddate
    });

    try {
      var nuevoempleado = EmpleadoModel.fromJson(body);
      await DBProvider.db.updateEmpleado(nuevoempleado);

      status = EmpleadoStatus.loaded;
      notifyListeners();

      await _customsnackBar("Datos actualizados");
    } catch (e) {
      status = EmpleadoStatus.error;
      notifyListeners();
    }
  }

//............DELETE EMPLOYEE.................................

  Future<void> borrarEmpleadoId(int id) async {
    status = EmpleadoStatus.checking;
    notifyListeners();

    try {
      await DBProvider.db.deleteEmpleado(id);
      status = EmpleadoStatus.loaded;
      notifyListeners();
      await _customsnackBar("empleado eliminado");
    } catch (e) {
      status = EmpleadoStatus.error;
      notifyListeners();
    }
  }

  Future<void> _customsnackBar(String text) async {
    var navigatorKey = NavigationService.navigatorKey;
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showSnackBar(SnackBar(content: Text(text)));

    await cargarEmpleados();
    NavigationService.popTo();
  }

  void calculatedays(endate) {
    DateTime today = DateTime.now();
    String enddatework = endate;
    var endDate = DateFormat('d/M/y').parse(enddatework);
    Duration diastotales = endDate.difference(today);

    differenceDays = diastotales.inDays.toString();
    notifyListeners();
  }
}
