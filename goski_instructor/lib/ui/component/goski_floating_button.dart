import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';

class GoskiFloatingButton extends StatelessWidget {
  final VoidCallback onTap;

  const GoskiFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      foregroundColor: goskiWhite,
      backgroundColor: goskiButtonBlack,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        size: 42,
      ),
    );
  }
}
