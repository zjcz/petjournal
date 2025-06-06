// Helper methods for testing streams in Dart

// from solution at https://stackoverflow.com/questions/54025114/generate-a-stream-with-delays-for-each-emit-in-dart
Stream<T> streamDelayer<T>(Stream<T> inputStream, Duration delay) async* {
  await for (final val in inputStream) {
    await Future.delayed(delay);
    yield val;
  }
}

// Helper method to emit an original value in the stream, then after a delay update the value to the new value
Stream<T> streamWithUpdate<T>(
  T inputStream,
  T newValue,
  Duration delay,
) async* {
  {
    yield inputStream; // Emit the original value
    await Future.delayed(delay);
    yield newValue; // Emit the new value after the delay
  }
}
