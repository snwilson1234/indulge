import 'dart:ui';

import 'package:flutter/cupertino.dart';

// Application theme colors and styles

const indulgePrimary = Color.fromRGBO(252, 162, 114, 1);
const indulgePrimaryInactive = const Color.fromARGB(255, 253, 209, 185);
const indulgeSecondary = Color.fromRGBO(103, 47, 16, 1);

const CupertinoThemeData indulgeTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: indulgePrimary,
  applyThemeToAll: true,
  primaryContrastingColor: indulgeSecondary
);