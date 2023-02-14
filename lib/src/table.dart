part of flutter_orm;

/// Facade for [FTable]
///
/// This class is used to define the table structure.
abstract class FTableFacade {
  /// Creates a table facade.
  const FTableFacade(this.columns);

  /// The columns of the table.
  final List<FColumnFacade> columns;

  /// The primary key of the table.
  FColumnFacade getPrimaryKey() {
    return columns.firstWhere((element) => element.isPrimaryKey);
  }

  /// Returns the column with the given name.
  FColumnFacade getColumn(String name) {
    return columns.firstWhere((element) => element.name == name);
  }

  /// Returns the name of the table.
  String get name => Intl.plural(2, other: runtimeType.toString());
}

/// A table in the database.
class FTable extends FTableFacade {
  /// Creates a table.
  FTable(
    List<FColumnFacade> columns, {
    /// The name of the table.
    String? name,
    Map<String, dynamic>? values,
  }) : super(columns) {
    _name = name;
  }

  /// The name of the table.
  String? _name;

  @override
  String get name => _name ?? super.name;

  /// maps the table to a map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    for (final FColumn column in columns) {
      map[column.name] = column.value;
    }
    return map;
  }

  @override
  List<FColumn> get columns => super.columns as List<FColumn>;
}
