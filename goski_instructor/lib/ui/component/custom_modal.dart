import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;

  const CustomModal({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // contentPadding: const EdgeInsets.all(5.0),
      insetPadding: const EdgeInsets.all(20.0),
      titlePadding: const EdgeInsets.symmetric(vertical: 10.0),
      actionsPadding: const EdgeInsets.symmetric(vertical: 10.0),
      backgroundColor: goskiBackground,
      title: SizedBox(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: goskiBlack,
              thickness: 2,
            ),
          ],
        ),
      ),
      // titlePadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: onConfirm,
              child: const Text('벝은1'),
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('벝은2'),
            ),
          ],
        ),
      ],
    );
  }
}
