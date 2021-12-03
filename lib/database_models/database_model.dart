import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

class DatabaseConnect {
  Database? _database;
  // creating a getter and open a connection to a database
  Future<Database> get database async {
    // location of our database n device
    final databasePath = await getDatabasesPath();
    const databaseName = 'filepath.db';
    // joins the dbpath and dbName and create a full path for database
    final path = join(databasePath, databaseName);
    _database = await openDatabase(path, version: 1, onCreate: _createDb);
    // create database function
    return _database!;
  }
  // create database function
// create table in our database
  Future<void> _createDb(Database db, int version) async {
    // making sure the model field matches column in the database
    await db.execute('''
       CREATE TABLE filepath(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       file TEXT
           )
   ''');
  }

  // function to add data into the database
  Future<void> insertFilePath(Filepath filepath) async {
    // get connection to the database
    final db = await database;
    //insert  the filepath
    await db.insert(
      'filepath', // name of the table
      filepath.toMap(), // function created in model
      conflictAlgorithm: ConflictAlgorithm
          .replace, //this will replace duplicate in entry

    );
  }

  // function to fetch all todo from the database
  Future<List<Filepath>> getFilePathName() async {
    final db = await database ;
    // query the database and save the todo as list of maps
    List<Map<String, dynamic>> items = await db.query(
      'filepath',
      orderBy: 'id Desc', // this will order the list in descending order
    );

    // converting the items from lists of maps to list of todo
    return List.generate(
      items.length,
          (i) => Filepath(
        id: items[i]['id'], filepath  : items[i]['file'],
      ),
    );
  }
}
