import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';

class GoskiCard extends StatelessWidget {
  final Widget? child;

  const GoskiCard({
    super.key,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: goskiWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        elevation: 2,
        shadowColor: goskiLightGray,
        clipBehavior: Clip.hardEdge,
        child: child,
      ),
    );
  }
}
