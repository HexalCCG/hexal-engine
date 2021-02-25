/// Extension to merge two maps.
extension MapMerge<K, V> on Map<K, V> {
  /// Returns a new map with all key/value pairs in this and map.
  /// If there are keys that occur in both maps, the value function is used to select the value that goes into the resulting map based on the two original values. If value is omitted, the value from map2 is used.
  /// Modified from Flutter collection.
  Map<K, V> merge(Map<K, V> map, {V Function(V, V)? value}) {
    var result = Map<K, V>.from(this);
    if (value == null) return result..addAll(map);

    map.forEach((key, mapValue) {
      result[key] = result.containsKey(key)
          ? value(result[key] as V, mapValue)
          : mapValue;
    });
    return result;
  }
}
