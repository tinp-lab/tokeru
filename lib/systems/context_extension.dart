import 'package:flutter/material.dart';
import 'package:quick_flutter/systems/date_time_format.dart';

extension BuildContextEx on BuildContext {
  DateTimeFormat get dateFormat {
    return DateTimeFormat();
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }
}
