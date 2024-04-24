
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../util/string/strings.dart';

class ButtonSwitch extends StatefulWidget {
  const ButtonSwitch({super.key, required this.onChecked, required this.onCheckedListener});

  final bool onChecked;
  final Function(bool) onCheckedListener;

  @override
  State<ButtonSwitch> createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: widget.onChecked,
              onChanged: (value) {
                widget.onCheckedListener(value);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(titleKeepConnected,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            )
          ],
        ));
  }
}

