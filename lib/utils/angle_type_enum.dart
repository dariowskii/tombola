import 'package:flutter/material.dart';

enum AngleType {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  none;

  static AngleType fromNumber(int number) => switch (number) {
        1 => AngleType.topLeft,
        10 => AngleType.topRight,
        81 => AngleType.bottomLeft,
        90 => AngleType.bottomRight,
        _ => AngleType.none,
      };

  static AngleType fromRaffleCardIndex(int index) => switch (index) {
        0 => AngleType.topLeft,
        8 => AngleType.topRight,
        18 => AngleType.bottomLeft,
        26 => AngleType.bottomRight,
        _ => AngleType.none,
      };

  BorderRadius get borderRadius => switch (this) {
        AngleType.topLeft => const BorderRadius.only(
            topLeft: Radius.circular(8),
          ),
        AngleType.topRight => const BorderRadius.only(
            topRight: Radius.circular(8),
          ),
        AngleType.bottomLeft => const BorderRadius.only(
            bottomLeft: Radius.circular(8),
          ),
        AngleType.bottomRight => const BorderRadius.only(
            bottomRight: Radius.circular(8),
          ),
        AngleType.none => BorderRadius.zero,
      };
}
