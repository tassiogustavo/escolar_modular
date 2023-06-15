import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //classe definida como singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  Database? db;

  Future<Database> get database async {
    if (db != null) return db!;
    db = await _initDatabase();
    return db!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'teste_pratico.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('CREATE TABLE cursos (codigo INTEGER PRIMARY KEY, descricao TEXT, ementa TEXT)');
    await db.execute('CREATE TABLE alunos (codigo INTEGER PRIMARY KEY, nome TEXT)');
    await db.execute(
        'CREATE TABLE curso_aluno (codigo INTEGER PRIMARY KEY, codigo_curso INTEGER, codigo_aluno INTEGER, FOREIGN KEY(codigo_curso) REFERENCES cursos(codigo), FOREIGN KEY(codigo_aluno) REFERENCES alunos(codigo))');
  }
}
