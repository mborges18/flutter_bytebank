import 'package:flutter/material.dart';

class ButtonFilled extends StatelessWidget{

  final String textButton;
  final Function() functionClick;

  const ButtonFilled(this.textButton, {super.key, required this.functionClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: ElevatedButton(
        onPressed: () { functionClick(); },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            disabledBackgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            disabledForegroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            minimumSize: const Size.fromHeight(60),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        child: Text(textButton),
      ),
    );
  }
}