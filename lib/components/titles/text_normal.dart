import 'package:flutter/cupertino.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ));
  }
}
