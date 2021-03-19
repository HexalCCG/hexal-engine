/// Provides a method on Iterable to count duplicate objects.
extension MaxDuplicates<T> on Iterable<T> {
  /// Returns the count of the most common duplicate in the iterable.
  int maxDuplicates([Object? Function(T)? factor]) {
    late final Iterable<Object?> process;
    if (factor == null) {
      process = this;
    } else {
      process = map(factor);
    }

    final result = <Object?, int>{};

    for (var element in process) {
      if (result.containsKey(element)) {
        result.update(element, (value) => value + 1);
      } else {
        result[element] = 1;
      }
    }

    // Return the max value;
    return result.values.reduce((curr, next) => curr > next ? curr : next);
  }
}
