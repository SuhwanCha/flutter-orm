part of flutter_orm;

class FDBInstance {
  const FDBInstance({
    this.fileName,
    this.version,
    this.onCreate,
  });

  final String? fileName;
  final int? version;
  final FutureOr<void> Function(Database, int)? onCreate;
}

// class that helps to use SQLITE
class FDB {
  static Database? _db;

  static Future<Database> get db async {
    if (_instance != null) {
      _db ??= await openDatabase(
        _instance!.fileName ?? 'flutter_orm.db',
        version: _instance!.version ?? 1,
        onCreate: _instance!.onCreate,
      );
      return _db!;
    } else {
      _db ??= await openDatabase(
        'flutter_orm.db',
        version: 1,
      );
    }
    return _db!;
  }

  static FDBInstance? _instance;

  static FDBInstance get instance {
    _instance ??= const FDBInstance();
    return _instance!;
  }

  static set instance(FDBInstance instance) {
    _instance = instance;
  }

  static Future<int> insert(FTable table) async {
    final Database db = await FDB.db;
    return await db.insert(table.name, table.toMap());
  }
}
