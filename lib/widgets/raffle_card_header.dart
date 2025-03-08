import 'package:flutter/material.dart';

class RaffleCardHeader extends StatelessWidget {
  const RaffleCardHeader({
    Key? key,
    required this.onTapAdd,
    this.canAddTables = true,
  }) : super(key: key);

  final VoidCallback onTapAdd;
  final bool canAddTables;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: const Text(
        'Tabelle',
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      pinned: true,
      collapsedHeight: kToolbarHeight,
      expandedHeight: kToolbarHeight,
      actions: canAddTables ? [
        IconButton(
          onPressed: onTapAdd,
          icon: const Icon(Icons.add),
        ),
      ] : null,
    );
  }
}
