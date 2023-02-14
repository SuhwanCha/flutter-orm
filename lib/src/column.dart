part of flutter_orm;

/// The data type of a column.
///
/// The data type of a column is used to determine how to store the data in the
/// database. The data type is also used to determine how to convert the data
/// between Dart and the database.
///
/// The data type of a column is specified using the [FColumnFacade.dataType] property.
enum FDataType {
  /// The data type of a column that stores 64-bit signed integers.
  integer,

  /// The data type of a column that stores date values.
  date,

  /// The data type of a column that stores date and time values.
  datetime,

  /// The data type of a column that stores floating point numbers.
  real,

  /// The data type of a column that stores text.
  text,

  /// The data type of a column that stores binary data.
  blob,
}

abstract class FColumnFacade {
  FColumnFacade(this.name, this.dataType, {this.isPrimaryKey = false});

  final String name;
  final FDataType dataType;
  final bool isPrimaryKey;

  // toMap
  Map<String, dynamic> toMap();

  @override
  String toString() {
    return 'FColumn{name: $name, dataType: $dataType, isPrimaryKey: $isPrimaryKey}';
  }
}

class FColumn<T> extends FColumnFacade {
  FColumn(
    this.value,
    String name,
    FDataType dataType, {
    bool isPrimaryKey = false,
  }) : super(name, dataType, isPrimaryKey: isPrimaryKey);

  final T value;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{name: value};
  }
}
