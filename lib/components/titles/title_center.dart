import 'package:flutter/material.dart';
import '../../util/string/strings.dart';

class TitleCenter extends StatelessWidget {
  final String text;
  final IconData? icon;

  const TitleCenter({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 26),
          Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Text(text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 26.0)))
        ]));
  }
}
