import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/item_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'empleadoDB.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE empleado(
          id INTEGER PRIMARY KEY,
          name TEXT,
          lastname TEXT,
          age INTEGER,
          birthdate TEXT,
          startdate TEXT,
          enddate TEXT
        );
      ''');
    });
  }

  Future<int> nuevoEmpleado(EmpleadoModel newEmployee) async {
    final db = await database;
    final res = await db.insert('empleado', newEmployee.toMap());
    // Es el ID del último registro insertado;
    return res;
  }

  Future<List<EmpleadoModel>> getAllEmpleados() async {
    final db = await database;
    final res = await db.query('empleado');
    final List<EmpleadoModel> data =
        res.isNotEmpty ? res.map((e) => EmpleadoModel.fromMap(e)).toList() : [];
    return data;
  }

  Future<int> updateEmpleado(EmpleadoModel nuevoScan) async {
    final db = await database;
    final res = await db.update('empleado', nuevoScan.toMap(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteEmpleado(int id) async {
    final db = await database;
    final res = await db.delete('empleado', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
