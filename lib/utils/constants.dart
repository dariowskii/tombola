import 'package:flutter/material.dart';
import 'package:tombola/utils/extensions.dart';

const kRaffleCardRowNumber = 3;
const kRaffleCardColumnNumber = 9;
const kRaffleCardSize = 30;

const kMaxExtractableNumbers = 90;

Color kLastExtractedColor(BuildContext context) =>
    context.isDarkMode ? Colors.greenAccent : Colors.green;

final kExtractableNumbers = List.generate(
  kMaxExtractableNumbers,
  (index) => index + 1,
  growable: false,
);

// ASSETS

enum AssetMedia {
  welcomeBackground('assets/img/welcome_bg.jpg'),
  mlModenaLogo('assets/img/ml_modena_logo.png');

  const AssetMedia(this.path);
  final String path;
}

// SPACING

enum Spacing {
  small(8.0),
  medium(16.0),
  large(24.0);

  const Spacing(this.value);
  final double value;

  SizedBox get h => SizedBox(height: value);
  SizedBox get w => SizedBox(width: value);
}
