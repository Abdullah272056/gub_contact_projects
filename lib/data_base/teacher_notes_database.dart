import 'package:flutter/material.dart';
import 'package:gub_contact/data_base/teacher_note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';



class TeacherNotesDataBase{

  static final TeacherNotesDataBase instance=TeacherNotesDataBase._init();
  static Database ?_database;
  TeacherNotesDataBase._init();

  Future<Database> get database async {

   if(_database !=null) return _database!;

   _database =await _initDB('teacher_notes.db');
   return _database!;

  }


  Future<Database> _initDB(String filePath) async {

   final dbPath =await getDatabasesPath();
   final path =join( dbPath, filePath);

   return await openDatabase(path, version: 1, onCreate: _createDB);

  }


  Future _createDB(Database db, int version) async{

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final textType = 'TEXT NOT NULL';
    final textType = 'TEXT';

    //
    //
    final String name;
    final String designation;
    final String department;
    final String primaryPhone;
    final String secondaryPhone;
    final String email;
    final String pbx;
    final String room;
    final String details;
    final String photo;
    final String userId;

    await db.execute('''
      CREATE TABLE $teacherTableNotes(
      ${TeacherNoteFields.id} $idType,
      ${TeacherNoteFields.name} $textType,
      ${TeacherNoteFields.designation} $textType,
      ${TeacherNoteFields.department} $textType,
      ${TeacherNoteFields.primaryPhone} $textType,
      ${TeacherNoteFields.secondaryPhone} $textType,
      ${TeacherNoteFields.email} $textType,
      ${TeacherNoteFields.pbx} $textType,
      ${TeacherNoteFields.room} $textType,
      ${TeacherNoteFields.details} $textType,
      ${TeacherNoteFields.photo} $textType,
      ${TeacherNoteFields.userId} $textType
      )
      '''
    );
  }

  Future<TeacherNote> create(TeacherNote note) async{
    final db = await instance.database;
    // _showToast("call");
    // final json =note.toJson();
    // final columns ='${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values ='${json[NoteFields.title]}, ${json[NoteFields.description]},'
    //     ' ${json[NoteFields.time]}';
    //
    // final id =await db.rawInsert( 'INSERT INTO table_name ($columns) VALUES ($values)');


    final id=await db.insert(teacherTableNotes, note.toJson());

    // _showToast("ok");

    return note.copy(id:id);
  }

  Future<TeacherNote> readNote(int id) async {
    final db =await instance.database;

    final maps =await db.query(
        teacherTableNotes,
      columns: TeacherNoteFields.values,
      where: '${TeacherNoteFields.id}= ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return TeacherNote.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<TeacherNote>> readAllNotes() async{
    final db =await instance.database;

    // final orderBy='${NoteFields.time} ASC';
    /// final result =await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result =await db.query(teacherTableNotes);

    return result.map((json) => TeacherNote.fromJson(json)).toList();

  }


  Future<int> update (TeacherNote note)async{
    final db =await instance.database;
    return db.update(
      teacherTableNotes,
        note.toJson(),
        where: '${TeacherNoteFields.id}=?',
      whereArgs: [note.id],
    );

  }

  Future<int> delete(int id)async{
    final db =await instance.database;
    return await db.delete(
      teacherTableNotes,
      where: '${TeacherNoteFields.id}=?',
      whereArgs: [id],
    );

  }

  deleteAll() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from $teacherTableNotes");
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