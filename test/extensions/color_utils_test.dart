import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/extensions/color_utils.dart';

/// Taken from the solution posted here: https://stackoverflow.com/questions/79278159/warnings-after-upgrading-to-flutter-3-27-0-value-and-green-are-deprecated
void main() {
  group('ColorUtils', () {
    test('toInt converts Color to int correctly', () {
      const color = Color.fromARGB(255, 255, 0, 0); // Red color
      final colorInt = color.toInt();
      expect(colorInt, 0xFFFF0000);
    });

    test('toInt converts Color with transparency to int correctly', () {
      const color = Color.fromARGB(
        128,
        0,
        255,
        0,
      ); // Semi-transparent green color
      final colorInt = color.toInt();
      expect(colorInt, 0x8000FF00);
    });

    test('toInt converts Color with no transparency to int correctly', () {
      const color = Color.fromARGB(255, 0, 0, 255); // Blue color
      final colorInt = color.toInt();
      expect(colorInt, 0xFF0000FF);
    });

    test('toInt converts Color with full transparency to int correctly', () {
      const color = Color.fromARGB(
        0,
        255,
        255,
        255,
      ); // Fully transparent white color
      final colorInt = color.toInt();
      expect(colorInt, 0x00FFFFFF);
    });

    test('toInt converts Color to int matches .value', () {
      const color = Color.fromARGB(
        128,
        0,
        255,
        0,
      ); // Semi-transparent green color
      final colorInt = color.toInt();
      expect(colorInt, color.value);
    });
  });
}
