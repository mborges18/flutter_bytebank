import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget{

  final String textButton;
  final Function() functionClick;

  const ButtonOutline(this.textButton, {super.key, required this.functionClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: OutlinedButton(
        onPressed: () { functionClick(); },
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            disabledForegroundColor: Theme.of(context).colorScheme.surfaceVariant,
            minimumSize: const Size.fromHeight(60),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        child: Text(textButton),
      ),
    );
  }
}