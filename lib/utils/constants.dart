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

const kNumberImages = {
  1: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/1.png',
  2: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/2.png',
  3: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/3.png',
  4: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/4.png',
  5: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/5.png',
  6: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/6.png',
  7: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/7.png',
  8: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/8.png',
  9: 'httpshttps://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/9.png',
  10: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/10.png',
  11: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/11.png',
  12: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/12.png',
  13: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/13.png',
  14: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/14.png',
  15: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/15.png',
  16: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/16.png',
  17: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/17.png',
  18: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/18.png',
  19: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/19.png',
  20: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/20.png',
  21: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/21.png',
  22: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/22.png',
  23: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/23.png',
  24: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/24.png',
  25: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/25.png',
  26: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/26.png',
  27: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/27.png',
  28: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/28.png',
  29: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/29.png',
  30: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/30.png',
  31: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/31.png',
  32: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/32.png',
  33: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/33.png',
  34: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/34.png',
  35: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/35.png',
  36: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/36.png',
  37: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/37.png',
  38: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/38.png',
  39: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/39.png',
  40: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/40.png',
  41: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/41.png',
  42: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/42.png',
  43: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/43.png',
  44: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/44.png',
  45: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/45.png',
  46: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/46.png',
  47: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/47.png',
  48: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/48.png',
  49: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/49.png',
  50: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/50.png',
  51: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/51.png',
  52: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/52.png',
  53: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/53.png',
  54: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/54.png',
  55: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/55.png',
  56: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/56.png',
  57: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/57.png',
  58: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/58.png',
  59: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/59.png',
  60: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/60.png',
  61: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/61.png',
  62: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/62.png',
  63: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/63.png',
  64: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/64.png',
  65: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/65.png',
  66: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/66.png',
  67: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/67.png',
  68: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/68.png',
  69: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/69.png',
  70: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/70.png',
  71: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/71.png',
  72: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/72.png',
  73: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/73.png',
  74: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/74.png',
  75: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/75.png',
  76: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/76.png',
  77: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/77.png',
  78: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/78.png',
  79: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/79.png',
  80: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/80.png',
  81: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/81.png',
  82: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/82.png',
  83: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/83.png',
  84: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/84.png',
  85: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/85.png',
  86: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/86.png',
  87: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/87.png',
  88: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/88.png',
  89: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/89.png',
  90: 'https://raw.githubusercontent.com/mlmodena/bingo/refs/heads/master/pics/90.png',
};

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
