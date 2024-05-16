import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/util/theme/theme_constants.dart';
import '../../../util/string/strings.dart';

class ButtonSwitch extends StatefulWidget {
  final bool onChecked;
  final Function(bool) onCheckedListener;

  const ButtonSwitch({
    super.key,
    required this.onChecked,
    required this.onCheckedListener,
  });

  @override
  State<ButtonSwitch> createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  bool onChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            CupertinoSwitch(
              activeColor: context.isDarkMode ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.primary,
              trackColor: context.isDarkMode ? Theme.of(context).colorScheme.surfaceVariant : Theme.of(context).colorScheme.surfaceVariant,
              value: widget.onChecked,
              onChanged: (value) {
                setState(() {
                  onChecked = value;
                });
                widget.onCheckedListener(value);
              },
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(titleKeepConnected,
                  style: TextStyle(
                      color: onChecked
                          ? Theme.of(context).colorScheme.onSurface
                          : context.isDarkMode
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            )
          ],
        ));
  }
}


