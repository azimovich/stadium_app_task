import 'package:flutter/material.dart' show Brightness, Color, ColorScheme, Colors;

import 'app_colors.dart';

const ColorScheme lightColorScheme = ColorScheme(
  primary: AppColors.c2AA64C,
  onPrimary: AppColors.c181725,
  primaryContainer: AppColors.white,
  onPrimaryContainer: AppColors.c4D3D0F,
//
  secondary: AppColors.cF7F7F7,
  onSecondary: AppColors.c181725,
  secondaryContainer: AppColors.c00AA5B,
  onSecondaryContainer: AppColors.c181725,
  secondaryFixed: Color(0xFFE0E0E0),
  onSecondaryFixed: AppColors.cB2B2B2,
//
  surface: AppColors.cEDEDED,
  onSurface: AppColors.c181725,
  surfaceContainer: AppColors.cFFDA69,
  onSurfaceVariant: AppColors.c4D3D0F,
//
  error: Colors.redAccent,
  onError: Colors.white,
  brightness: Brightness.light,
  outline: AppColors.cEDEDED,
);

const ColorScheme darkColorScheme = ColorScheme(
  primary: AppColors.c2AA64C,
  onPrimary: AppColors.white,
  primaryContainer: Color(0xff182747),
  onPrimaryContainer: AppColors.c4D3D0F,
//
  secondary: AppColors.cF7F7F7,
  onSecondary: AppColors.white,
  secondaryContainer: AppColors.c00AA5B,
  onSecondaryContainer: AppColors.c181725,
  secondaryFixed: AppColors.black,
  onSecondaryFixed: AppColors.cB2B2B2,
//
  surface: Color(0xff182747),
  onSurface: AppColors.c181725,
  surfaceContainer: AppColors.cFFDA69,
  onSurfaceVariant: AppColors.c4D3D0F,
//
  error: Colors.redAccent,
  onError: Colors.white,
  brightness: Brightness.dark,
);
