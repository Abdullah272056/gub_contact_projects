// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path/path.dart';
//
// import 'note.dart';
//
//
// class NotesDataBase{
//
//   static final NotesDataBase instance=NotesDataBase._init();
//   static Database ?_database;
//   NotesDataBase._init();
//
//   Future<Database> get database async {
//
//    if(_database !=null) return _database!;
//
//    _database =await _initDB('notes.db');
//    return _database!;
//
//   }
//
//
//   Future<Database> _initDB(String filePath) async {
//
//    final dbPath =await getDatabasesPath();
//    final path =join( dbPath, filePath);
//
//    return await openDatabase(path, version: 3, onCreate: _createDB);
//
//   }
//
//
//   Future _createDB(Database db, int version) async{
//
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     // final textType = 'TEXT NOT NULL';
//     final textType = 'TEXT';
//
//     //
//     //
//     // final String name;
//     // final String designation;
//     // final String department;
//     // final String primaryPhone;
//     // final String secondaryPhone;
//     // final String email;
//     // final String pbx;
//     // final String room;
//     // final String details;
//     // final String photo;
//     // final String userId;
//
//     await db.execute('''
//       CREATE TABLE $tableNotes(
//       ${NoteFields.id} $idType,
//       ${NoteFields.name} $textType,
//       ${NoteFields.designation} $textType,
//       ${NoteFields.department} $textType,
//       ${NoteFields.primaryPhone} $textType,
//       ${NoteFields.secondaryPhone} $textType,
//       ${NoteFields.email} $textType,
//       ${NoteFields.pbx} $textType,
//       ${NoteFields.room} $textType,
//       ${NoteFields.details} $textType,
//       ${NoteFields.photo} $textType,
//       ${NoteFields.userId} $textType
//       )
//       '''
//     );
//   }
//
//   Future<Note> create(Note note) async{
//     final db = await instance.database;
//     // _showToast("call");
//     // final json =note.toJson();
//     // final columns ='${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values ='${json[NoteFields.title]}, ${json[NoteFields.description]},'
//     //     ' ${json[NoteFields.time]}';
//     //
//     // final id =await db.rawInsert( 'INSERT INTO table_name ($columns) VALUES ($values)');
//
//
//     final id=await db.insert(tableNotes, note.toJson());
//
//     _showToast("ok");
//
//     return note.copy(id:id);
//   }
//
//   Future<Note> readNote(int id) async {
//     final db =await instance.database;
//
//     final maps =await db.query(
//       tableNotes,
//       columns: NoteFields.values,
//       where: '${NoteFields.id}= ?',
//       whereArgs: [id]
//     );
//
//     if(maps.isNotEmpty){
//       return Note.fromJson(maps.first);
//     }else{
//       throw Exception('ID $id not found');
//     }
//
//   }
//
//
//   Future<List<Note>> readAllNotes() async{
//     final db =await instance.database;
//
//     // final orderBy='${NoteFields.time} ASC';
//     /// final result =await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
//
//     final result =await db.query(tableNotes);
//
//     return result.map((json) => Note.fromJson(json)).toList();
//
//   }
//
//
//   Future<int> update (Note note)async{
//     final db =await instance.database;
//     return db.update(
//         tableNotes,
//         note.toJson(),
//         where: '${NoteFields.id}=?',
//       whereArgs: [note.id],
//     );
//
//   }
//
//   Future<int> delete(int id)async{
//     final db =await instance.database;
//     return await db.delete(
//         tableNotes,
//       where: '${NoteFields.id}=?',
//       whereArgs: [id],
//     );
//
//   }
//
//   deleteAll() async {
//     Database db = await instance.database;
//     return await db.rawDelete("Delete from $tableNotes");
//   }
//
//
//
//   Future close() async{
//   final db = await instance.database;
//   db.close();
//
//
//   }
//
//   _showToast(String message) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//  }