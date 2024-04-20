import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('sample golden test', (WidgetTester tester) async {
    await loadAppFonts();
    const size = Size(415, 896);

    await tester.pumpWidgetBuilder(const Text('hogesample'), surfaceSize: size);

    await screenMatchesGolden(tester, 'myApp');
  });
}
