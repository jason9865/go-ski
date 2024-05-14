import 'package:flutter/material.dart';
import 'package:goski_student/main.dart';

class BuildInterval extends StatelessWidget {
  const BuildInterval({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.016),
    );
  }
}
