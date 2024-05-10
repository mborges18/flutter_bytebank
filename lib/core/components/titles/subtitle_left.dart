import 'package:flutter/cupertino.dart';

class SubTitleLeft extends StatelessWidget {
  final String text;
  const SubTitleLeft({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(text,
          style:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
    );
  }
}
