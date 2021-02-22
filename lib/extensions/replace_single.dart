/// Provides a method on Iterable to replace a single element in place.
extension ReplaceSingle<T> on Iterable<T> {
  /// Replaces [toReplace] in the iterable in place with [replacement] and returns
  /// the result.
  Iterable<T> replaceSingle(T toReplace, T replacement) {
    assert(any((element) => element == toReplace));
    return map((e) => e == toReplace ? replacement : e);
  }
}
