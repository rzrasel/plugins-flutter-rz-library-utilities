bool isNull(dynamic data) {
  const List nullValues = [null, '', 'null', 'Null', 'NULL'];

  if (data == null) return true;
  if (data is String) return nullValues.contains(data.trim());
  if (data is Map) return data.isEmpty;
  if (data is List) return data.isEmpty;
  if (data is Iterable) return data.isEmpty;
  return false;
}

dynamic setNull(dynamic data) {
  return isNull(data) ? null : data;
}

String setNA(dynamic data) {
  return isNull(data) ? "NA" : data.toString();
}