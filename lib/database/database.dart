import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../student.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String studentTable = 'student_table';
  String colId = 'id';
  String colName = 'name';
  String colAge = 'age';
  String colCourse = 'course';
  String colProfilePic = 'profilePic';
  String colPhone = 'Phone';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'students.db');
    final studentsDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return studentsDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $studentTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colAge INTEGER, $colCourse TEXT, $colProfilePic TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(studentTable);
    return result;
  }

  Future<int> insertStudent(Student student) async {
    Database? db = await this.db;
    final int result = await db!.insert(studentTable, student.toMap());
    return result;
  }

  Future<int> updateStudent(Student student) async {
    Database? db = await this.db;
    final int result = await db!.update(
      studentTable,
      student.toMap(),
      where: '$colId = ?',
      whereArgs: [student.id],
    );
    return result;
  }

  Future<int> deleteStudent(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      studentTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<List<Student>> getStudentList() async {
    final List<Map<String, dynamic>> studentMapList = await getStudentMapList();
    final List<Student> studentList = [];
    studentMapList.forEach((studentMap) {
      studentList.add(Student.fromMap(studentMap));
    });
    return studentList;
  }
}
