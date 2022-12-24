import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

import 'department_note.dart';
import 'note.dart';


class DepartmentDataBase{

  static final DepartmentDataBase instance=DepartmentDataBase._init();
  static Database ?_database;
  DepartmentDataBase._init();

  Future<Database> get database async {

   if(_database !=null) return _database!;

   _database =await _initDB('department_notes.db');
   return _database!;

  }


  Future<Database> _initDB(String filePath) async {

   final dbPath =await getDatabasesPath();
   final path =join( dbPath, filePath);

   return await openDatabase(path, version: 2, onCreate: _createDB);

  }


  Future _createDB(Database db, int version) async{

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final textType = 'TEXT NOT NULL';
    final textType = 'TEXT';



    final String departmentName;



    await db.execute('''
      CREATE TABLE $tableNotesDepartment(
      ${DepartmentNoteFields.id} $idType,
      ${DepartmentNoteFields.departmentName} $textType
      )
      '''
    );
  }

  Future<DepartmentNote> create(DepartmentNote note) async{
    final db = await instance.database;
    final id=await db.insert(tableNotesDepartment, note.toJson());

    // _showToast("ok");

    return note.copy(id:id);
  }

  Future<DepartmentNote> readNote(int id) async {
    final db =await instance.database;

    final maps =await db.query(
      tableNotesDepartment,
      columns: NoteFields.values,
      where: '${NoteFields.id}= ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return DepartmentNote.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<DepartmentNote>> readAllNotes() async{
    final db =await instance.database;

    // final orderBy='${NoteFields.time} ASC';
    /// final result =await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result =await db.query(tableNotesDepartment);

    return result.map((json) => DepartmentNote.fromJson(json)).toList();

  }


  Future<int> update (DepartmentNote note)async{
    final db =await instance.database;
    return db.update(
        tableNotesDepartment,
        note.toJson(),
        where: '${DepartmentNoteFields.id}=?',
      whereArgs: [note.id],
    );

  }

  Future<int> delete(int id)async{
    final db =await instance.database;
    return await db.delete(
      tableNotesDepartment,
      where: '${DepartmentNoteFields.id}=?',
      whereArgs: [id],
    );

  }

  deleteAll() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from $tableNotesDepartment");
  }



  Future close() async{
  final db = await instance.database;
  db.close();


  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

 }