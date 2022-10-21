import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget{

  final String textButton;
  final Function() functionClick;

  ButtonText(this.textButton, {required this.functionClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: ElevatedButton(
        onPressed: () { functionClick(); },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        child: Text(textButton),
      ),
    );
  }
}