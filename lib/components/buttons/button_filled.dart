import 'package:flutter/material.dart';

class ButtonFilled extends StatelessWidget {
  final String textButton;
  final bool isEnabled;
  final Function() functionClick;

  const ButtonFilled(
      {super.key,
      required this.textButton,
      required this.isEnabled,
      required this.functionClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: ElevatedButton(
        onPressed: isEnabled ? functionClick : null,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            disabledBackgroundColor:
                Theme.of(context).colorScheme.surfaceVariant,
            disabledForegroundColor:
                Theme.of(context).colorScheme.onSurfaceVariant,
            minimumSize: const Size.fromHeight(60),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        child: Text(textButton),
      ),
    );
  }
}
