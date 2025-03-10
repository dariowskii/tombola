import 'package:flutter/material.dart';
import 'package:tombola/utils/extensions.dart';

class ActiveGameBadge extends StatelessWidget {
  const ActiveGameBadge({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? Colors.green : Colors.redAccent;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Text(
        isActive ? 'Attiva' : 'Non attiva',
        style: context.textTheme.labelLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
