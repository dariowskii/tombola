import 'package:flutter/material.dart';

class LastExtractedNumber extends StatelessWidget {
  const LastExtractedNumber({Key? key, required this.lastExtractedNumber})
      : super(key: key);

  final int lastExtractedNumber;

  @override
  Widget build(BuildContext context) {
    final text =
        lastExtractedNumber == 0 ? '??' : lastExtractedNumber.toString();

    return SliverAppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Ultimo numero estratto',
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      pinned: true,
      collapsedHeight: 100,
      expandedHeight: 100,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Center(child: Text(text, style: const TextStyle(fontSize: 48))),
      ),
    );
  }
}
